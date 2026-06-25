#' Relative Frobenius Error
#' 
#' Computes the relative Frobenius error between an estimated covariance matrix and the ground truth.
#' 
#' @details 
#' The relative Frobenius error is given by: 
#' \deqn{\dfrac{\|\boldsymbol{A} - \boldsymbol{B}\|_F}{\|\boldsymbol{B}\|_F}=\dfrac{\sqrt{\sum\limits_{i=1}^{p}\sum\limits_{j=1}^{p}|[\boldsymbol{A}]_{ij}-[\boldsymbol{B}]_{ij}|^2}}{\sqrt{\sum\limits_{i=1}^{p}\sum\limits_{j=1}^{p}|[\boldsymbol{B}]_{ij}|^2}},}
#' where \eqn{\boldsymbol{A}} and \eqn{\boldsymbol{B}} are the estimated and ground truth covariance matrices, respectively.
#' 
#' @param est_cov Estimated covariance matrix.
#' @param ground_truth_cov Ground truth covariance matrix.
#' @return Frobenius error between the two matrices.
#' @export
frobenius_error <- function(est_cov, ground_truth_cov) {
  return(sqrt(sum((est_cov - ground_truth_cov)^2))/sqrt(sum((ground_truth_cov)^2)))
}

#' Angle Error
#' 
#' Computes the angle error between eigenvalues of the estimated covariance matrix and of the ground truth covariance matrix.
#' 
#' @details
#' The angle error is given by:
#' \deqn{1-\dfrac{\hat{\boldsymbol{a}}^\top\boldsymbol{a}}{\sqrt{\hat{\boldsymbol{a}}^\top\hat{\boldsymbol{a}}}\sqrt{\boldsymbol{a}^\top\boldsymbol{a}}},}
#' where \eqn{\hat{\boldsymbol{a}}} and \eqn{\boldsymbol{a}} are the eigenvalues of the estimated and ground truth covariance matrices, respectively.
#' 
#' @param est_cov Estimated covariance matrix.
#' @param ground_truth_cov Ground truth covariance matrix.
#' @return Angle error between eigenvalues.
#' @export
angle_error <- function(est_cov, ground_truth_cov){
    a_est <- sort(eigen(est_cov, symmetric = TRUE, only.values = TRUE)$values)
    a <- sort(eigen(ground_truth_cov, only.values = TRUE)$values)

    return(as.numeric(1-(t(a_est)%*%a)/(sqrt(t(a_est)%*%a_est)*sqrt(t(a)%*%a))))
}

#' Kullback-Leibler (KL) Divergence
#' 
#' Computes the Kullback-Leibler (KL) divergence between an estimated covariance matrix and the ground truth. Assumes normal multivariate distributions.
#' 
#' @details
#' The KL divergence between two \eqn{p}-dimensional Gaussians \eqn{\mathcal{N}(\boldsymbol{\mu}, \hat{\boldsymbol{\Sigma}})} and \eqn{\mathcal{N}(\boldsymbol{\mu}, \boldsymbol{\Sigma})} is given by:
#' \deqn{\dfrac{1}{2}\left(\text{tr}(\boldsymbol{\Sigma}^{-1}\hat{\boldsymbol{\Sigma}}) + \log\left(\dfrac{\det(\boldsymbol{\Sigma})}{\det(\hat{\boldsymbol{\Sigma}})}\right) - p\right),}
#' where \eqn{\hat{\boldsymbol{\Sigma}}} and \eqn{\boldsymbol{\Sigma}} are the estimated and ground truth covariance matrices, respectively.
#' 
#' @param est_cov Estimated covariance matrix.
#' @param ground_truth_cov Ground truth covariance matrix.
#' @return KL divergence between the two matrices.
#' @references Yufeng Zhang, Wanwei Liu, Zhenbang Chen, Ji Wang, and Kenli Li. On the properties of Kullback-Leibler divergence between multivariate gaussian distributions, 2023. \url{https://arxiv.org/abs/2102.05485}
#' @export
KL_divergence <- function(est_cov, ground_truth_cov) {
    if (det(est_cov) <= 0 || det(ground_truth_cov) <= 0) {
        stop("Covariance matrices must be positive definite.")
    }
    S <- est_cov %*% solve(ground_truth_cov)
    return(sum(diag(S))-log(det(S))-nrow(ground_truth_cov))
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
#' @export
#' @examples
#' ground_truth <- c(rep(1, 10), rep(0, 5))
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