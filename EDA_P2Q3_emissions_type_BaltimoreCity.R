library(ggplot2)
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get Baltimore aggregation
em_total_Balt<-aggregate(Emissions~type+year,data=subset(NEI,fips=="24510"), sum)

#arrange types into factor and order
em_total_Balt$type<-factor(em_totat_Balt$type,levels=c("POINT","NONPOINT","ON-ROAD","NON-ROAD"))

#create output file
png(file="plot3.png")
#ggplot(data=em_total_Balt[em_total_Balt$year %in% c(1999,2008),], aes(x=as.factor(year), y=Emissions, fill=year)) + geom_bar(color="black",stat="identity")+facet_wrap(~type)+xlab("Year")+labs(y=expression("Emissions"*PM[2.5]))+ggtitle("Emissions by Type and Year in Baltimore City")
ggplot(data=em_total_Balt, aes(x=as.factor(year), y=Emissions, fill=year)) + geom_bar(color="black",stat="identity")+facet_wrap(~type)+xlab("Year")+labs(y=expression("Emissions"*PM[2.5]))+ggtitle("Emissions by Type and Year in Baltimore City")

dev.off()