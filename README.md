# Otago-lizard-rocks

## Repository description
Data from the journal article Herbert S.M, Knox C., Clarke D., Bell T.P. (2023) Use of constructed rock piles by lizards in a grassland habitat in Otago, New Zealand. New Zealand Journal of Ecology 47(1): in press. While the analysis was performed in PRESENCE, there is also some code in this repository being developed to provide the option of analysing these data using the 'unmarked' package in R. 

## Abstract

The main drivers of lizard population declines in Aotearoa New Zealand are habitat loss and introduced predators. Therefore, habitat enhancement could be useful for mitigating declines, but there is little information on how Aotearoa’s lizards respond to these interventions. We examined whether novel habitats created by ten ~375 m3 constructed rock piles would be used by McCann’s skinks (*Oligosoma maccani*), southern grass skinks (*O.* aff. *polychroma* Clade 5), and kōrero geckos (*Woodworthia* “Otago/Southland large”). Increasing abundance and evidence of reproduction was observed in McCann’s skinks within 2.4 years following pile construction. Outcomes for the other species were unclear because two kōrero geckos were encountered and no reproduction of southern grass skinks was observed. These observations indicate that rock pile construction could create habitats for McCann’s skinks, but further inference is limited. We recommend that future mitigation programs quantify how habitat construction affects lizard populations and suggest methods for achieving this.   

## Repository contents

`Data_manipulation.r` R code for manipulating the data in the two .csv files into the formats required by programme PRESENCE.

`Lizard_detections.csv` Repeated count data for lizards detected on the rock piles.

`Repeated count model script.r` In development. Options for analysing the data in the unmarked R package. 

`Survey_covariates` Survey-specific covariate data. 

`Wald_CI_calcs.r` R code used to calculate Wald 95% confidence intervals for model-averaged lambda (local abundance) values. 

## Notes on data sets

There are two data files: (1) lizards detected during the monitoring programme, and (2) the survey-specific covariates and weather notes. The lizard detection data can be easily transformed into repeated count data for each lizard species (i.e. as a J x M matrix for J sites and M surveys), e.g. by running the `Data_manipulation.r` code in this repository or with a pivot table in Excel. 

Survey-specific covariates apply for the pooled survey period within which all 10 rock piles were surveyed. Each survey of all rock piles was completed within a maximum of 3 hours. The weather covariates did not vary dramatically over the course of each survey period.

`Start_time` is the time in 24h format of the start of the survey of the first rock pile. 

`End_time` is the end time in 24h format of the time at which the last rock pile was surveyed. 

`PM` is a binary variable where "1" = afternoon survey and "0" = morning survey. 

The numerical (decimal) variable `Temperature` is the average temperature in degrees Celsius at the midpoint of each survey period. 

The numerical (decimal) variable `Cloud` is the estimated average cloud cover in eighths across the whole survey period. 

The numerical (integer) variable `Wind` is the average wind speed estimated on the Beaufort scale across the whole survey period. 

`Rain_24` is a binary variable describing whether there was any precipitation in the 24 hour period immediately before the start of a survey period.  "1" = yes,  "0" = no. 

`Rain_during` is a binary variable describing whether there was any precipitation during a survey period. "1" = yes,  "0" = no. 

The string variable `Weather_notes` describes any other weather observations made during the survey period. 

Missing covariate data are denoted by an empty cell. 
