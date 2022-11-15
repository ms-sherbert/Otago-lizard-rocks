#--- Import and organize data - single-season N-mixture models ---#

getwd() # check location of working directory (if needed)
# Use "setwd()" if you need to change location of working directory

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

#Group data by year
lizards2015<-lizardsrp[,1:6]
lizards2016<-lizardsrp[,7:12]
lizards2017<-lizardsrp[,13:21]

#Check groupings (optional)
head(lizards2015)
head(lizards2016)
head(lizards2017)

write.csv(lizards2015,file="2015-lizards.csv")
write.csv(lizards2016,file="2016-lizards.csv")
write.csv(lizards2017,file="2017-lizards.csv")

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

write.csv(TOD2015,file="2015-TOD.csv")
write.csv(TOD2016,file="2016-TOD.csv")
write.csv(TOD2017,file="2017-TOD.csv")

temp2015<-t(matrix(replicate(10,surv2015$Temperature),nrow=6))
temp2016<-t(matrix(replicate(10,surv2016$Temperature),nrow=7))
temp2016<-temp2016[,1:6] #We need to remove the last column because nothing caught during survey 7
temp2017<-t(matrix(replicate(10,surv2017$Temperature),nrow=9))

write.csv(temp2015,file="2015-temp.csv")
write.csv(temp2016,file="2016-temp.csv")
write.csv(temp2017,file="2017-temp.csv")

