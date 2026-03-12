library(reshape2)
library(ggplot2)
source("./simulations/IMCD_sim_setup.r")

############################################################################################################################
# LatentCase c("U_id_symmetric", "General")
Case <- "U_id_symmetric"
# Outliers scenarios c("mu_c","mu_r","mu_cr")
scenario <- "mu_c"
# Correlation structure between variables c("uncorrelated", "correlated")
Corr <- "uncorrelated"
############################################################################################################################

# Construct filename based on selected parameters
filename <- paste0(Case, "_", scenario, "_", Corr)

# Load results
result <- readRDS(paste0("./simulations/", filename, ".rds"))

# Reshape data for plotting
metrics_data <- do.call(rbind, lapply(names(result), function(Distance) {
  do.call(rbind, lapply(names(result[[Distance]]), function(N) {
    do.call(rbind, lapply(names(result[[Distance]][[N]]), function(P) {
      do.call(rbind, lapply(names(result[[Distance]][[N]][[P]]), function(epsilon) {
        do.call(rbind, lapply(names(result[[Distance]][[N]][[P]][[epsilon]]), function(cutoff) {
          do.call(rbind, lapply(names(result[[Distance]][[N]][[P]][[epsilon]][[cutoff]]), function(m_value) {
            data.frame(
              Distance = Distance,
              N = as.numeric(N),
              P = as.numeric(P),
              epsilon = as.numeric(epsilon),
              cutoff = cutoff,
              M = m_value,
              result[[Distance]][[N]][[P]][[epsilon]][[cutoff]][[m_value]]
            )
          }))
        }))
      }))
    }))
  }))
}))

melted_metrics_data <- melt(metrics_data, id.vars = c("Distance", "N", "P", "epsilon", "cutoff", "M"))

# Log KL Divergence
melted_metrics_data[which(melted_metrics_data$variable=="KL.Divergence"),8] <- log(melted_metrics_data[which(melted_metrics_data$variable=="KL.Divergence"),8])

# Set Pr(1) to NA for epsilon=0, as there are no outliers in this case
melted_metrics_data[which(melted_metrics_data$variable=="Precision"&melted_metrics_data$epsilon==0),8] <- NA

# Rename variables
melted_metrics_data$variable <- as.character(melted_metrics_data$variable)
melted_metrics_data[which(melted_metrics_data$variable=="KL.Divergence"),7] <- "Log(KL.Divergence)"
melted_metrics_data[which(melted_metrics_data$variable=="NPV"),7] <- "Pr(0)"
melted_metrics_data[which(melted_metrics_data$variable=="Specificity"),7] <- "Re(0)"
melted_metrics_data[which(melted_metrics_data$variable=="Precision"),7] <- "Pr(1)"
melted_metrics_data[which(melted_metrics_data$variable=="Recall"),7] <- "Re(1)"
melted_metrics_data$variable <- factor(melted_metrics_data$variable)

# Remove rows with NA values
melted_metrics_data <- na.omit(melted_metrics_data)

# List of metrics to plot
metrics <- c("Pr(1)", "Pr(0)", "Re(1)", "Re(0)", "Gmean", "F1", "Accuracy", "AUC",
              "Frobenius.Error", "Angle.Error", "Log(KL.Divergence)")

# Create boxplots for each metric
lapply(metrics, function(metric){create_boxplot(melted_metrics_data, metric, filename)})

create_boxplot(melted_metrics_data, "Recall", filename)