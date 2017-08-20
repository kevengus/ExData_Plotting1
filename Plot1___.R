
##Download and unzip instructions
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(zipUrl, destfile = temp)
data <- read.table(unz(temp, 'household_power_consumption.txt'), sep =";", header = TRUE, na.strings = '?')
unlink(temp)

## Subset read.table along an OR join of the two booleans for the two dates.
data2 <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'),]

data2$DateTime <- paste(data2$Date, data2$Time)
data2$DateTime <- as.POSIXct(data2$DateTime, format = '%d/%m/%Y %H:%M:%S')

##Plot 1
## need to check that I have the right number of bins and heights.
png(filename = 'Plot1.png', width = 480, height = 480, units = 'px')
hist(data2$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', col = 'red')
dev.off()

##Plot 2: 
png(filename = 'Plot2.png', width = 480, height = 480, units = 'px')
plot(data2$DateTime, data2$Global_active_power, type = 'l', xlab = NA, ylab = 'Global Active Power (killowatts)')
dev.off()

##Plot3
png(filename = 'Plot3.png', width = 480, height = 480, units = 'px')
plot(data2$DateTime, data2$Sub_metering_1, type = 'l', xlab = NA, ylab = 'Energy sub metering', col = 'black')
lines(data2$DateTime, data2$Sub_metering_2, type = 'l', col = 'red')
lines(data2$DateTime, data2$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), lty = c(1,1,1))
dev.off()

##Plot4
png(filename = 'Plot4.png', width = 480, height = 480, units = 'px')
par(mfrow=c(2,2))
plot(data2$DateTime, data2$Global_active_power, type = 'l', xlab = NA, ylab = 'Global Active Power')
plot(data2$DateTime, data2$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
plot(data2$DateTime, data2$Sub_metering_1, type = 'l', xlab = NA, ylab = 'Energy sub metering', col = 'black')
lines(data2$DateTime, data2$Sub_metering_2, type = 'l', col = 'red')
lines(data2$DateTime, data2$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'), lty = c(1,1,1))
plot(data2$DateTime, data2$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()

