#Code for constructing repeated count models of the O. maccani data (single season N-mixture models originally done in PRESENCE)

#--- load required packages ---#

library(unmarked) #NB primary reference for this package is Fiske and Chandler (2011)

#--- Import and organize data - single- and multi-season models ---#

lizards<-read.csv(file=file.choose(),header=T) #file is Lizard_detections.csv - same version as on GitHub
surv.cov<-read.csv(file=file.choose(),header=T) #file is Survey_covariates.csv - same version as on GitHub

# names(lizards)
# [1]  "Row_ID"           "Year"             "Survey_number"   
# [4]  "Stack_ID"         "OM"               "OaP"             
# [7]  "WaM"              "Life_stage"       "Detection_method"
# [10] "Notes"   

#rearrange lizard data into repeated counts format
lizardsrp <- tapply(lizards$OM,list(lizards$Stack_ID,lizards$Survey_number),sum)
lizardsrp[is.na(lizardsrp)] <- 0 #replace "NA" values with 0

##--- For single-season models ---##

#Group data by year
lizards2015<-lizardsrp[,1:6]
lizards2016<-lizardsrp[,7:12]
lizards2017<-lizardsrp[,13:21]

#Check groupings (optional)
#head(lizards2015)
#head(lizards2016)
#head(lizards2017)

#Extract relevant survey covariates for each year and make into a matrix with M rows x J columns

# names(surv.cov)
# [1] "Survey_number" "Year"          "Date"          "Start_time"   
# [5] "End_time"      "PM"            "Temperature"   "Cloud"        
# [9] "Wind"          "Rain_24"       "Rain_during"   "Weather_notes"

surv2015<-surv.cov[surv.cov$Year=="2015",1:11]
surv2016<-surv.cov[surv.cov$Year=="2016",1:11]
surv2017<-surv.cov[surv.cov$Year=="2017",1:11]

TOD2015<-t(matrix(replicate(10,surv2015$PM),nrow=6))
TOD2016<-t(matrix(replicate(10,surv2016$PM),nrow=7))
TOD2016<-TOD2016[,1:6] #We need to remove the last column because nothing caught during survey 7
TOD2017<-t(matrix(replicate(10,surv2017$PM),nrow=9))

temp2015<-t(matrix(replicate(10,surv2015$Temperature),nrow=6))
temp2016<-t(matrix(replicate(10,surv2016$Temperature),nrow=7))
temp2016<-temp2016[,1:6] #We need to remove the last column because nothing caught during survey 7
temp2017<-t(matrix(replicate(10,surv2017$Temperature),nrow=9))

#unmarkedFramePCount gets the count data, site covariate data, and survey-specific covariate data into one matrix. 
#note that unmarked uses different functions to format data specifically for different model types 
#i.e. command for data frame construction needs to match the model being used

UMF2015 <- unmarkedFramePCount(lizards2015, siteCovs = NULL, obsCovs = list(TOD2015,temp2015))
UMF2016 <- unmarkedFramePCount(lizards2016, siteCovs = NULL, obsCovs = list(TOD2016,temp2016))
UMF2017 <- unmarkedFramePCount(lizards2017, siteCovs = NULL, obsCovs = list(TOD2017,temp2017))

#----run the models------#
#We use pcount to fit a Royle (2004) N-mixture model (single-season)

mod2015<-pcount(~ 1 + TOD2015 ~1,mixture = "P",UMF2015,K=30) #Poisson model - ideally k should be 30-50, but K > 6 is making R crash on my laptop
mod2016<-pcount(~ 1 + TOD2016 ~1,mixture = "P",UMF2016,K=30)
mod2017<-pcount(~ 1 + TOD2017 ~1,mixture = "P",UMF2017,K=30)

#use mixture = NB if you want to fit a negative binomial model instead

##--- For multi-year models (in development) ---##

# Use the 'lizardsrp' matrix as it is, no need to sub-set
# Extract relevant survey covariates and make into a matrix with M rows x JT columns
# Where T = number of primary periods (here, this is 'Year')

# names(surv.cov)
# [1] "Survey_number" "Year"          "Date"          "Start_time"   
# [5] "End_time"      "PM"            "Temperature"   "Cloud"        
# [9] "Wind"          "Rain_24"       "Rain_during"   "Weather_notes"

TOD<-t(matrix(replicate(10,surv.cov$PM),nrow=22))
TODr<-TOD[,c(1:12,14:22)] #We need to remove column 13, because nothing caught during survey 7 in 2016
#There's probably a more elegant way to do this than my messy column indexing approach

#Do the same for any other covariates you want to use
temp<-t(matrix(replicate(10,surv.cov$Temperature),nrow=22))
tempr<-temp[,c(1:12,14:22)]

UMFlizards <- unmarkedFramePCO(lizardsrp, siteCovs = NULL, obsCovs = list(TODr,tempr))# to finish

#--- run the models  ---#
#We use pcountOpen to fit a multi-season extension of the Royle (2004) N-mixture model (Dail & Madsen 2011)
m1 <- pcountOpen(~1, ~1, ~1, ~1, UMFlizards, K=30,dynamics="trend",method="Nelder-Mead")
