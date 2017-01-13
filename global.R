####setwd("X:/Claire/GAM_Est_Species_dists_Drexler/Raster")
library(DT)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(devtools)
library(grDevices)
library(raster)
library(wesanderson)
library(plotrix)
library("highcharter")
library("ggplot2")
library("shinythemes")
library(rgdal)

listRdata<-dir(pattern="*.RData")
for(i in 1:72){
  load(listRdata[i])
}

# lobster <- readOGR(dsn="Spiny_lobster_EFH_GOM_WGS84.shp",layer = "Spiny_lobster_EFH_GOM_WGS84")
# CMP <-readOGR(dsn="Coastal_migratory_pelagic_EFH_GOM_WGS84.shp",layer = "Coastal_migratory_pelagic_EFH_GOM_WGS84")
# coral <- readOGR(dsn="Coral_EFH_GOM_WGS84.shp",layer = "Coral_EFH_GOM_WGS84")
# RD <- readOGR(dsn="RedDrum_EFH_GOM_WGS84.shp",layer = "RedDrum_EFH_GOM_WGS84")
#RF<- readOGR(dsn="ReefFish_EFH_GOM_WGS84.shp",layer = "ReefFish_EFH_GOM_WGS84")
# shrimp <- readOGR(dsn="Shrimp_EFH_GOM_WGS84.shp",layer = "Shrimp_EFH_GOM_WGS84")

#######polygon to raster##########

# r<-raster(ncol=180,nrow=180)
# xres(r)
# yres(r)
# res(r)
# res(r)<-1/5
# res(r)
# extent(r)<-extent(RF)
# rp<-rasterize(RF,r,"Area_SqKm")
# # plot(rp)


##############Merging HC Themes#################
thm <- hc_theme_merge(
  hc_theme_darkunica(),
  hc_theme(
    chart = list(
      backgroundColor = "transparent"),
    title = list(
      style = list(
        color = '#004890',
        fontFamily = "Open Sans"
      )
    )
  )
)

############Council Boundary############

councilB <- readOGR(dsn="MSA_FMC_US_Atlantic_GOM.shp",layer = "MSA_FMC_US_Atlantic_GOM")    







