#1. Downloading and unzipping dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/assignmentdata.zip")
unzip(zipfile="./data/assignmentdata.zip",exdir="./data")

#2. read dataset
data1 <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE) 
names(data1) 
head(data1)

#3. subset: dates from 2007-02-01 to 2007-02-02
subsetdata <- subset(data1[data1$Date == "2/2/2007" | data1$Date == "1/2/2007",])
unique(subsetdata$Date)

#4. convert and add date/time variables
str(subsetdata)

subsetdata <- transform(subsetdata, Date = as.Date(subsetdata$Date, format = "%d/%m/%Y")) 

subsetdata$datetime <- strptime( paste(subsetdata$Date, subsetdata$Time), format = "%Y-%m-%d %H:%M:%S" )

#5. Plot4
par(mfrow = c(2,2))

##graph1
plot(subsetdata$datetime, subsetdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")  

##graph2
plot(subsetdata$datetime, subsetdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") 

##graph3
plot(subsetdata$datetime, subsetdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")  
lines(subsetdata$datetime, subsetdata$Sub_metering_2, type = "l", col="red")  
lines(subsetdata$datetime, subsetdata$Sub_metering_3, type = "l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty="n")

##graph4
plot(subsetdata$datetime, subsetdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#6. save to PNG
dev.copy(png, file="plot4.png", height=480, width=480)  ## Copy plot to a PNG file
dev.off()  ## to close the PNG device
