podatki <- read.csv(file = "podatki.csv", sep=";", header=TRUE)
starost_regija_nevesta2017 <- read.csv(file="starost_regija_nevesta.csv", sep=";", header = TRUE)
starost_regija_zenin2017 <- read.csv(file="starost_regija_zenin.csv", sep=";", header = TRUE)


#podatki za graf po letih (1954-2017) glede na povprecno starost in stevilo sklenitev zakonskih zvez
#prvi stolpec predstavlja število sklenitev zakonskih zvez, drugi sklnitev zakosnkih zvez na 1000 prebivalcev, 
#tretji povprečno starost ženina, četrti povprečno starost neveste
povprecna_starost_leta<- read.csv(file = "povprecna_starost_leta.csv", sep = ";", header = T)
names(povprecna_starost_leta)<-c("leto", "sklenitev_zvez", 
                                 "sklenitev_zvez_na1000_prebiv", 
                                 "povp_starost_zenina",
                                 "povp_starost_neveste")

ggplot(povprecna_starost_leta, aes(leto, povp_starost_zenina))+
  geom_point()
ggplot(povprecna_starost_leta, aes(leto, sklenitev_zvez_na1000_prebiv))+
  geom_point()

#stevilo porok po mesecih (s sliderInput bo mogoče izbrati za katero leto se izriše graf)

poroke_po_mesecih<-read.csv("poroke_po_mesecih.csv", sep = ";", header = T)
ggplot(poroke_po_mesecih, aes(mesec, X1988))+geom_point()

source("zemljevid.r", encoding = "UTF-8")

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
zemljevid$X1995 <- zemljevid1$X1995
zemljevid$X1996 <- zemljevid1$X1996
zemljevid$X1997 <- zemljevid1$X1997
zemljevid$X1998 <- zemljevid1$X1998
zemljevid$X1999 <- zemljevid1$X1999
zemljevid$X2000 <- zemljevid1$X2000
zemljevid$X2001 <- zemljevid1$X2001
zemljevid$X2002 <- zemljevid1$X2002
zemljevid$X2003 <- zemljevid1$X2003
zemljevid$X2004 <- zemljevid1$X2004
zemljevid$X2005 <- zemljevid1$X2005
zemljevid$X2006 <- zemljevid1$X2006
zemljevid$X2007 <- zemljevid1$X2007
zemljevid$X2008 <- zemljevid1$X2008
zemljevid$X2009 <- zemljevid1$X2009
zemljevid$X2010 <- zemljevid1$X2010
zemljevid$X2011 <- zemljevid1$X2011
zemljevid$X2012 <- zemljevid1$X2012
zemljevid$X2013 <- zemljevid1$X2013
zemljevid$X2014 <- zemljevid1$X2014
zemljevid$X2015 <- zemljevid1$X2015
zemljevid$X2016 <- zemljevid1$X2016
zemljevid$X2017 <- zemljevid1$X2017
zemljevid2 <- pretvori.zemljevid(zemljevid)

# Zemljevid:

graf.zemljevid <- ggplot() + geom_polygon(data = zemljevid2, aes(x=long, y=lat, group=group,
                                                                  fill=X1995),color = "grey30") +
  scale_fill_gradient(low="dodgerblue3", high="firebrick3") +
  guides(fill = guide_colorbar(title = "Porazdelitev\nštevila porok\npo regijah"))

print(graf.zemljevid)

