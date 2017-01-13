shinyServer(function(input, output, session) {
  
  ## Interactive Map ###########################################
  
  
  Select <- reactive({
    switch(input$species,
           "Benthic Grazers"=R1,
           "Bivalves"=R2,"Blue Crab"=R3,"Brown Shrimp"=R4,"Carnivorous Macrobenthos"=R5,
           "Crabs and Lobsters"=R6,"Deep Serranidae"=R7,'Flatfish'=R8,"Infaunal meiobethos"=R9,
           'Jacks'=R10,'Jellyfish'=R11,'Large Pelagic Fish'=R12,'Large Reef Fish'=R13,'Large Sharks'=R14,
           "Lutjanidae"=R15,'Medium Pelagic Fish'=R16,'Menhaden'=R17,'Other Demersal Fish'=R18,
           "Other Shrimp"=R19,"Pinfish"=R20,"Pink Shrimp"=R21,'Red Grouper'=R22,'Red Snapper'=R23,
           'Sciaenidae'=R24,'Seatrout'=R25,'Sessile Filter Feeders'=R26,'Shallow Serranidae'=R27,
           'Skates and Rays'=R28,'Small Demersal Fish'=R29,'Small Pelagic Fish'=R30,'Small Reef Fish'=R31,'Spanish Mackerel'=R32,
           "Spanish Sardine"=R33,"Squid"=R34,'Vermilion Snapper'=R35,"White Shrimp"=R36
    )
    
    
  }) # reactive
  

  
  # output$histfit<- renderPlot({
  #   hist(SubSet()$fit,
  #        breaks=20,
  #        main = "Fit data",
  #        xlab = "Fitted Abundance",
  #        xlim=range(SubSet()$fit),
  #        col="#00DD00",
  #        border="white")
  #   
  # })##renderPlot
  
  
  SubSet <- reactive({
    subset(Select(), Select()$Percent>=input$quantile[1] & Select()$Percent <=input$quantile[2])
  }) #reactive
  # 
  ########Histogram of subset fit data based on species selection and slider#######
  # output$histfit<- renderPlot({
  #   hist(SubSet()$log,
  #        breaks=20,
  #        main = "Fit data",
  #        xlab = "Fitted Abundance",
  #        xlim=c(min(SubSet()$log),max(SubSet()$log)),
  #        # xlim=range(SubSet()$fit),
  #        col="#00DD00",
  #        border="white")
  # 
  # })##renderPlot
  
  ########hchart histogram############
  output$hist<- renderHighchart({
  
    hchart(SubSet()$log,color="#1890a8", name = "Log Abundance") %>%
      hc_title(text = "Histogram of Data in View") %>% 
      hc_subtitle(text = "Zoomable")%>%
      hc_add_theme(thm)
      # hc_add_theme(hc_theme_null())
  }) ## renderHighchart
  
  Raster<-reactive({
    R.fit<-rasterFromXYZ(SubSet()[,c(1:2,5)])
     proj4string(R.fit) <- CRS("+init=epsg:4326")
    R.fit
    
  })
  # if(input$species=="Large Pelagics"){
  #   ColorData<-p1$Breaks
  #   factpal<-colorFactor(topo.colors(length(jjenks1$brks)), ColorData)
  # }
  # if(input$species=="Red Grouper"){
  #   ColorData<-p2$Breaks
  #   factpal<-colorFactor(topo.colors(length(jjenks2$brks)), ColorData)
  # }
  
  Select2 <- reactive({
    switch(input$species,
           "Benthic Grazers"=C1,
           "Bivalves"=C2,"Blue Crab"=C3,"Brown Shrimp"=C4,"Carnivorous Macrobenthos"=C5,
           "Crabs and Lobsters"=C6,"Deep Serranidae"=C7,'Flatfish'=C8,"Infaunal meiobethos"=C9,
           'Jacks'=C10,'Jellyfish'=C11,'Large Pelagic Fish'=C12,'Large Reef Fish'=C13,'Large Sharks'=C14,
           "Lutjanidae"=C15,'Medium Pelagic Fish'=C16,'Menhaden'=C17,'Other Demersal Fish'=C18,
           "Other Shrimp"=C19,"Pinfish"=C20,"Pink Shrimp"=C21,'Red Grouper'=C22,'Red Snapper'=C23,
           'Sciaenidae'=C24,'Seatrout'=C25,'Sessile Filter Feeders'=C26,'Shallow Serranidae'=C27,
           'Skates and Rays'=C28,'Small Demersal Fish'=C29,'Small Pelagic Fish'=C30,'Small Reef Fish'=C31,'Spanish Mackerel'=C32,
           "Spanish Sardine"=C33,"Squid"=C34,'Vermilion Snapper'=C35,"White Shrimp"=C36)
    
    # #
    # #
  })#reactive
  
  
  output$pie<- renderHighchart({
    a<-nrow(SubSet())
     C<-nrow(Select())
     d<-C-a
     
    e<-round(a/C*100,1)
    f<-round(d/C*100,1)
     col1 <- "#1860a8" ##hc_get_colors()[3]
     col2 <- "#6090c0" ##hc_get_colors()[2] 
    
    highchart() %>% 
      hc_title(text = "Proportion of Data in View") %>% 
      hc_legend(enabled=FALSE) %>% 
      hc_add_series(name="",type = "pie",
                    data = list(list(y = e, name = "Displayed",
                                     sliced = TRUE, color = col1),
                                list(y = f, name = "Not Displayed",
                                     color = col2,
                                     dataLabels = list(enabled = FALSE))),
                    center = c('50%', 10), ####controls location within panel
                    size = 80) %>%  ######alters pie radius
      hc_add_theme(thm)
   
    
    
    # a<-nrow(SubSet())
    # C<-nrow(Select())
    # d<-C-a
    # 
    # pieval<-c(d,a)
    # pielabels<-c("Not Displayed","Displayed")
    # pie<-pie3D(pieval,radius=1.0,labels=pielabels,explode=0.1,
    #            labelrad=1.4,main="Proportion of Data in View")
    
  })  # renderPlot
  
  
  # Create the map
  output$map1 <- renderLeaflet({
    leaflet() %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      #addPolylines(data=councilB, color = "red") %>% 
      
      setView(-89.87, 25.15, zoom = 6)
    
    
    
  }) ## renderLeaflet
  ###this first observe bit is not working###
  # observe({
  #   if(input$species=="Large Pelagics"){
  #     p[p$pPercent>=input$quantile[1] & p$pPercent<=input$quantile[2],]
  #   }
  #   if(input$species=="Red Grouper"){
  #     R[R$RPercent>=input$quantile[1] & R$RPercent<=input$quantile[2],]
  #   }
  # })
  # if(input$species=="Large Pelagics"){
  #   ColorData<-allP[[1]]$Breaks
  #   factpal<-colorFactor(topo.colors(length(jjenks1$brks)), ColorData)
  # }
  # if(input$species=="Red Grouper"){
  #   ColorData<-allP[[2]]$Breaks
  #   factpal<-colorFactor(topo.colors(length(jjenks2$brks)), ColorData)
  # }
  
  observe({
    factpal <- colorNumeric(c("#3B9AB2", "#78B7C5",
                              "#EBCC2A", "#E1AF00" ,"#F21A00"),
                            na.color="transparent",values(Select2()))
    
    # factpal <- colorNumeric(c('#ffffb2','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#b10026'),
    #                         na.color="transparent",values(Select2()))
       
    leafletProxy("map1") %>%
      clearImages() %>%
      # if (input$checkbox){
     addRasterImage(Raster(), colors = factpal, opacity = 0.8, group="Turn on/off layer") %>% 
      addLayersControl(overlayGroups = "Turn on/off layer",
                      options=layersControlOptions(collapsed=FALSE),
                      position=c("bottomleft")) 
      
    
      #}
    
    
  }) ##observe
  
  
observe({
  
    factpal <- colorNumeric(c("#3B9AB2", "#78B7C5",
  "#EBCC2A", "#E1AF00" ,"#F21A00"), na.color="transparent",values(Select2()))
    # 
    # factpal <- colorBin(c("#3B9AB2", "#78B7C5",
    #                        "#EBCC2A", "#E1AF00" ,"#F21A00"), 
    #                      na.color="transparent",values(Select2()),bins=7)
    # factpal <- colorNumeric(c('#ffffb2','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#b10026'),
    #                         na.color="transparent",values(Select2()))


    proxy <- leafletProxy("map1", data =Select2())
    proxy %>% clearControls()
    # proxy %>% addLegend(position = "bottomright",
    #                     pal = factpal, values = ColorData)
    proxy %>% addLegend(pal = factpal, values = values(Select2()), 
                        title = "Abundance", position="bottomleft")
})#observe
    
output$map2 <- renderLeaflet({
    leaflet() %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                 options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
                 options = providerTileOptions(noWrap = TRUE)) %>%
        
      setView(-89.87, 25.15, zoom = 6) #%>% 
    #   addPolygons(data=lobster, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Lobster") %>% 
    # addPolygons(data=CMP, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Coastal Migratory Pelagics") %>% 
    # addPolygons(data=RF, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Reef Fish") #%>% 
    # addPolygons(data=RD, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Red Drum") %>% 
    # addPolygons(data=shrimp, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Shrimp") %>% 
    # addPolygons(data=coral, stroke=FALSE, smoothFactor=0.2, fillOpacity=0.8,
    #             color="#1b9e77", group="Coral") %>% 
    # addLayersControl(overlayGroups = c("Lobster","Shrimp","Coral","Reef Fish","Coastal Migratory Pelagics",
    #                  "Red Drum"), 
    #                  options=layersControlOptions(collapsed=FALSE),
    #                  position=c("topleft"))
   # addRasterImage(rp, opacity = 0.8) 
      
      
      
    }) #renderLeaflet
    


})#shiny server
#    
# 
#   # 
