NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initial data exploration
head(NEI)
str(NEI)
summary(NEI)

head(SCC)
str(SCC)

library(dplyr)

## Calculate total amount of emission per year

total_PM <- NEI %>% 
  group_by(year) %>% 
  summarise(total=sum(Emissions))

## make base plot

barplot(names.arg=total_PM$year, height=total_PM$total/1000, ylim = c(0,8000),xlab = "Year", ylab = expression('Total PM'[2.5]*' emission (kilotons)'), main = "Total emission over the year")

## save PNG file

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
