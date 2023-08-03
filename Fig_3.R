#---Graph of McCanns skink abundance estimates---#


#---Set working directory if needed and load packages

setwd("D:/Repositories/Otago-lizard-rocks")

library(ggplot2)

#Data read-in

data<-read.csv("McCanns_estimates.csv")
data$Year <- as.factor(data$Year)
PostC<-c(0.33,1.4,2.4)
data<-cbind(data,PostC)

ggplot(data=data, aes(x=PostC,y=N)) +
  geom_errorbar(aes(x=PostC,ymin=LCI,ymax=UCI,width=0.05)) + 
  geom_point(stat="identity", color="#006666",size = 3) + 
  scale_y_continuous(name = "Estimated number of McCann's skinks") +
  scale_x_continuous(name = "Number of years following rock pile construction",limits=c(0,3)) +
  theme(axis.text.x = element_text(size = 11), axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12), axis.text.y = element_text(size = 11)) + 
  annotate("text",x=PostC+0.3,y=data$N,label=c("19 [10,28]", "30 [19,41]", "453 [411,494]"),color = "#006666",size=4) +
  annotate("text",x=PostC,y=data$UCI+20,label=c("Feb 2015","Mar 2016","Mar 2017"),color = "#66b2b2",size=4) 
  #annotate("segment", x = 0.33, xend = 1.4, y = data$UCI[2]+50, yend = data$UCI[2]+50, color = "#008080",linewidth=0.5) +
  #annotate("text",x=mean(0.865),y=data$UCI[2]+70,label=c("n.s."),color = "#008080",size=3) +
  #annotate("segment", x = 0.865, xend = 2.4, y = data$UCI[3]+50, yend = data$UCI[3]+50, color = "#008080",linewidth=0.5) +
  #annotate("text",x=mean(1.6325),y=data$UCI[3]+70,label=c("*"),color = "#008080",size=4)
  