# Applied Statistics 2014 conference workshop
library(shinythemes)
# define the user interface
shinyUI(fluidPage(theme=shinytheme("superhero"),
                  # define type of page layout
                  pageWithSidebar(
                    
                    # define content of page header ####
                    headerPanel("Poroke"),
                    
                    # define content of left side of the page ####
                    sidebarPanel(
                      selectInput(inputId = "meritev", 
                                  label = "Te zanima kako se skozi leta spreminja povprečna starost ali pa število sklenitev zakonskih zvez?",
                                  choices = c("Povprečna starost ženina"="povp_starost_zenina",
                                              "Povprečna starost neveste" = "povp_starost_neveste", 
                                              "Število sklenitev zakonskih zvez" = "sklenitev_zvez", 
                                              "Sklenitev zakonskih zvez na 1000 prebivalcev" = "sklenitev_zvez_na1000_prebiv"),
                                  selected = "Povprečna starost neveste"),
                      selectInput(inputId = "leta",
                                  label = "Leta",
                                  choices = c("1995" = "X1995",
                                              "1996" = "X1996",
                                              "1997" = "X1997"),
                                  selected = "1995")
                                 
                    ),
                    
                    # define content of the main part of the page ####   
                    mainPanel(
                      tabsetPanel(
                        tabPanel(title="Statistika porok skozi leta",      
                                 plotOutput("plotPorokePoLetih")
                        ),
                        tabPanel(title="Poroke po regijah",
                                 plotOutput("plotPorokePoRegijah"))
                      )
                    )
                  )
) )