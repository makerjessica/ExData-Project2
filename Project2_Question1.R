##set directory, download file

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
setwd("~/Documents/coursera/exploratory data/ExDataProject2")
download.file(fileURL, "./project2.zip", method = "curl")

##unzip download
unzip("./project2.zip")

##read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find Sum of Emissions by Year
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

##plot total by year
totalByYear <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
plot(names(totalByYear), totalByYear, type="b",
     xlab="Year", ylab=expression("Total Emissions (tons)"),
     main=expression("Total US Emissions by Year"))
dev.off()
