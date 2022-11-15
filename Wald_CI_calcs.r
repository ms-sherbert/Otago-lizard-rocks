#--- Calculate Wald confidence intervals ---#

#PRESENCE model-averaged outputs:
#2015: lambda(site    1) model-avg-est:   1.9013 se=  0.5945 
#2016: lambda(site    1) model-avg-est:   3.0272 se=  1.2204
#2017: lambda(site    1) model-avg-est:  45.2583 se=  0.0293 

year<-c(2015:2017)
lambda<-c(1.9013, 3.0272, 45.2583)
av.se<-c(0.5945, 1.2204, 0.0293)
n.stacks<-rep(10,3)

model.avs<-cbind(year,lambda,av.se,n.stacks)

"wald95" <- function (lam,n){ 
	UCI<-lam + 1.96*sqrt(lam/n)
	LCI<-lam - 1.96*sqrt(lam/n)
	output<-cbind(model.avs,LCI,UCI)
	print(output)
	}
	
wald95(lambda,n.stacks)
