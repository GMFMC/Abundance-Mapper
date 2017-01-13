shinyUI(navbarPage("SEAMAP Abundance Data Explorer", id="nav", inverse = TRUE,
                   
                   tabPanel("Abundance Viewer",
                            div(class="outer",
                                
                                tags$head(
                                  # Include our custom CSS
                                  ##using 5-class Dark2 (qualitative color scheme)
                                  includeCSS("styles.css")#,
                                  #includeScript("gomap.js")
                                ),
                                includeCSS("slidertheme.css"),
                                 
                                
                                # ##########styling for slider#######
                                  # tags$style(HTML(".irs-bar {background: #e7298a}")),
                                # 
                                # # tags$style(HTML(".irs-bar {border-top: 1px solid green}")),
                                # # tags$style(HTML(".irs-bar-edge {background: red}")),
                                # # tags$style(HTML(".irs-bar-edge {border: 1px solid red}")),
                                # # tags$style(HTML(".irs-double {background: #02818a}")),
                                #  tags$style(HTML(".btn.btn-primary {background: #d95f02}")),
                                # # tags$style(HTML(".rangeslider {background: #02818a}")),
                                  tags$style(HTML(".btn.btn-primary {margin-top: 20px}")),
                                 tags$style(HTML(".btn.btn-primary {background: #3078a8}")),
                                # # tags$style(HTML(".irs-slider.double {background: #02818a}")),
                                #  tags$style(HTML(".irs-to {background: #1b9e77}")),
                                 tags$style(HTML(".irs-min {color: #a8c0d8}")),
                                 tags$style(HTML(".irs-max {color: #a8c0d8}")),
                                tags$style(HTML(".irs-min {background: #a8c0d8}")),
                                tags$style(HTML(".irs-max {background: #a8c0d8}")),
                                

                                
                                
                                leafletOutput("map1", width="100%", height="100%"),
                                DT::dataTableOutput('tbl1'),
                                absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                              draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                              width = 330, height = "auto",
                                              
                                              h2("Abundance Explorer"),
                                              
                                              
                                              selectInput("species", 
                                                          label = "Species or Groups",
                                                          choices = c("Benthic Grazers",
                                                                      "Bivalves","Blue Crab","Brown Shrimp","Carnivorous Macrobenthos",
                                                                      "Crabs and Lobsters","Deep Serranidae",'Flatfish',"Infaunal meiobethos",
                                                                      'Jacks','Jellyfish','Large Pelagic Fish','Large Reef Fish','Large Sharks',
                                                                      "Lutjanidae",'Medium Pelagic Fish','Menhaden','Other Demersal Fish',
                                                                      "Other Shrimp","Pinfish","Pink Shrimp",'Red Grouper','Red Snapper',
                                                                      'Sciaenidae','Seatrout','Sessile Filter Feeders','Shallow Serranidae',
                                                                      'Skates and Rays','Small Demersal Fish','Small Pelagic Fish','Small Reef Fish','Spanish Mackerel',
                                                                      "Spanish Sardine","Squid",'Vermilion Snapper',"White Shrimp"),
                                                          
                                                          selected = "Benthic Grazers"),
                                              
                                              sliderInput("quantile", label="Filter Abundance by Quantile",min=0,
                                                          max=1, value=c(0.25,0.75), step=0.01),
                                              # plotOutput("histfit",height=200),
                                              highchartOutput("hist",height=300),
                                              highchartOutput("pie",height=200),
                                        
                                              
                                              submitButton("Submit")#,
                                              # checkboxInput("checkbox", label = "Turn on/off layer", value = TRUE)
                                              
                                              
                                              
                                ) ## absolutePanel
                                
                                
                                
                            ) ## div
                   ), ## tabPanel
    tabPanel("Sampling Viewer",
             div(class="outer",
                                
             tags$head(
                                  # Include our custom CSS
                  includeCSS("styles.css"),
                 includeScript("gomap.js")
                                ), #tags$head
                                
                                leafletOutput("map2", width="100%", height="100%"),
                                
                                absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                              draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                              width = 330, height = "auto",
                                              
                                              h2("Abundance Explorer")
                                              ) ## absolutePanel
                                
                                
                                
                            ) ## div
                   ) ## tabPanel  
                   
) ## navbarPage
)## ShinyUI
