NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## Merge two data and subset the one that is related to coal

data_merged <- merge(NEI, SCC, by="SCC")

library(stringr)

data_merged_coal <- data_merged %>% 
  filter(str_detect(Short.Name, "coal")) %>% 
  group_by(year) %>% 
  summarise(total=sum(Emissions))

## make plot by ggplot2

library(ggplot2)

g<-ggplot(data_merged_coal, aes(x=factor(year), y=total))

g+geom_bar(stat = "identity")+
  ggtitle("Total Emissions of coal over the year")+
  xlab("Year")+
  ylab("Amount of emission (tons)")+
  theme(plot.title = element_text(hjust=0.5))

## save PNG file

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
