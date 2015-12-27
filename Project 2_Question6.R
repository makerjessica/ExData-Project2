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

##subset Motor Vehicles in Baltimore and Las Angeles
compcars <- NEI[NEI$fips == "24510" | "06037" & NEI$type == "ON-ROAD", ]

##Subset Motor Vehicles in Baltimore (not necessecary, but a good double check on combined)
baltimorecars <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

##subset Motor Vehicles in Las Angeles (not necessecary, but a good double check on combined)
LACars <- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD", ]

##Number of observations in Baltimore subset added to observations in LA equal observations in Compcars.

##aggregate by year
compcarsByYearAndfips <- aggregate(Emissions ~ year + fips, compcars, sum)
compcarsByYearAndfips$fips[compcarsByYearAndfips$fips=="24510"] <- "Baltimore, MD"
compcarsByYearAndfips$fips[compcarsByYearAndfips$fips=="06037"] <- "Los Angeles, CA"

##plot Data
png("plot6.png")
g <- qplot(year, Emissions, data = compcarsByYearAndfips, geom = "line", color= fips, facets = .~fips)
g<- g + ggtitle("Total Motor Vehicle Emissions \n Baltimore City, MD and Las Angeles County, CA \n 1999-2008")
print(g)
dev.off()