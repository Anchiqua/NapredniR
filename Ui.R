# Applied Statistics 2014 conference workshop
library(shinythemes)
mycss <- "
.irs-bar,
.irs-bar-edge,
.irs-single,
.irs-grid-pol {
background: #d98c8c;
border-color: #d98c8c;
}
.irs-from, .irs-to, .irs-single { background: #d98c8c }
"
# define the user interface
shinyUI(fluidPage(theme=shinytheme("superhero"),
                  # define type of page layout
                  
                    
                    # define content of page header ####
                    titlePanel("Poroke"),
                    
                    # define content of left side of the page
                    sidebarLayout(
                      sidebarPanel(div("Pozdravljeni v aplikaciji porok"), style="color:violetred3", width=2), 
                    
                      mainPanel(
                        tabsetPanel(
                          
                          tabPanel("Poroke skozi leta",
                                   sidebarPanel(
                                    helpText("Na grafu je prikazano kako se z leti spreminja število sklenjenih zakonskih zvez.
                                             Spodaj lahko nastaviš obdobje, ki te zanima in po želji dodaš še graf števila razvez 
                                             in pa graf, ki ti pove koliko otrok je rojenih zunaj zakonske zveze"),
                                    hr(),
                                    tags$style(mycss),
                                    sliderInput(inputId="dolociLeta", label = "Določi leta", min=1960, max=2017,
                                                 value = c(1960, 2017), sep = ""),
                                    hr(),
                                    checkboxInput(inputId="locitveSlo", label="Število razvez na 100 sklenjenih zakonskih zvez", value = FALSE),
                                    hr(),
                                    checkboxInput(inputId = "rojstvaSlo", label= "Število otrok rojenih zunaj zakonske zveze",
                                                  value = FALSE)
                                  
                                    ),
                                  
                                   mainPanel(
                                    plotOutput("plotPorokePoLetih")
                                       )),
                          
                          tabPanel("Starost poročencev",
                                   sidebarPanel(
                                     checkboxGroupInput(inputId="spol2",
                                                        label = "Spol",
                                                        choices = c("Ženske", "Moški"),
                                                        selected = "Ženske")),
                                   mainPanel(
                                     plotOutput ("plotStarost"),
                                     tableOutput("tableStarost")
                                   )
                                   ),
                          
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
                                                 selected = "1995"),
                                     selectInput(inputId = "regije",
                                                 label = "Regije",
                                                 choices = c("Slovenija" = "Slovenija",
                                                             "Pomurska",
                                                             "Podravska",
                                                             "Koroška",
                                                             "Savinjska",
                                                             "Zasavska",
                                                             "Spodnjeposavska",
                                                             "Jugovzhodna Slovenija",
                                                             "Osrednjeslovenska",
                                                             "Gorenjska",
                                                             "Notranjsko-kraška",
                                                             "Goriška",
                                                             "Obalno-kraška"),
                                                 selected = "Slovenija")),
                                   mainPanel(
                                     plotOutput("plotPorokePoRegijah"),
                                     textOutput("textPorokePoRegijah")
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
                                   )), 
                          tabPanel("Test",
                                   sidebarPanel(
                                     helpText("Izpolni spodnji test in preveri pri katerih letih te čaka poroka."),
                                     radioButtons(inputId="spol",
                                                  label="Spol",
                                                  choices = c("Zenska", "Moski"),
                                                  selected = "Zenska"),
                                     selectInput(inputId="regija1",
                                                 label="Prebivalisce neveste",
                                                 choices = regije,
                                                 selected = "Osrednjeslovenska"),
                                     selectInput(inputId="regija2",
                                                 label="Prebivalisce zenina",
                                                 choices = regije,
                                                 selected = "Osrednjeslovenska"),
                                     radioButtons(inputId="druga",
                                                  label="Ste že bili kdaj poročeni?",
                                                  choices = c("Da", "Ne"),
                                                  selected = "Ne")
                                    ),
                                   mainPanel(
                                     h1("Poroka te čaka pri:", align="center",style = "font-family: 'Lobster', cursive;
                                        font-weight: 500; line-height: 1.1; color: olivedrab"),
                                     tags$head(tags$style(HTML("
                                                               #textStarostPoroka{
                                                                text-align: center;
                                                                color: olivedrab;
                                                                font-size: 30px;
                                                                font-weight: 600;
                                                                font-family: cursive;
                                                                line-height: 1.1;
                                                               }
                                                               div.box-header {
                                                                text-align: center;
                                                               }
                                                               "))),
                                     verbatimTextOutput("textStarostPoroka")
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