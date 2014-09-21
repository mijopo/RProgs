library(ggplot2)
#Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#get vehicle references
veh_ref <- SCC[grep("Vehic",SCC$EI.Sector),1]

#subset NEI data to get SCC references that have names containing 'vehic' and fips numbers corresponding to Baltimore City or LA County
NEI_veh_mv <- NEI[NEI$SCC %in% veh_ref & NEI$fips %in% c("24510","06037"),]

#Rename fips #s with county names
NEI_veh_mv$fips[NEI_veh_mv$fips=="24510"]="Baltimore City"
NEI_veh_mv$fips[NEI_veh_mv$fips=="06037"]="Los Angeles County"

#Use Year and fips to aggregate emission number
agg_mv_county <-aggregate(Emissions~year+fips,data=NEI_veh_mv,sum)

names(agg_mv_county)[2]="County"


#Get diffs for Baltimore city and LA County
Balt_diff = agg_mv_county[agg_mv_county$year==2008 & agg_mv_county$County=="Baltimore City","Emissions"] - agg_mv_county[agg_mv_county$year==1999 & agg_mv_county$County=="Baltimore City","Emissions"]
LA_diff = agg_mv_county[agg_mv_county$year==2008 & agg_mv_county$County=="Los Angeles County","Emissions"] - agg_mv_county[agg_mv_county$year==1999 & agg_mv_county$County=="Los Angeles County","Emissions"]

#Annotation for lines
Balt_annotate <- paste("Change over time =", round(Balt_diff, digits=2))
LA_annotate <- paste("Change over time =", round(LA_diff, digits=2))



#Create file
png(file="plot6.png")


ggplot(data=agg_mv_county, aes(x=year, y=Emissions, group=County,color=County)) + geom_line(size=1)+geom_point(size=2,fill="white")+xlab("Year")+labs(y=expression("Emissions"*PM[2.5]))+ggtitle("Vehicle Emissions-Baltimore City vs LA County")+annotate("text",x=2002,y=500,cex=3,label=Balt_annotate)+annotate("text",x=2002,y=4000,cex=3,label=LA_annotate)


dev.off()