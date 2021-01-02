library(readxl)
library(dplyr)
library(ggmap)
gamedat <- read_excel("Desktop/Data/Li16/gamedat.xlsx")
View(gamedat)   
partdat <- read_excel("Desktop/Data/Li16/partdat.xlsx")
View(partdat)
gpdat <- read_excel("Desktop/Data/Li16/gpdat.xlsx")
View(gpdat)

partdat <- merge(partdat, gpdat, by="id2")


#latitude and longitude were obtained from Open Street Map using https://www.latlong.net
#cooperative is 1, competitive is 0

sumgamedat <- gamedat %>% group_by(id) %>% summarise(pdcc1 = sum(pdmv1)/5, pdcc2 = sum(pdmv2)/5)

write.csv(sumgamedat,"Desktop/Data/Li16/sumgamedat.csv")

findat <- merge(partdat, sumgamedat, by="id")


seldat <- partdat %>% select(nat, age, gender, edu, tuk, tus, fampart, famgt, tg, id, group)

gamedat <- gamedat %>% mutate(ugcc2 = 1 - abs(ugmv2 - 50)/50)
gamedat <- gamedat %>% mutate(ugcc1 = ifelse(ugmv1 == "ACCEPT", 1, ifelse(ugmv1 == "REJECT", 0, 1 - abs(as.numeric(ugmv1)- 50)/50)))

sumgamedat2 <- gamedat %>% group_by(id) %>% summarise(role = mean(role1), ugcc1 = mean(ugcc1), ugcc2 = mean(ugcc2), ugcomp1 = sum(payoff1), ugcomp2 = sum(payoff2))

findat <- merge(findat, sumgamedat2, by="id")

#there is no 1-1 matching of IDs between gamedat and rddat

rddat <- merge(seldat, gamedat, by="id")

testdatorg <- gamedat %>% select(id, role1)
testdat2 <- rddat %>% select(id, role1)

dat <- merge(testdatorg, testdat2, by="id")



write.csv(findat,"Desktop/Data/Li16/findat.csv")
write.csv(rddat,"Desktop/Data/Li16/rddat.csv")

rddatred <- rddat %>% filter(role1 == 0)
write.csv(rddatred,"Desktop/Data/Li16/rddatred.csv")

#something goes wrong here when trying to combine the data
dat <- merge(seldat, gamedat, by="id")

#make double histograms for all the data distributions
library(ggplot2)
library(ggthemes)

longdat1 <- findat %>% select(pdcc1, id) %>% mutate(Against = "Humans")
longdat2 <- findat %>% select(pdcc2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "pdcc1"
ggdat1 <- rbind(longdat1, longdat2)
d1plot1 <- ggplot(ggdat1, aes(x=pdcc1, fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Prisoner's dilemma distributions", subtitle = "Players are more cooperative when facing humans") + xlab("Cooperate/Competitive Coefficient") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))
ggsave(d1plot1, device = "jpeg", plot = last_plot(), path = "~/Desktop/Cambridge/Li16/dat1plot1.jpeg")

longdat1 <- findat %>% select(ugcc1, id) %>% mutate(Against = "Humans")
longdat2 <- findat %>% select(ugcc2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "ugcc1"
ggdat2 <- rbind(longdat1, longdat2)
ggplot(ggdat2, aes(x=ugcc1, fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Ultimatum game distributions", subtitle = "Players' comparative cooperativity is less clear") + xlab("Cooperate/Competitive Coefficient") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))

ggplot(findat, aes(x=factor(fampart))) +
  geom_bar(stat="count", width=0.9, fill = "darkgreen")+ theme_economist() + 
  ggtitle("Participant familiarity distributions", subtitle = "Most players have little familiarity with game theory, though a discrepancy remains") + 
  xlab("Participant Familiarity with Game Theory (1 - 4)")

cor.test(findat$pdcc1, findat$pdcomp1, method = "pearson")

t.test(formula = pdcc1 ~ tg, data = findat, subset = tg %in% c(0, 1))

longdat1 <- rddat %>% select(pdmv1, id) %>% mutate(Against = "Humans")
longdat2 <- rddat %>% select(pdmv2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "pdmv1"
ggdat3 <- rbind(longdat1, longdat2)
ggplot(ggdat3, aes(x=as.factor(pdmv1), fill=Against)) +
  geom_bar(position=position_dodge()) + theme_economist() +
  ggtitle("Periodical prisoners dilemma", subtitle = "Distributions show substantial deviation") + xlab("") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold")) + 
  scale_x_discrete(limits=c("0", "1"), label = c("0" = "Cooperate", "1" = "Deviate"))

longdat1 <- rddat %>% select(pdt1, id) %>% mutate(Against = "Humans")
longdat2 <- rddat %>% select(pdt2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "pdt1"
ggdat4 <- rbind(longdat1, longdat2)
ggplot(ggdat4, aes(x=pdt1, fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Reacting to the prisoners dilemma", subtitle = "Playing against a computer begets faster decisions") + 
  xlab("Reaction Time (ms)") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))

longdat1 <- rddat %>% select(ugcc1, id) %>% mutate(Against = "Humans")
longdat2 <- rddat %>% select(ugcc2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "ugcc1"
ggdat5 <- rbind(longdat1, longdat2)
ggplot(ggdat5, aes(x=ugcc1, fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Periodical ultimatums", subtitle = "Games against humans lead to weakly more cooperative outcomes") + 
  xlab("Cooperate/Competitive Coefficient") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))

longdat1 <- rddat %>% select(ugt1, id) %>% mutate(Against = "Humans")
longdat2 <- rddat %>% select(ugt2, id) %>% mutate(Against = "Computers")
colnames(longdat2)[1] <- "ugt1"
ggdat6 <- rbind(longdat1, longdat2)
ggplot(ggdat6, aes(x=ugt1, fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Reacting to ultimatums", subtitle = "Players slowed down when faced with a human opponent") + 
  xlab("Reaction Time (ms)") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))

longdat11 <- rddatred %>% select(ugmv1, id) %>% mutate(Against = "Humans")
longdat21 <- rddatred %>% select(ugmv2, id) %>% mutate(Against = "Computers")
colnames(longdat21)[1] <- "ugmv1"
ggdat7<- rbind(longdat11, longdat21)
ggplot(ggdat7, aes(x=as.numeric(ugmv1), fill=Against)) +
  geom_density(alpha=0.6) + theme_economist() +
  ggtitle("Ultimatum offers", subtitle = "Players are slightly more generous to a human opponent") + 
  xlab("Amount Offered ($)") + 
  theme(legend.position="right", legend.title = element_text(size=14, face="bold"))



"
library(ggplot2)
library(plyr)
library(dplyr)
library(sp)
library(maptools)
library(raster)
library(rgeos)
library(rgdal)

mapdatUS <- partdat %>% filter(nat == 1)
mapdatUK <- partdat %>% filter(nat == 0)
  
US <- getData("GADM", country="USA", level=0)
US1 <- getData("GADM", country="USA", level=1)
US2 <- getData("GADM", country="USA", level=2)

UK <- getData("GADM", country="GBR", level=0)
UK1 <- getData("GADM", country="GBR", level=1)
UK2 <- getData("GADM", country="GBR", level=2)

plot(US2)


plot(Madagascar2)
#Literally started screaming after it took me an hour and a half to find the tools to load this,
# a half hour to troubleshoot the process, and then FINALLY got a legit map to appear. 

#This shows the names of the regions
Madagascar2@data$NAME_2

#So the region names on our data didn't match perfectly with the map's defined regions... 
# I had to manually change some spellings/capitalizations in the data set I had

trade.dat.map <- read.csv("trade data3.csv") # so I just read in a new file that I'll send you


#Okay so now I have to make it associate our data with the map data... wish me luck
NAME_2 <-Madagascar2@data$NAME_2

count.sellers <- function(district) {
  temp.data <- trade.dat.map %>% filter(Source.region == district)
  return(nrow(temp.data))
}

count <- sapply(NAME_2, count.sellers)

count_df<-data.frame(NAME_2, count)

#Madagascar2 <- fortify(Madagascar2, region = "NAME_2")
#ggplot() + geom_map(data = trade.dat.map, aes(map_id = NAME_2, fill = count), 
#map = Madagascar2) + expand_limits(x = Madagascar2$long, y = Madagascar2$lat)



Madagascar2@data$id <- rownames(Madagascar2@data)
Madagascar2@data <- join(Madagascar2@data, count_df, by="NAME_2")
Madagascar2_df <- fortify(Madagascar2)
Madagascar2_df <- join(Madagascar2_df,Madagascar2@data, by="id")

ggplot() + 
  geom_polygon(data = Madagascar2_df, aes(x = long, y = lat, group = group, fill =
                                            count), color = "black", size = 0.25) +
  theme(aspect.ratio=1)
#create the coefficient for UG

#cleaning notes: MOblab computer players sometimes have multiple entries for computer players with different time and move values
#i always selected the chronologically first one for the purpose of this cleaning