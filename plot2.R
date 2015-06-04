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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## Step 3: Create a line
with(powerData, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

## Step 4: Save the file
dev.off()