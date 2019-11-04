NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## Subset data of baltimore and calculate total amount of emission per year

baltimore_total <- NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarise(total=sum(Emissions))

## make base plot

barplot(names.arg=baltimore_total$year, height=baltimore_total$total, ylim = c(0,4000),xlab = "Year", ylab = expression('Total PM'[2.5]*' emission (tons)'), main = "Total emission over the year in Baltimore")

## save PNG file

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
