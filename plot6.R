NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## subset the data that is related to motor vehicle in Baltimore and Los Angeles

data_merged <- merge(NEI, SCC, by="SCC")

library(stringr)

data_merged_vehicle2 <- data_merged %>% 
  filter(fips %in% c("24510","06037"), str_detect(SCC.Level.Two, "Vehicle")) %>% 
  group_by(year, fips) %>% 
  summarise(total=sum(Emissions))

## make plot by ggplot2

library(ggplot2)

g<-ggplot(data_merged_vehicle2, aes(x=year, y=total, col = fips))

g+geom_line()+
  geom_point()+
  ggtitle("Total Emissions of motor vehilcle in Baltimore 
          / Los Angeles over the year")+
  xlab("Year")+
  ylab("Amount of emission (tons)")+
  theme(plot.title = element_text(hjust=0.5))

## save PNG file

dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()
