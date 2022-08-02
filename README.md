# Otago-lizard-rocks

# Repository description
Data from the journal article Herbert S.M., Knox C., Clarke D., Bell T.P. 'Colonisation of constructed rock piles by lizards in a grassland habitat in Otago, New Zealand'. Submitted to the New Zealand Journal of Ecology in 2022. While the original analysis was performed in PRESENCE, there is also some code in this repository to provide the option of analysing these data using the 'unmarked' package in R. 

# Abstract

The main drivers of lizard population declines in New Zealand are habitat loss and introduced predators. Therefore, construction of artificial habitats may be a promising strategy for their conservation. We examined whether ten ~375 m3 rock piles constructed in October 2014 would be colonised by three locally-common lizard species: McCann’s skinks, southern grass skinks, and korero geckos. Only McCann’s skinks increased in abundance and formed breeding populations on the rock piles within 2.4 years of their construction. The outcomes for the other two lizard species were unclear because only two korero geckos were encountered on the piles, and no evidence of breeding was observed in southern grass skinks. Artificial rock pile construction may be useful for mitigating habitat loss, or creating new habitat, for McCann’s skinks. However, control sites should be included in future trials and a longer monitoring period is required for korero geckos and southern grass skinks. 

# Notes on data sets

There are two data files: (1) lizards detected during the monitoring programme, and (2) the survey-specific covariates and weather notes. The lizard detection data can be easily transformed into repeated count data for each lizard species (i.e. as a J x M matrix for J sites and M surveys), e.g. with a pivot table in Excel. 

Survey-specific covariates apply for the pooled survey period within which all 10 rock piles were surveyed. Each survey of all rock piles was completed within a maximum of 3 hours. The weather covariates did not vary dramatically over the course of each survey period.
"Start_time" is the time in 24h format of the start of the survey of the first rock pile. 
"End_time" is the end time in 24h format of the time at which the last rock pile was surveyed. 
"PM" is a binary variable where "1" = afternoon survey and "0" = morning survey. 
The numercial (decimal) variable "Temperature" is the average temperature in degrees Celsius at the midpoint of each survey period. 
The numerical (decimal) variable "Cloud" is the estimated average cloud cover in eighths across the whole survey period. 
The numerical (integer) variable "Wind" is the average wind speed estimated on the Beaufort scale across the whole survey period. 
"Rain_24" is a binary variable describing whether there was any precipiation in the 24 hour period immediately before the start of a survey period.  "1" = yes,  "0" = no. 
"Rain_during" is a binary variable describing whether there was any precipiation during a survey period. "1" = yes,  "0" = no. 
The string variables "Weather_notes" describes any other weather observations made during the survey period. 
Missing covariate data are denoted by an empty cell. 
