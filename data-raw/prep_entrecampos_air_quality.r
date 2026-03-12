###
#----Entrecampos Air Quality----
# Data retrieved from the Portuguese Environment Agency database. 
# Available at \url{https://qualar.apambiente.pt/}.
# This script generates the dataset `entrecampos_air_quality.rda`.
###

library("readxl")
library("imputeTS")
library(AIDA)

## Preparing the dataset

#Import data & convert 1st column to date
entrecampos_2019<-as.data.frame(read_excel('./data-raw/Entrecampos_2019-01-01_2019-12-31.xlsx', 
                    col_types = c("text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric")))
entrecampos_2019[,1]<-as.POSIXct(entrecampos_2019[,1], format="%Y-%m-%d %H:%M:%S")

entrecampos_2020<-as.data.frame(read_excel('./data-raw/Entrecampos_2020-01-01_2020-12-31.xlsx', 
                    col_types = c("text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric")))
entrecampos_2020[,1]<-as.POSIXct(entrecampos_2020[,1], format="%Y-%m-%d %H:%M:%S")

entrecampos_2021<-as.data.frame(read_excel('./data-raw/Entrecampos_2021-01-01_2021-12-31.xlsx', 
                    col_types = c("text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric")))
entrecampos_2021[,1]<-as.POSIXct(entrecampos_2021[,1], format="%Y-%m-%d %H:%M:%S")

#Due to change to "summer time", clocks went forward from 01h to 02h, so as.POSIXct returns NA
entrecampos_2019[2138,1] <- as.POSIXct("2019-03-31 00:59:59", format="%Y-%m-%d %H:%M:%S")
entrecampos_2020[2114,1] <- as.POSIXct("2020-03-29 00:59:59", format="%Y-%m-%d %H:%M:%S")
entrecampos_2021[2066,1] <- as.POSIXct("2021-03-28 00:59:59", format="%Y-%m-%d %H:%M:%S")

#Create new column with Day
entrecampos_2019[,11]<-as.Date(entrecampos_2019[,1])
colnames(entrecampos_2019)[11]<-'Day'
entrecampos_2020[,11]<-as.Date(entrecampos_2020[,1])
colnames(entrecampos_2020)[11]<-'Day'
entrecampos_2021[,11]<-as.Date(entrecampos_2021[,1])
colnames(entrecampos_2021)[11]<-'Day'

#Append all 3 years into 1 data frame
entrecampos<-rbind(entrecampos_2019,entrecampos_2020,entrecampos_2021)

#Convert CO from mg/m3 to µg/m3
entrecampos[,6]<-1000*entrecampos[,6]

colnames(entrecampos)<-c("Timestamp", "Sulphur Dioxide (µg/m3)", "Particles < 10 µm (µg/m3)",
                    "Ozone (µg/m3)", "Nitrogen Dioxide (µg/m3)", "Carbon Monoxide (µg/m3)", "Benzene (µg/m3)",
                    "Particles < 2.5 µm (µg/m3)", "Nitrogen Oxides (µg/m3)", "Nitrogen Monoxide (µg/m3)","Day")

#Data transformation
entrecampos_log10<-entrecampos
entrecampos_log10<-entrecampos_log10[, -7] #Remove Benzene
entrecampos_log10[,2:9]<-log10(entrecampos_log10[,2:9]+1)

max_without_na <- function(x) {
  if (all(is.na(x))) {
    return(NA)
  } else {
    return(max(x, na.rm = TRUE))
  }
}

min_without_na <- function(x) {
  if (all(is.na(x))) {
    return(NA)
  } else {
    return(min(x, na.rm = TRUE))
  }
}

mean_without_na <- function(x) {
  mean(x, na.rm = TRUE)
}

#Aggregate the data with min, max and mean
entrecampos_log10_max<-aggregate(entrecampos_log10[,2:9], by=list(entrecampos_log10[,10]), FUN=max_without_na)
entrecampos_log10_min<-aggregate(entrecampos_log10[,2:9], by=list(entrecampos_log10[,10]), FUN=min_without_na)
entrecampos_log10_mean<-aggregate(entrecampos_log10[,2:9], by=list(entrecampos_log10[,10]), FUN=mean_without_na)

#Interpolation
entrecampos_log10_max_ma<-na_ma(entrecampos_log10_max, k=20, weighting = "linear")
entrecampos_log10_min_intp<-na_interpolation(entrecampos_log10_min, option="linear")
entrecampos_log10_mean_ma<-na_ma(entrecampos_log10_mean, k=20, weighting = "linear")

entrecampos_log10_minmax<-cbind(entrecampos_log10_min_intp,entrecampos_log10_max_ma[,-1])

entrecampos_log10 <- entrecampos_log10[, c("Timestamp","Day",sort(names(entrecampos_log10)[2:9]))]

colnames(entrecampos_log10_minmax)[1]<-"Day"
colnames(entrecampos_log10_minmax)[2:9] <- paste0("Min. ", colnames(entrecampos_log10_minmax)[2:9])
colnames(entrecampos_log10_minmax)[10:17] <- paste0("Max. ", colnames(entrecampos_log10_minmax)[10:17])
entrecampos_log10_minmax <- entrecampos_log10_minmax[, c("Day", sort(names(entrecampos_log10_minmax)[2:9]), sort(names(entrecampos_log10_minmax)[10:17]))]

entrecampos_U<-get_latent_var(entrecampos_log10[,3:10],entrecampos_log10_minmax[,-1],factor(entrecampos_log10[,2]),
                                levels(factor(entrecampos_log10[,2])),Seq="AllLb_AllUb")

entrecampos_colnames <- c("Carbon Monoxide", "Nitrogen Dioxide", "Nitrogen Monoxide", "Nitrogen Oxides", "Ozone", "Particles <10µm", "Particles <2.5µm", "Sulphur Dioxide")
entrecampos_log10_int<-intData(entrecampos_log10_minmax[,-1], Seq="AllLb_AllUb", 
                        LatentCase = "General", LatentDist = "KDE", Umicro = entrecampos_U,
                        ObsNames = as.character(entrecampos_log10_minmax[,1]),
                        VarNames = entrecampos_colnames)

entrecampos_air_quality <- list(
  microdata_raw = entrecampos,
  microdata_transformed = entrecampos_log10,
  min_max = entrecampos_log10_minmax,
  intData = entrecampos_log10_int
)

#save(entrecampos_air_quality, file = "./data/entrecampos_air_quality.rda")
usethis::use_data(entrecampos_air_quality, overwrite = TRUE)