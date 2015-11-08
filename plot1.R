###############################################################################
# This program generates the plot1.png graph
# Author: Tim Richer
###############################################################################

setwd("C:/Users/TimRicher/Documents/GitHub/ExData_Plotting1")

library(httr) 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip <- "household_power_consumption.zip"
if(!file.exists(zip)){
	download.file(url, zip, mode="wb")
}
pc_measurements <- paste(getwd(), "/household_power_consumption.txt", sep = "")
if(!file.exists(pc_measurements)){
	unzip(zip, list = FALSE, overwrite = FALSE, exdir = ".")
}

data <- pc_measurements
chargedata <- read.table(data, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
chargedata$Time <- strptime(paste(chargedata$Date, chargedata$Time), "%d/%m/%Y %H:%M:%S")
chargedata$Date <- as.Date(chargedata$Date, "%d/%m/%Y")
date_range <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
chargedata <- subset(chargedata, Date %in% date_range)

plot1 <- paste(getwd(), "/plot1.png", sep = "")
if(!file.exists(plot1)){
	png("plot1.png", width = 480, height = 480)
	hist(chargedata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
	dev.off()
} else {
	hist(chargedata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
}
