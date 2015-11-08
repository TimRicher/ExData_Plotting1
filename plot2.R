###############################################################################
# This program generates the plot2.png graph
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

plot2 <- paste(getwd(), "/plot2.png", sep = "")
if(!file.exists(plot2)){
	png("plot2.png", width = 480, height = 480)
	plot(chargedata$Time, chargedata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
	dev.off()
} else {
	plot(chargedata$Time, chargedata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
}

