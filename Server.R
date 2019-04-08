library(shiny)
library(ggplot2)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  
  output$plotPorokePoLetih <- renderPlot({
    p= ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$sklenitev_zvez))+
      geom_col(fill="lightpink3", width = 0.8)+tema_graf()+xlab("Leta")+ylab("Število sklenitev zakonskih zvez")
    
     if (input$locitveSlo==FALSE & input$rojstvaSlo==FALSE){p+scale_x_continuous(limits = c(input$dolociLeta))}
    
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
  
  output$tableStarost <- renderTable({
     if (input$spol2==c("Ženske","Moški")){table<-cbind("leto"=povprecna_starost_leta$leto,
                                                                    "starost neveste"=povprecna_starost_leta$povp_starost_neveste,
                                                                    "starost zenina"=povprecna_starost_leta$povp_starost_zenina)}
    else if (input$spol2=="Ženske"){table<-cbind("leto"=povprecna_starost_leta$leto,
                                                         "starost neveste"=povprecna_starost_leta$povp_starost_neveste)}
    else if (input$spol2=="Moški"){table<-cbind("leto"=povprecna_starost_leta$leto,
                                                  "starost ženina"=povprecna_starost_leta$povp_starost_zenina)}
    return(table)
    })
  
  output$plotPorokeEvropa <- renderPlot({
    g=ggplot(poroke_evropa, aes_string(x=poroke_evropa$X, y=input$drzava)) + geom_col(fill="lightpink3") +
      scale_x_continuous(breaks=seq(1960,2010, by=10),labels=c("1960", "'70","'80","'90","2000","'10"))+
      scale_y_continuous(breaks=seq(1,12,by=1),labels=c("1","2","3","4","5","6","7","8","9","10","11","12")) + 
      xlab("Leta") + ylab("Stevilo porok na 1000 prebivalcev")+labs(title = input$drzava)
    if (input$razveze==FALSE){g}
    else if (input$razveze==TRUE){
      g+geom_point(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="olivedrab", size=2)+
        geom_line(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y=input$drzava), colour="olivedrab")+
      theme(legend.background = element_blank()) +
        theme(legend.position = "bottom", legend.text = element_text(size=6, face="bold"),
              legend.title=element_blank(), 
              legend.key = element_rect(fill = "transparent", color = NA, size=0.6))
      
      }
  })
  
  
  output$plotPorokePoRegijah <- renderPlot(width = 400, height=400,  
                                           {ggplot() + geom_polygon(data = zemljevid2
        , aes_string(x=zemljevid2$long, y=zemljevid2$lat, group=zemljevid2$group,
        fill=input$leta),color = "grey30") +
      scale_fill_gradient(low="lightpink3",  high="olivedrab", limits=c(0, 2200)) + tema_zemljevid()+
      guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))
    })
  

  
  output$textStarostPoroka <- renderText({
    if (input$spol=="Zenska" & input$druga=="Ne"){stevilo=zenske_poroka1[which(zenske_poroka1$regije==input$regija1), input$regija2]}
    else if (input$spol=="Moski" & input$druga=="Ne"){stevilo=moski_poroka1[which(moski_poroka1$regije==input$regija1), input$regija2]}
    else if (input$spol=="Zenska" & input$druga=="Da"){stevilo=zenske_poroka1[which(zenske_poroka1$regije==input$regija1), input$regija2]+12}
    else if (input$spol=="Moski" & input$druga=="Da"){stevilo=moski_poroka1[which(moski_poroka1$regije==input$regija1), input$regija2]+12}
    
    HTML(paste(stevilo, "letih"))
    })
  
})
