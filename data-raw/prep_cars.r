###
#----Cars----
# Data retrieved from the MAINT.Data package. 
# Available at \url{https://cran.r-project.org/web/packages/MAINT.Data/index.html}.
# This script generates the dataset `cars.rda`.
###

library(AIDA)

Cars <- MAINT.Data::Cars

Cars_log <- Cars
Cars_log$LB_Price<-log(Cars$LB_Price)
Cars_log$UB_Price<-log(Cars$UB_Price)
cars_int<-intData(Cars_log[,-9], Seq="LbUb_VarbyVar", VarNames = c("lnPrice","EngCap","Top Speed","Acceleration"))

intCars <- list(
  microdata = Cars,
  intData = cars_int
)

usethis::use_data(intCars, overwrite = TRUE)
