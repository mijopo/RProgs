#Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#aggregate Emissions number by year
em_total_Balt<-aggregate(Emissions~year,data=subset(NEI,fips=="24510"), sum)

#create output file
png(file="plot2.png")
par(mfrow=c(1,1))
barplot(em_total_Balt$Emissions, names.arg=em_total_Balt$year, col="red", main="Total Baltimore City PM2.5 emissions 1999 to 2008", ylab="Total Emissions (Tons)", cex.axis=0.9)
dev.off()