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
razveze_slo <- read.csv(file = "razveze_slo.csv", sep=";", header=TRUE)
razveze_slo$razveze2<-razveze_slo$Razveze*300

rojstva_slo <- read.csv(file = "rojeni_zunaj_zveze_slo.csv", sep=";", header=TRUE)
rojstva_slo$rojstva2<-rojstva_slo$Rojeni.zunaj.zakonske.zveze*300

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
rownames(podatki) <- podatki$X

##rownames(podatki[2:13]) <- vsota$REGIJE
zemljevid1 <- preuredi(podatki[2:13,], zemljevid, "NAME_1", novi=NULL)


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

# poroke v Evropi
poroke_evropa<- read.csv(file = "poroke_evropa.csv", sep=";", header=TRUE)
poroke_evropa<-poroke_evropa[1:6,]
names(poroke_evropa)[names(poroke_evropa)=='Velika.Britanija']<-'Velika Britanija'
names(poroke_evropa)[names(poroke_evropa)=='Bosna.in.Hercegovina']<-'Bosna in Hercegovina'

seznam_drzav1<-colnames(poroke_evropa)
seznam_drzav<-seznam_drzav1[2:36]

locitve_evropa<- read.csv(file = "locitve_evropa.csv", sep=";", header=TRUE)
names(locitve_evropa)<-seznam_drzav1


# g=ggplot(poroke_evropa, aes_string(x=poroke_evropa$X, y="Slovenija")) + geom_col() +
#   scale_x_continuous(breaks=seq(1960,2010, by=10),labels=c("1960", "'70","'80","'90","2000","'10"))+
#   scale_y_continuous(breaks=seq(1,12,by=1),labels=c("1","2","3","4","5","6","7","8","9","10","11","12")) + 
#   xlab("Leta") 
# g+geom_point(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y="Slovenija"), colour="red")+
#   geom_line(locitve_evropa, mapping=aes_string(x=locitve_evropa$X, y="Slovenija"), colour="red")
# g


#priprava podatkov  za kalkulator
regije<-c("Pomurska", "Podravska", "Koroska", "Savinjska", "Zasavska", "Posavska", 
          "Jugovzhodna Slovenija", "Osrednjeslovenska", "Gorenjska", "Primorsko-notranjska",
          "Goriška", "Obalno-kraska")
#ženske, 1.poroka
x1<-round(rnorm(12, 29, 3))
x2<-round(rnorm(12, 28, 1))
x3<-round(rnorm(12, 30, 2))
x4<-round(rnorm(12, 30.5, 1))
x5<-round(rnorm(12, 28, 3))
x6<-round(rnorm(12, 30, 2))
x7<-round(rnorm(12, 30, 1))
x8<-round(rnorm(12, 31, 3))
x9<-round(rnorm(12, 30, 2))
x10<-round(rnorm(12, 30, 3))
x11<-round(rnorm(12, 29, 2))
x12<-round(rnorm(12, 29, 3))

zenske_poroka1<-data.frame(regije,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12)
names(zenske_poroka1)<-c("regije",regije)

#moški, 1.poroka
y1<-round(rnorm(12, 30, 2))
y2<-round(rnorm(12, 29, 3))
y3<-round(rnorm(12, 31, 2))
y4<-round(rnorm(12, 32, 3))
y5<-round(rnorm(12, 30, 2))
y6<-round(rnorm(12, 29, 4))
y7<-round(rnorm(12, 31, 1))
y8<-round(rnorm(12, 32, 3))
y9<-round(rnorm(12, 30, 1))
y10<-round(rnorm(12, 32, 1))
y11<-round(rnorm(12, 30, 3))
y12<-round(rnorm(12, 29, 2))

moski_poroka1<-data.frame(regije, y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12)
names(moski_poroka1)<-c("regije",regije)

# ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$povp_starost_neveste))+
#   geom_col(fill="lightblue", width = 0.8)+tema_graf()+xlab("Leta")+
#   geom_line(rojstva_slo, mapping=aes_string(x=rojstva_slo$X, y=rojstva_slo$Rojeni.zunaj.zakonske.zveze))
# 


ggplot(povprecna_starost_leta, aes_string(x=povprecna_starost_leta$leto, y=povprecna_starost_leta$sklenitev_zvez))+
  geom_col(fill="lightblue", width = 0.8)+tema_graf()+xlab("Leta")+
  geom_line(razveze_slo, mapping=aes_string(x=razveze_slo$X, y=razveze_slo$razveze2), colour="red")+
  scale_y_continuous(sec.axis = sec_axis(~./300, name="neki"))

povprecna_starost_leta[,povp_starost_zenina]
povprecna_starost_leta$leto
povprecna_starost_leta$povp_starost_zenina
