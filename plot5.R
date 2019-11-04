NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## subset the data that is related to motor vehicle in Baltimore

data_merged <- merge(NEI, SCC, by="SCC")

library(stringr)

data_merged_vehicle <- data_merged %>% 
  filter(fips=="24510", str_detect(SCC.Level.Two, "Vehicle")) %>% 
  group_by(year) %>% 
  summarise(total=sum(Emissions))

## make plot by ggplot2

library(ggplot2)

g<-ggplot(data_merged_vehicle, aes(x=factor(year), y=total))

g+geom_bar(stat = "identity")+
  ggtitle("Total Emissions of motor vehilcle in Baltimore over the year")+
  xlab("Year")+
  ylab("Amount of emission (tons)")+
  theme(plot.title = element_text(hjust=0.5))

## save PNG file

dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
