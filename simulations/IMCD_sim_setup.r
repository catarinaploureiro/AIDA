#' IMCD Raw Estimation
#' 
#' Calculate the raw IMCD estimates and squared Interval-Mahalanobis distances.
#' 
#' @param data An object of class \code{intData}.
#' @param m Number of observations to use for the raw IMCD estimation. If 0, it will be set to \code{floor((n + p + 1) / 2)}, where n is the number of observations and p is the number of variables.
#' @return A list with the raw IMCD covariance matrix estimate, the squared Interval-Mahalanobis distances, the final z values, and the m value used.
#' @export
IMCD_raw <- function(data, m = 0){
    n <- data@NObs; p <- data@NIVar
    
    # Set m
    if (!m) {
        m <- floor(0.75*n)
    }
    
    # Call helper for big or small data
    if (m == n) {
        z <- rep(1, n)
        d2 <- IMah_dist(data=data,z=z)
        cov_IMCD <- int_cov_z(z, data)
    } else {
        if (n <= 600) {
            res <- AIDA:::smallIMCD(m, data)
        } else {
            res <- AIDA:::bigIMCD(m, p, n, data)
        }                        
        z <- res$updated_z
        d2 <- res$robust_dist
        cov_IMCD <- res$S
        #S <- median(d2) * res$S / qchisq(p = 0.5, df = p)
    }

    return(list("cov_IMCD"=cov_IMCD, "robust_dist"=d2, "final_z"=z, "m"=m))
}

#' One-step Reweighting of IMCD
#' 
#' Calculate the reweighted IMCD estimates based on the raw IMCD estimates and a specified cutoff method.
#' 
#' @param d2 Squared Interval-Mahalanobis distances from the raw IMCD estimation.
#' @param z Final z values from the raw IMCD estimation.
#' @param data An object of class \code{intData}.
#' @param m Number of observations used for the raw IMCD estimation.
#' @param cutoff Method to determine the cutoff for reweighting. Options are "farness", "adjbox", "chi-squared", "F-dist", and "raw". Default is "farness".
#' @param cutoff_lvl Cutoff level to determine the cutoff value. If NULL, default values will be used based on the cutoff method.
#' @return A list with the reweighted IMCD covariance matrix estimate, the final z values, the cutoff method used, the cutoff value, the reweighted squared Interval-Mahalanobis distances, and the farness probabilities if the "farness" cutoff method is used.
#' @export
reweight_IMCD <- function(d2, z, data, m=0, cutoff=c("farness","adjbox","chi-squared","F-dist","raw"), cutoff_lvl=NULL){
    cutoff<-match.arg(cutoff)
    C<-as.matrix(data@Centers)
    R<-as.matrix(data@Ranges)
    n <- data@NObs; p <- data@NIVar

    # Set m
    if (!m) {
        m <- floor(0.75*n)
    }

    if (is.null(cutoff_lvl)){
        cutoff_lvl <- switch(cutoff,
                            "chi-squared" = 0.975,
                            "adjbox" = 1.5,
                            "F-dist" = 0.975,
                            "farness" = 0.95,
                            0.975)
    }

    farness_probs <- NA

    # Reweight estimates
    if (cutoff=="chi-squared"){
        cutoff_value <- qchisq(cutoff_lvl, df = p)
        w <- ifelse(d2 <= cutoff_value, 1, 0)
    }else if (cutoff=="raw"){
        cutoff_value <- NA
        w <- z
    }else if (cutoff=="adjbox"){
        cutoff_value <- robustbase::adjboxStats(d2, coef=cutoff_lvl, doScale = FALSE)$fence
        w <- ifelse((d2 >= cutoff_value[1])&(d2 <= cutoff_value[2]), 1, 0)
    }else if (cutoff=="F-dist"){
        delta <- 1-cutoff_lvl
        #hrdf.method <- c("GM14","HR05")
        hr05 <- hr05CutoffMvnormal(n, p, m/n, delta)
        dfz <- hr05$m.pred - p + 1
        cutoff_value <- hr05$m.pred * p * qf(1 - delta, df1 = p, df2 = dfz) / dfz
        w <- ifelse(d2 <= cutoff_value, 1, 0)
    }else if(cutoff=="farness"){
        farness_results <- farness(d2, cutoff_value = cutoff_lvl)
        farness_probs <- farness_results$farness_probs
        cutoff_value <- farness_results$cutoff_value
        w <- ifelse(farness_probs <= cutoff_lvl, 1, 0)
    }

    reweighted_mu_c <- int_mean_z(w, C)
    reweighted_mu_r <- int_mean_z(w, R)
    reweighted_sigma <- int_cov_z(w, data)
    reweighted_d2 <- IMah_dist(data,mean_c=reweighted_mu_c,mean_r=reweighted_mu_r,cov=reweighted_sigma)
    names(w) <- rownames(data)

    return(list("mean_IMCD_c"=reweighted_mu_c, "mean_IMCD_r"=reweighted_mu_r, 
                "cov_IMCD"=reweighted_sigma, "final_z"=w, "cutoff"=cutoff,
                "cutoff_value"=cutoff_value, "robust_dist"=reweighted_d2, "farness_probs"=farness_probs))
}

#' Covariance Matrix Estimation and Mallows' Distances for Interval-Valued Data
#' 
#' @param data An object of class \code{intData}.
#' @return A list with the covariance matrix estimate (non robust), the Mallows' distances, and the final z values.
#' @export
int_cov_Mallows <- function(data){

    d2 <- Mallows_dist(data=data)
    cov_IMCD <- int_cov(data=data)

    return(list("cov_IMCD"=cov_IMCD, "robust_dist"=d2, "final_z"=rep(1,data@NObs)))
}

#' New Progress Bar
#' 
#' Create a new progress bar from package \code{progress}.
#' 
#' @param n Total number of ticks to complete.
#' @return  New progress bar. See package \code{progress}.
#' @importFrom progress progress_bar
#' @export
pb_new <- function(n){
    pb <- progress::progress_bar$new(format = " :current/:total (:percent) [Elapsed: :elapsedfull || ETA: :eta]",
                       total = n,
                       #complete = "=",   # Completion bar character
                       #incomplete = "-", # Incomplete bar character
                       #current = ">",    # Current bar character
                       clear = FALSE)    # If TRUE, clears the bar when finish
                       #width = 100)      # Width of the progress bar
    return(pb)
}

#' Compare Covariance Matrices
#' 
#' Computes the Frobenius error, angle error, and Kullback-Leibler (KL) divergence between an estimated covariance matrix and the ground truth. Assumes normal multivariate distributions.
#' 
#' @param est_cov Estimated covariance matrix.
#' @param ground_truth_cov Ground truth covariance matrix.
#' @return A vector with the evaluation metrics calculated.
#' @export
compare_cov_matrix <- function(est_cov, ground_truth_cov){
    result <- c(frobenius=frobenius_error(est_cov, ground_truth_cov),
                angle=angle_error(est_cov, ground_truth_cov),
                kl=KL_divergence(est_cov, ground_truth_cov))
    names(result) <- c("Frobenius Error", "Angle Error", "KL Divergence")
    return(result)
}

#' Classification Evaluation Metrics For Outlier Detection
#' 
#' Calculate classification evaluation metrics for outlier detection, namely: precision, negative predictive value (NPV), recall, specificity, geometric mean, F1 score, accuracy, area under the curve (AUC), true positives (TP), true negatives (TN), false positives (FP), false negatives (FN)
#' 
#' @param ground_truth A vector of 0 and 1, indicating the ground truth of which observations are outliers or not.
#' @param predictions A vector of 0 and 1, indicating the predictions of which observations are outliers or not.
#' @return A vector with the evaluation metrics calculated.
#' @importFrom caret confusionMatrix
#' @importFrom pROC roc
#' @export
#' @examples
#' ground_truth <- c(rep(1,10),rep(0,5))
#' predictions <- sample(ground_truth)
#' evaluate_outlier_detection(predictions, ground_truth)
evaluate_outlier_detection <- function(predictions, ground_truth) {
    predictions_factor <- factor(predictions, levels = c("0", "1"))
    ground_truth_factor <- factor(ground_truth, levels = c("0", "1"))

    cm <- caret::confusionMatrix(predictions_factor, ground_truth_factor, positive="1")
    gmean <- sqrt(cm$byClass["Recall"] * cm$byClass["Specificity"])

    if (length(unique(ground_truth)) < 2) {
        auc <- NA
    } else {
        auc <- pROC::roc(as.numeric(ground_truth == "1"), as.numeric(predictions == "1"), quiet=TRUE)$auc
    }
    
    result <- c(precision = cm$byClass["Precision"], 
                npv = cm$byClass["Neg Pred Value"], 
                recall = cm$byClass["Recall"], 
                specificity = cm$byClass["Specificity"], 
                gmean = gmean, 
                f1 = cm$byClass["F1"], 
                accuracy = cm$overall["Accuracy"], 
                auc = auc,
                tp = cm$table[2, 2],
                tn = cm$table[1, 1],
                fp = cm$table[1, 2],
                fn = cm$table[2, 1])
    
    names(result) <- c("Precision", "NPV", "Recall", 
                        "Specificity", "Gmean", "F1", 
                        "Accuracy", "AUC", "TP", "TN", 
                        "FP", "FN")
    return(result)
}

#' Create Boxplot for Evaluation Metrics
#'
#' Create a boxplot for a specified evaluation metric, faceted by the number of observations (N) and the number of variables (P), and colored by the combination of cutoff method and M value.
#' @param data A data frame containing the evaluation metrics, with columns for N, P, epsilon, cutoff, M, variable (metric name), and value (metric value).
#' @param metric The name of the evaluation metric to plot (e.g., "Precision", "Recall", "F1", "Frobenius Error").
#' @return A ggplot object representing the boxplot for the specified metric.
#' @import ggplot2
#' @export
create_boxplot <- function(data, metric, plot_title=NULL) {
    epsilon <- cutoff <- M <- value <- NULL  
    ggplot(data[data$variable == metric, ], 
           aes(x = factor(epsilon), y = value, fill = interaction(cutoff, M))) + 
        geom_boxplot() +
        labs(x = "Contamination ε", y = metric, fill = "cutoff.Classic/IMCD", title = plot_title) +
        facet_grid(N ~ P, labeller = label_both) +  # Facet for N and P
        geom_vline(aes(xintercept = as.numeric(factor(epsilon)) + 0.5), 
                   color = "white", linetype = "solid", size = 1) +  # Add separation lines
        theme(
            plot.title = element_text(size = 16, face = "bold"),   # Larger title font
            axis.title = element_text(size = 14, face = "bold"),   # Larger axis titles
            axis.text = element_text(size = 12),                   # Larger tick labels
            legend.title = element_text(size = 14),                # Larger legend title
            legend.text = element_text(size = 12),                 # Larger legend text
            strip.text = element_text(size = 14, face = "bold"),   # Larger facet labels
            panel.grid.major.x = element_blank(),  # Remove default vertical grid lines
            panel.grid.minor.x = element_blank(),   # Remove minor vertical grid lines
            legend.position = "bottom", # Position legend at the bottom
            legend.background = element_rect(fill = "gray92", color = NA) # Lighter background for legend
        ) + 
        scale_fill_manual(
          values = c(
            "adjbox.Classic" = "#F8766D",
            "adjbox.Classic_Mallows" = "#CD9600",
            "adjbox.IMCD" = "#7CAE00",
            "farness.IMCD" = "#00BFC4",
            "raw.Classic" = "#C77CFF",
            "raw.Classic_Mallows" = "#FF61CC",
            "raw.IMCD" = "#619CFF"
          )
        )
}