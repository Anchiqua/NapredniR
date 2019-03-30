# Applied Statistics 2014 conference workshop
library(shinythemes)
# define the user interface
shinyUI(fluidPage(theme=shinytheme("superhero"),
                  # define type of page layout
                  
                    
                    # define content of page header ####
                    titlePanel("Poroke"),
                    
                    # define content of left side of the page
                    sidebarLayout(
                      sidebarPanel(div("Pozdravljeni v aplikaciji porok"), style="color:aquamarine", width=2), 
                    
                      mainPanel(
                        tabsetPanel(
                          
                          tabPanel("Poroke skozi leta",
                                   sidebarPanel(
                        
                                    selectInput(inputId = "meritev", 
                                                label = "Te zanima kako se skozi leta spreminja povprečna starost ali pa število sklenitev zakonskih zvez?",
                                                choices = c("Povprečna starost ženina"="povp_starost_zenina",
                                                            "Povprečna starost neveste" = "povp_starost_neveste", 
                                                            "Število sklenitev zakonskih zvez" = "sklenitev_zvez", 
                                                            "Sklenitev zakonskih zvez na 1000 prebivalcev" = "sklenitev_zvez_na1000_prebiv"),
                                                selected = "Povprečna starost neveste")),
                                   mainPanel(
                                    plotOutput("plotPorokePoLetih")
                                       )),
                          
                          tabPanel("Poroke po regijah", 
                                   sidebarPanel(
                                     selectInput(inputId = "leta",
                                                 label = "Leta",
                                                 choices = c("1995" = "X1995", "1996" = "X1996", "1997" = "X1997",
                                                             "1998" = "X1998", "1999" = "X1999", "2000" = "X2000",
                                                             "2001" = "X2001", "2002" = "X2002", "2003" = "X2003",
                                                             "2004" = "X2004", "2005" = "X2005", "2006" = "X2006",
                                                             "2007" = "X2007", "2008" = "X2008", "2009" = "X2009",
                                                             "2010" = "X2010", "2011" = "X2011", "2012" = "X2012",
                                                             "2013" = "X2013", "2014" = "X2014", "2015" = "X2015",
                                                             "2016" = "X2016", "2017" = "X2017"),
                                                 selected = "1995")),
                                   mainPanel(
                                     plotOutput("plotPorokePoRegijah")
                                   )),
                          
                          tabPanel("Poroke po Evropi",
                                   sidebarPanel(
                                     
                                     selectInput(inputId = "drzava", 
                                                 label = "Drzava",
                                                 choices = seznam_drzav, 
                                                 selected = "Slovenija"),
                                     checkboxInput(inputId = "razveze", label = "Stevilo razvez na 1000 prebivalcev?", value = FALSE)
                                     ),
                                   mainPanel(
                                     plotOutput("plotPorokeEvropa")
                                   ))
                          
                           # tabPanel("Poroke po Evropi",
                           #          sidebarPanel(
                           #            selectInput(inputID = "drzava",
                           #                       label = "Drzava",
                           #                       choices=seznam_drzav,
                           #                       selected="Slovenija")),
                           #          mainPanel(
                           #            plotOutput("plotPorokeEvropa")
                           #          ))

                                   
                    )
                  
                   
                  
) )))