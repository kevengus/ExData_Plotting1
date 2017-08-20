##Download and unzip instructions
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(zipUrl, destfile = temp)
data <- read.table(unz(temp, 'household_power_consumption.txt'), sep =";", header = TRUE, na.strings = '?')
unlink(temp)

##Filter for dates
data2 <- data[(data$Date == '1/2/2007' | data$Date == '2/2/2007'),]

##Create POSIXct datatime column
data2$DateTime <- paste(data2$Date, data2$Time)
data2$DateTime <- as.POSIXct(data2$DateTime, format = '%d/%m/%Y %H:%M:%S')

##Plot 1
png(filename = 'Plot1.png', width = 480, height = 480, units = 'px')
hist(data2$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', col = 'red')
dev.off()
