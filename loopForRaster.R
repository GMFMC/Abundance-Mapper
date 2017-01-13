############loop for raster map###########

setwd("X:/Claire/GAM_Est_Species_dists_Drexler/Raster")
library(raster)
library(classInt)
library(sp)
library(R.utils)
library(rgdal)

Names<- c("R1","R2","R3","R4","R5","R6","R7","R8","R9","R10","R11",
          "R12","R13","R14","R15","R16","R17","R18","R19","R20","R21",'R22',
          'R23','R24','R25','R26','R27','R28','R29','R30','R31','R32','R33',
          'R34','R35','R36')

listcsv <- dir(pattern="*.csv") # creates a list of all csv files in directory

for(i in 1:36){
  a<-read.csv(listcsv[i])
  b<-data.frame(x=a$POINT_X,y=a$POINT_Y,fit=a$fit)
  e<-subset(b,fit!="Inf")
  out1<-subset(e,e$x>=-86.99 & e$x<=-80.89 & e$y>=23.71 & e$y<=31.86)
  out2<-subset(e,e$x>=-97.87 & e$x<=-86.99 & e$y>=26.01 & e$y<=31.86)
  
  dat<-rbind(out1,out2)
  E<-ecdf(dat$fit)
  Percent<-E(dat$fit)
  Percent<-signif(Percent,digits=2)
 dat$Percent<-Percent
 dat$log<-log10(dat$fit+1)
  Names.i<-Names[i]
  
  assign(Names.i,dat)
  
  save(list=c(Names.i),file=paste(Names.i,
                                  ".RData",sep=""))
  rm(a,b,dat,out1,out2,Percent)
  
  
}
# plot(b$x,b$y)
# summary(b$x,b$y)
# out1<-subset(b,b$x>=-86.99 & b$x<=-80.89 & b$y>=23.71 & b$y<=31.86)
# out2<-subset(b,b$x>=-97.87 & b$x<=-86.99 & b$y>=26.01 & b$y<=31.86)
# 
# proj4string(C) <- CRS("+init=epsg:4326")
# plot(out2$x,out2$y)
# head(b)
# plot(dat$x,dat$y)
# 
# C <- rasterFromXYZ(dat)
# pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(C),
#                     na.color = "transparent")
# 
# leaflet() %>%
#   addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
#            options = providerTileOptions(noWrap = TRUE)) %>%
#   addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
#            options = providerTileOptions(noWrap = TRUE)) %>%
#   
#   setView(-89.87, 25.15, zoom = 6) %>% 
#   addRasterImage(C,colors=pal,opacity=0.8) %>% 
#   addLegend(pal = pal, values = values(C),
#             title = "Surface temp")

Names<- c("C1","C2","C3","C4","C5","C6","C7","C8","C9","C10","C11",
          "C12","C13","C14","C15","C16","C17","C18","C19","C20","C21",'C22',
          'C23','C24','C25','C26','C27','C28','C29','C30','C31','C32','C33',
          'C34','C35','C36')


for(i in 1:36){
  a<-read.csv(listcsv[i])
  b<-data.frame(x=a$POINT_X,y=a$POINT_Y,fit=a$fit)
  e<-subset(b,fit!="Inf")
  out1<-subset(e,e$x>=-86.99 & e$x<=-80.89 & e$y>=23.71 & e$y<=31.86)
  out2<-subset(e,e$x>=-97.87 & e$x<=-86.99 & e$y>=26.01 & e$y<=31.86)
  
  dat<-rbind(out1,out2)
  dat$log<-log10(dat$fit+1)
  
  # dat.2<-rasterFromXYZ(dat)
dat.2<-rasterFromXYZ(dat[,-3])
  # E<-ecdf(dat$fit)
  # Percent<-E(dat$fit)
  # Percent<-signif(Percent,digits=2)
  # dat$Percent<-Percent
  # Names.i<-Names[i]
  # 
  # assign(Names.i,dat)
  
  Names.i<-Names[i]
  
  assign(Names.i,dat.2)
  
  save(list=c(Names.i),file=paste(Names.i,
                                  ".RData",sep=""))
  rm(a,b,out1,out2,dat,dat.2)
  
  
}