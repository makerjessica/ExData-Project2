##set libraries
library(dplyr)
library(ggplot2)

##set directory, download file
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
setwd("~/Documents/coursera/exploratory data/ExDataProject2")
download.file(fileURL, "./project2.zip", method = "curl")

##unzip download
unzip("./project2.zip")

##read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset Motor Vehicles in Baltimore
baltimorecars <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

##aggregate by year
baltimorecarsbyyear <- aggregate(Emissions ~ year, baltimorecars, sum)

##plot Data
png("plot5.png")
g <- qplot(year, Emissions, data = baltimorecarsbyyear, geom = "line")
g<- g + ggtitle("Total Motor Vehicle Emissions in Baltimore City 1999-2008")
print(g)
dev.off()