library(shiny)
library(ggplot2)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  
  output$plotPorokePoLetih <- renderPlot({
    p= ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$sklenitev_zvez))+
      geom_col(fill="lightpink3", width = 0.8)+tema_graf()+xlab("Leta")+ylab("Število sklenitev zakonskih zvez")+
      theme(panel.grid.major.x = element_blank())
      

     if (input$locitveSlo==FALSE & input$rojstvaSlo==FALSE){
       p+scale_x_continuous(limits = c(input$dolociLeta))
     }
    
     else if (input$locitveSlo==TRUE & input$rojstvaSlo==FALSE){
       p+geom_line(razveze_slo, mapping=aes_string(x=razveze_slo$X, y=razveze_slo$razveze2), colour="violetred3", size=1)+
         scale_y_continuous(sec.axis = sec_axis(~./300, name="Razveze na sklenjene zakonske zveze [%]"))+
         scale_x_continuous(limits = c(input$dolociLeta))
     }
    
    else if (input$locitveSlo==FALSE & input$rojstvaSlo==TRUE){
      p + geom_line(rojstva_slo, mapping = aes_string(x=rojstva_slo$X, y=rojstva_slo$rojstva2), colour="olivedrab", size=1)+
        scale_y_continuous(sec.axis = sec_axis(~./300, name="Število otrok rojenih zunaj zakonske zveze [%]"))+
        scale_x_continuous(limits = c(input$dolociLeta))
    }
    
    else if (input$locitveSlo==TRUE & input$rojstvaSlo==TRUE){
      p+geom_line(razveze_slo, mapping=aes_string(x=razveze_slo$X, y=razveze_slo$razveze2), colour="violetred3", size=1)+
        geom_line(rojstva_slo, mapping = aes_string(x=rojstva_slo$X, y=rojstva_slo$rojstva2), colour="olivedrab", size=1)+
        scale_y_continuous(sec.axis = sec_axis(~./300, name="Otroci rojeni zunaj zakonske zveze in razveze [%]"))+
        scale_x_continuous(limits = c(input$dolociLeta))
    }
    
    
    # if (input$rojstva==FALSE){p}
    # else if (input$rojstva==TRUE){
    #   p + geom_point(rojstva_slo, mapping = aes_string(x=rojstva_slo$X, y=rojstva_slo$Rojeni.zunaj.zakonske.zveze))
    # }
 })
  
  output$plotStarost <- renderPlot({
    if (input$spol2=="Ženske in moški"){ggplot(povprecna_starost_leta)+
        geom_line(aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$povp_starost_zenina), col="olivedrab", size=2)+
        geom_line(aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$povp_starost_neveste), col="lightpink3", size=2)+
        scale_x_continuous(breaks=seq(1960,2020, by=10),labels=c("1960", "'70","'80","'90","2000","'10", "'20"))+
        xlab("Leta")+ylab("Povprečna starost neveste in ženina ob sklenitvi zakonske zveze")+tema_graf()+
        scale_colour_manual("Legenda", breaks=c("Nevesta", "Ženin"), values = c("lightpink3", "olivedrab"))}
    
    else if (input$spol2=="Ženske"){ggplot(povprecna_starost_leta)+
        geom_line(aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$povp_starost_neveste), col="lightpink3", size=2)+
        scale_x_continuous(breaks=seq(1960,2020, by=10),labels=c("1960", "'70","'80","'90","2000","'10", "'20"))+
        xlab("Leta")+ylab("Povprečna starost neveste ob sklenitvi zakonske zveze")+tema_graf()}
    
    else if (input$spol2=="Moški"){ggplot(povprecna_starost_leta)+
        geom_line(aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$povp_starost_zenina), col="olivedrab", size=2)+
        scale_x_continuous(breaks=seq(1960,2020, by=10),labels=c("1960", "'70","'80","'90","2000","'10", "'20"))+
        xlab("Leta")+ylab("Povprečna starost ženina ob sklenitvi zakonske zveze")+tema_graf()}
    
  })
  spol2Input <- reactive({if (input$spol2=="Ženske in moški"){table<-cbind("Leto"=format(povprecna_starost_leta$leto, digits = 0),
                                                                          "Povprečna starost neveste"=povprecna_starost_leta$povp_starost_neveste,
                                                                          "Povprečna starost ženina"=povprecna_starost_leta$povp_starost_zenina)}
    else if (input$spol2=="Ženske"){table<-cbind("Leto"=format(povprecna_starost_leta$leto, digits=0),
                                                 "Povprečna starost neveste"=povprecna_starost_leta$povp_starost_neveste)}
    else if (input$spol2=="Moški"){table<-cbind("Leto"=format(povprecna_starost_leta$leto, digits=0),
                                                "Povprečna starost ženina"=povprecna_starost_leta$povp_starost_zenina)}}
  )
  
  output$tableStarost <- renderTable({
     spol2Input()
    })

  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$spol2, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(spol2Input(), file, row.names = FALSE)
    }
  )
  
  output$plotPorokeEvropa <- renderPlot({
    g=ggplot(poroke_evropa, aes_string(x=poroke_evropa$X, y=input$drzava)) + geom_col(fill="lightpink3") +
      scale_x_continuous(breaks=seq(1960,2010, by=10),labels=c("1960", "'70","'80","'90","2000","'10"))+
      scale_y_continuous(breaks=seq(1,12,by=1),labels=c("1","2","3","4","5","6","7","8","9","10","11","12")) + 
      xlab("Leta") + ylab("Stevilo porok na 1000 prebivalcev")+labs(title = input$drzava)+tema_graf()+theme(panel.grid.major.x = element_blank())
    if (input$razveze==FALSE){g}
    else if (input$razveze==TRUE){
      g+geom_point(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="olivedrab", size=2)+
        geom_line(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="olivedrab")

      }
  })
  
  
  output$plotPorokePoRegijah <- renderPlot(width = 400, height=400,  
                                           {
      if (input$regije=="Slovenija"){map <- ggplot() + geom_polygon(data = zemljevid2
                                                                    , aes_string(x=zemljevid2$long, y=zemljevid2$lat, group=zemljevid2$group,
                                                                                 fill=input$leta),color = "grey30") +
        scale_fill_gradient(low="olivedrab1",  high="#31a354", limits=c(2.4, 4.6)) + tema_zemljevid()+
        guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))}
      else { index <- zemljevid2$NAME_1 == input$regije
      z2 <- zemljevid2
      z2$graf <- c(rep(as.integer(1), nrow(z2)))
      z2[index, 43] <- as.integer(2)
      map <- ggplot() + geom_polygon(data = z2, 
                              aes_string(x=z2$long, y=z2$lat, group=z2$group,
                                         fill=z2$graf),color = "grey30") +
        scale_fill_gradient(low="grey50",  high="olivedrab3", limits=c(1, 2), guide=FALSE) + tema_zemljevid()
      }
     return(map)
    })
  
  output$textPorokePoRegijah <- renderText({
    
    paste(input$regije, ": delež porok na 1000 prebivalcev je ", podatki[input$regije, input$leta])
  })
  
  
  output$textStarostPoroka <- renderText({
    if (input$spol=="Zenska" & input$druga=="Ne"){stevilo=zenske_poroka1[which(zenske_poroka1$regije==input$regija1), input$regija2]}
    else if (input$spol=="Moski" & input$druga=="Ne"){stevilo=moski_poroka1[which(moski_poroka1$regije==input$regija1), input$regija2]}
    else if (input$spol=="Zenska" & input$druga=="Da"){stevilo=zenske_poroka1[which(zenske_poroka1$regije==input$regija1), input$regija2]+12}
    else if (input$spol=="Moski" & input$druga=="Da"){stevilo=moski_poroka1[which(moski_poroka1$regije==input$regija1), input$regija2]+12}
    
    HTML(paste(stevilo, "letih"))
    })
  
})
