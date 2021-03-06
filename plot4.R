## Step 0: Check if data exists
if(!file.exists("./household_power_consumption.txt")) {
  data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(data_url, destfile="./data.zip", method="curl")
  dateDownloaded <- date()
  unzip("./data.zip")
}

## Step 1: Load the data, change "?" to NAs, convert Date to Date Objects, Subset data to be between 2007-02-01 and 2007-02-02, inclusive
## Note: Only loads data if not already loaded
if(!exists("powerData")) {
  powerData <- read.table("./household_power_consumption.txt", sep = ";", header=TRUE, colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"))
  powerData[powerData=="?"] <- NA
  powerData$Date <- strptime(paste(powerData$Date, powerData$Time),format="%d/%m/%Y %H:%M:%S", tz="")
  powerData[,3:9] <- sapply(powerData[,3:9],as.numeric)
  powerData <- subset(powerData, Date >= strptime("2007-02-01", format="%Y-%m-%d") & Date < strptime("2007-02-03", format="%Y-%m-%d"))
}

## Step 2: Create & Open the PNG Graphics Device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

## Step 3: Create the graphs
with(powerData, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))  ## Graph 1

with(powerData, plot(Date, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")) ## Graph 2

with(powerData, plot(Date, Sub_metering_1, col = "black", type="l", ylab = "Energy sub metering", xlab="")) ## Graph 3
with(powerData, lines(Date, Sub_metering_3, col = "blue")) ## Graph 3
with(powerData, lines(Date, Sub_metering_2, col = "red")) ## Graph 3
legend("topright", pch = , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), xjust=1, col = c("black", "red", "blue"), lty=1) ## Graph 3

with(powerData, plot(Date, Global_reactive_power, type = "l", xlab = "datetime")) ## Graph 4

## Step 4: Close the graphics device
dev.off()