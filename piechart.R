######create a pie chart using plotrix package########


load("R1.RData")
library(plotrix)


pieval<-c(2,4,6,8)
pielabels<-c("We hate\n pies","We oppose\n  pies",
             "We don't\n  care","We just love pies")
# grab the radial positions of the labels
lp<-pie3D(pieval,radius=0.8,labels=pielabels,explode=0.1,
          labelrad=1.4,main="3D PIE OPINION")
a<-subset(R1[1:70,])
b<-nrow(a)
C<-nrow(R1)
d<-C-b

pieval<-c(C,b)
pielabels<-c("Subset","Remaining")
pie<-pie3D(pieval,radius=1.0,labels=pielabels,explode=0.1,
           labelrad=1.4,main="3D PIE OPINION")