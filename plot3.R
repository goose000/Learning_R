memreq<-2075259*120*10/2^20 #calculate memory required for entire file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "./household_power_consumption.zip")
unzip("household_power_consumption.zip")
initial<-read.table("household_power_consumption.txt",nrows=100,header=T,sep=";"
                    ,comment.char = "",stringsAsFactors = F)
classes=sapply(initial,class)
powerdata<-read.table("household_power_consumption.txt",nrows=2900,header=F,sep=";",
                      comment.char = "",colClasses = classes,skip=66630,
                      stringsAsFactors = F)
names(powerdata)<-names(initial)
startdate<-as.Date("01/02/2007","%d/%m/%Y")
enddate<-as.Date("03/02/2007","%d/%m/%Y")

powerdata$Date<-as.Date(powerdata$Date,"%d/%m/%Y")

graph_data<-subset(powerdata,Date<enddate)
graph_data<-subset(graph_data,Date>=startdate)
temp<-paste(graph_data$Date,graph_data$Time)
graph_data$Time<-strptime(temp,"%Y-%m-%d %H:%M:%S")



#create Sub_meter Plot
png("plot3.png")
with(graph_data,plot(Time,Sub_metering_1,ylab="Energy Sub Metering",type="n"))
with(graph_data,lines(Time,Sub_metering_1))
with(graph_data,lines(Time,Sub_metering_2,col="red"))
with(graph_data,lines(Time,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

