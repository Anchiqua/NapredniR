library(shiny)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  output$plotPorokePoLetih <- renderPlot({
    ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=input$meritev))+
      geom_point()
  })
  output$plotPorokePoRegijah <- renderPlot({ggplot() + geom_polygon(data = zemljevid2
        , aes_string(x=zemljevid2$long, y=zemljevid2$lat, group=zemljevid2$group,
        fill=input$leta),color = "grey30") +
      scale_fill_gradient(low="dodgerblue3", high="firebrick3") +
      guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))})

})
