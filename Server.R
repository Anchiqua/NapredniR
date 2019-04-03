library(shiny)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  
  output$plotPorokePoLetih <- renderPlot({
    ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=input$meritev))+
      geom_line()+tema_graf()+xlab("Leta")+ylab(input$meritev)
    })
  
  output$plotPorokeEvropa <- renderPlot({
    g=ggplot(poroke_evropa, aes_string(x=poroke_evropa$X, y=input$drzava)) + geom_col(fill="lightpink3") +
      scale_x_continuous(breaks=seq(1960,2010, by=10),labels=c("1960", "'70","'80","'90","2000","'10"))+
      scale_y_continuous(breaks=seq(1,12,by=1),labels=c("1","2","3","4","5","6","7","8","9","10","11","12")) + 
      xlab("Leta") + ylab("Stevilo porok na 1000 prebivalcev")+labs(title = input$drzava)
    if (input$razveze==FALSE){g}
    else if (input$razveze==TRUE){
      g+geom_point(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="gray48")+
        geom_line(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="grey48")+
      theme(legend.background = element_blank()) +
        theme(legend.position = "bottom", legend.text = element_text(size=6, face="bold"),
              legend.title=element_blank(), 
              legend.key = element_rect(fill = "transparent", color = NA, size=0.6))
      
      }
  })
  
  
  output$plotPorokePoRegijah <- renderPlot({ggplot() + geom_polygon(data = zemljevid2
        , aes_string(x=zemljevid2$long, y=zemljevid2$lat, group=zemljevid2$group,
        fill=input$leta),color = "grey30") +
      scale_fill_gradient(low="aquamarine", high="blue") + tema_zemljevid()+
      guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))
    })
  
  output$textStarostPoroka <- renderText({
    if (input$spol=="Zenska"){stevilo=zenske_poroka1[which(zenske_poroka1$regije==input$regija1), input$regija2]}
    else if (input$spol=="Moski"){stevilo=moski_poroka1[which(moski_poroka1$regije==input$regija1), input$regija2]}
    HTML(paste(stevilo, "letih"))
  })
  

})
