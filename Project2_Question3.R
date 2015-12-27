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

##Subset Baltimore
baltimore <- filter(NEI, fips == 24510)
baltimoretypebyyear <- aggregate(Emissions ~ year + type, baltimore, sum)

##make the plot
png("plot3.png")
g<-qplot(year, Emissions, data = baltimoretypebyyear, color=type, geom = "line")

##add title
g <- g + ggtitle("Total Baltimore City Emissions by Type 1999-2008")
print(g)
dev.off()
