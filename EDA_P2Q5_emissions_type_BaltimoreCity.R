library(ggplot2)
#Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Get vehicle references from the SCC file:
veh_ref <- SCC[grep("Vehicl",SCC$EI.Sector),1]

#subset NEI with SCC values that contain 'Vehicl' and in the 24510 fips code
NEI_veh_BC <- NEI[NEI$SCC %in% veh_ref & NEI$fips=="24510",]

#Aggregate data by yeart
agg_mv_data <-aggregate(Emissions~year,data=NEI_veh_BC,sum)

#Create file
png(file="plot5.png")

#ggplot instructions
ggplot(data=NEI_veh_BC, aes(x=as.factor(year), y=Emissions, fill=year)) + geom_bar(color="black",stat="identity")+xlab("Year")+labs(y=expression("Emissions"*PM[2.5]))+ggtitle("Motor Vehicle Emissions-Baltimore City")

dev.off()