library(RColorBrewer)

tema_graf <- function() {
  
  
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[9]
  color.subtitle=palette[9]
  color.title = palette[8]
  
  theme_bw(base_size=9) +
    
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    theme(plot.title=element_text(color=color.title, size=13, face="bold")) +
    theme(axis.text.x=element_text(size=10,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=10,color=color.axis.text)) 
}

tema_zemljevid <- function() {
  
  
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[9]
  color.subtitle=palette[9]
  color.title = palette[8]
  
  theme_bw(base_size=9) +
    
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    theme(panel.grid.major = element_blank())+
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    theme(axis.text.x=element_blank()) +
    theme(axis.text.y=element_blank())+
    theme(axis.title = element_blank())
}
