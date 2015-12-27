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

##combine Datasets
Alldata <- merge(NEI, SCC, by="SCC")

##subset Coal Combustion
coalMatches  <- grepl("coal", Alldata$EI.Sector, ignore.case=TRUE)
coaldata <- Alldata[coalMatches, ]

##aggregate by year
coalTotalByYear <- aggregate(Emissions ~ year, coaldata, sum)

##plot Data
png("plot4.png")
g <- qplot(year, Emissions, data = coalTotalByYear, geom = "line")
g<- g + ggtitle("Total Coal Emissions in United States 1999-2008")
print(g)
dev.off()
