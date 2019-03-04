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

#5. Plot1
hist(subsetdata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#6. save to plot1.PNG
dev.copy(png, file="plot1.png", height=480, width=480)  ## Copy plot to a PNG file
dev.off()  ## to close the PNG device

