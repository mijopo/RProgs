library(ggplot2)
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get SCC lines that contain string 'Coal'
coal_lab <- SCC[grep("Coal",SCC$EI.Sector),1]

#Subset NEI with just rows that reference coal
NEI_coal <- NEI[NEI$SCC %in% coal_lab,]

#Aggregate coal data by year
coal_data <-aggregate(Emissions~year,data=NEI_coal,sum)

#create output file
png(file="plot4.png")

ggplot(data=coal_data, aes(x=as.factor(year), y=Emissions, fill=year)) + geom_bar(color="black",stat="identity")+labs(y=expression("Emissions"*PM[2.5]))+ggtitle("US Emissions from coal")

dev.off()