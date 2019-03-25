podatki <- read.csv(file = "podatki.csv", sep=";", header=TRUE)


source("zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8")

##rownames(podatki[2:13]) <- vsota$REGIJE
zemljevid1 <- preuredi(podatki, zemljevid, "NAME_1")


pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))
}

# Regije na zemljevidu

zemljevid$leto <- zemljevid1$X2010
zemljevid2 <- pretvori.zemljevid(zemljevid)

# Zemljevid:

vsota.zemljevid <- ggplot() + geom_polygon(data = zemljevid2, aes(x=long, y=lat, group=group,
                                                                  fill=X2010),color = "grey30") +
  scale_fill_gradient(low="cyan", high="cyan4") +
  guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))
