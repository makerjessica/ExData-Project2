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

##Find Sum of Emissions by Year
totalByYear <- tapply(baltimore$Emissions, baltimore$year, sum)

##plot total by year

png("plot2.png")
plot(names(totalByYear), totalByYear, type="b",
     xlab="Year", ylab=expression("Baltimore Total Emissions (tons)"),
     main=expression("Total Baltimore Emissions by Year"))
dev.off()
