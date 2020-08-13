#Importing libraries
library(dplyr)

# Reading data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
raw_data <- read.delim(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?")
unlink(temp)
rm(temp)

#Dealing with date-times
data <- raw_data
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S" )
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
str(data)

# Filter data by the specified dates
data <- filter(data, Date >= as.Date("2007-02-01"),Date <= as.Date("2007-02-02"))

#Plot 3
png("plot3.png", width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, type = "n", ylab = "Energy sub metering",
     xlab = "Date")
lines(data$DateTime, data$Sub_metering_1, col = "grey")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       fill=c("grey","red", "blue")
)
dev.off()
