library(shiny)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  output$plotPorokePoLetih <- renderPlot({
    ggplot(povprecna_starost_leta, aes(x=leto, y=input$meritev))+
      geom_point()
  })

})
