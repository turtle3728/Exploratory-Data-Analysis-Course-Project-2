NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## Subset data of baltimore and calculate total amount of emission based on type per year

baltimore_total2 <- NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year, type) %>% 
  summarise(total=sum(Emissions))

## make plot by ggplot2

library(ggplot2)

g<-ggplot(baltimore_total2, aes(x=year, y=total, color=type))

g+geom_line()+
  geom_point()+
  xlab("Year")+
  ylab("Amount of emission (tons)")+
  ggtitle("Total Emissions in Baltimore City")+
  theme(plot.title = element_text(hjust=0.5))

## save PNG file

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
