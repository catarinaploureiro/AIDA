library(AIDA)
library(mvtnorm)
source("./simulations/IMCD_sim_setup.r")

# Set the seed for reproducibility
set.seed(13)

############################################################################################################################
# Number of repetitions
T <- 500
# Number of data points c(500,1000)
N_values <- c(500,1000)
# Number of variables c(5,20)
P_values <- c(5,20)
# Contamination levels c(0, 0.05, 0.1, 0.2)
EPSILONS <- c(0, 0.05, 0.1, 0.2)
# LatentCase c("U_id_symmetric", "General")
Case <- "U_id_symmetric"
# Outliers scenarios c("mu_c","mu_r","mu_cr")
scenario <- "mu_c"
# Correlation structure between variables c("uncorrelated", "correlated")
Corr <- "uncorrelated"
############################################################################################################################

result <- list()

for (Distance in c("IMah", "Mallows")) {
    for (N in N_values) {
        # Subset size
        M <- floor(0.75*N)
        if (Distance == "Mallows") {
            m_values <- c(N)
        } else {
            m_values <- c(M, N)
        }

        for (P in P_values) {
            print(paste0(">>>>>Initializing new combination: N = ", N, ", P = ", P))

            #centers
            mu.c <- rep(0,P)
            sigma.cc <- (1:P)^2/(P*4/3)^2

            #ranges
            mu.r <- rep(3,P)
            sigma.rr <- (1:P)^2/(P*4/3)^2

            cor_fim <- diag(2*P)
            for (i in 1:P) {
                cor_fim[i, i+P] <- ifelse(i %% 2 == 1, 0.1, -0.1)
                cor_fim[i+P, i] <- ifelse(i %% 2 == 1, 0.1, -0.1)
            }
            if(Corr=="correlated"){
                cor_fim[1,2] <- cor_fim[2,1] <- 0.8 #C_1 and C_2
                cor_fim[1,2+P] <- cor_fim[2+P,1] <- 0.1 #C_1 and R_2
                cor_fim[2,1+P] <- cor_fim[1+P,2] <- 0.1 #C_2 and R_1
                cor_fim[1+P,2+P] <- cor_fim[2+P,1+P] <- 0.8 #R_1 and R_2
            }

            D <- diag(sqrt(c(sigma.cc,sigma.rr)))
            cov_fim <- D%*%cor_fim%*%D
            sigma.cr <- cov_fim[1:P,(P+1):(2*P)]
            sigma.cc <- cov_fim[1:P,1:P]
            sigma.rr <- cov_fim[(P+1):(2*P),(P+1):(2*P)]

            if(Case=="U_id_symmetric"){
                DELTA<-1/24#1/12
                latent_dist <- "Triang"#"Unif"
                latent_param <- list(DELTA)
            }else {
                mo <- runif(P,-0.5,-0.2)
                latent_dist <- "Triang"
                latent_param <- get_latent_param(LatentCase = Case, LatentDist = latent_dist, TriangParam = mo, p=P)$LatentParam
            }
            ground_truth_cov <- int_cov(sigma_cc = sigma.cc, sigma_rr = sigma.rr, sigma_cr = sigma.cr, LatentParam = latent_param, LatentCase = Case)

            # Generate datasets
            datasets <- replicate(T, {
                CR <- rmvnorm(N,mean=c(mu.c,mu.r),sigma=cov_fim)
            }, simplify = FALSE)

            for (epsilon in EPSILONS) {
                print(paste0("epsilon = ", epsilon))
                n_outliers <- round(epsilon * N)
                ground_truth_outliers <- c(rep(0, N - n_outliers), rep(1, n_outliers))
                result[[as.character(N)]][[as.character(P)]][[as.character(epsilon)]] <- list()
                
                # Contaminate datasets
                contaminated_datasets <- lapply(datasets, function(data) {
                    if (epsilon != 0) {
                        if(scenario=="mu_c"){
                            contaminated.mu.c <- mu.c
                            contaminated.mu.c[1] <- contaminated.mu.c[1]+2
                            cont_CR <- rmvnorm(n_outliers,mean = c(contaminated.mu.c,mu.r),sigma = cov_fim)
                        }else if (scenario=="mu_r") {
                            contaminated.mu.r <- mu.r
                            contaminated.mu.r[1] <- contaminated.mu.r[1]+5
                            cont_CR <- rmvnorm(n_outliers,mean = c(mu.c,contaminated.mu.r),sigma = cov_fim)
                        }else if (scenario=="mu_cr") {
                            contaminated.mu.c <- mu.c
                            contaminated.mu.r <- mu.r
                            contaminated.mu.c[1] <- contaminated.mu.c[1]+2
                            contaminated.mu.r[1] <- contaminated.mu.r[1]+5
                            cont_CR <- rmvnorm(n_outliers,mean = c(contaminated.mu.c,contaminated.mu.r),sigma = cov_fim)
                        }
                        data <- rbind(data[1:(N-n_outliers),],cont_CR)
                    }
                    # Ensure we did not generate negative ranges
                    data[,((P+1):(2*P))] <- abs(data[,((P+1):(2*P))])
                    assertthat::assert_that(sum(data[,((P+1):(2*P))] <= 0) == 0)
                    return(data)
                })
                
                for (m_value in m_values) {
                    print(paste0("M = ", m_value))
                    pb <- pb_new(T)
                    IMCD_raw_results <- lapply(contaminated_datasets, function(data) {
                        pb$tick()

                        dataset <- intData(data, Seq = "AllCen_AllRng", LatentParam = latent_param, LatentCase = Case, LatentDist = latent_dist)
                        if (Distance == "Mallows") {
                            IMCD_raw <- int_cov_Mallows(dataset)
                        } else {
                            IMCD_raw <- IMCD_raw(dataset, m = m_value)
                        }
                        
                        list(dataset = dataset, IMCD_raw = IMCD_raw)
                    }) 

                    for (cutoff in c("raw", "adjbox", "farness")) {

                        metrics <- sapply(IMCD_raw_results, function(results) {
                            IMCD_raw <- results$IMCD_raw
                            dataset <- results$dataset
                            
                            ifelse(m_value==N,
                                reweigth_IMCD <- IMCD_raw,
                                reweigth_IMCD <- reweight_IMCD(IMCD_raw$robust_dist, IMCD_raw$final_z, dataset, m = IMCD_raw$m, cutoff = cutoff)
                            )
                            
                            if(cutoff=="raw"||(m_value==N & cutoff=="farness")){
                                eval <- rep(NA, 12)
                                names(eval) <- c("Precision", "NPV", "Recall", 
                                                "Specificity", "Gmean", "F1", 
                                                "Accuracy", "AUC", "TP", "TN", 
                                                "FP", "FN")
                            }else {
                                outliers <- int_outliers(reweigth_IMCD$robust_dist, cutoff = cutoff, p=P, z=reweigth_IMCD$final_z)
                                eval <- evaluate_outlier_detection(as.numeric(outliers$is_outlier), ground_truth_outliers)
                            }
                            if((m_value==N && cutoff!="raw") || Distance=="Mallows"){
                                eval_cov <- rep(NA, 3)
                                names(eval_cov) <- c("Frobenius.Error", "Angle.Error", "KL.Divergence")
                            }else {
                                eval_cov <- compare_cov_matrix(reweigth_IMCD$cov_IMCD, ground_truth_cov)
                            }

                            return(c(eval, eval_cov))
                        })
                        
                        if (is.null(result[[Distance]][[as.character(N)]][[as.character(P)]][[as.character(epsilon)]][[as.character(cutoff)]])) {
                            result[[Distance]][[as.character(N)]][[as.character(P)]][[as.character(epsilon)]][[as.character(cutoff)]] <- list()
                        }
                        m_char <- ifelse(Distance=="Mallows",
                                        "Classic_Mallows",
                                        ifelse(m_value==N,"Classic","IMCD"))
                        result[[Distance]][[as.character(N)]][[as.character(P)]][[as.character(epsilon)]][[as.character(cutoff)]][[m_char]] <- t(metrics)
                        saveRDS(result, file = paste0("./simulations/", Case, "_", scenario, "_", Corr,".rds"))
                    }
                }
            }
        }
    }
}