library(shiny)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  output$plotPorokePoLetih <- renderPlot({
    ggplot(povprecna_starost_leta, aes(x=leto, y=input$meritev))+
      geom_point()
  })
  output$PorokePoRegijah <- renderPlot({ggplot() + geom_polygon(data = zemljevid2, aes(x=long, y=lat, group=group,
        fill=input$leta),color = "grey30") +
      scale_fill_gradient(low="dodgerblue3", high="firebrick3") +
      guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))})

})
