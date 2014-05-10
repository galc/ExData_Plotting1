## plot3.R - Timeline Plot of Global_active_power

## Read Data
data <- read.table('Data/household_power_consumption.txt', sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric', 'numeric', 'numeric'),
                   na.strings='?')

## Convert dates and subset on two days in February 2007
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & 
                 as.Date(DateTime) <= as.Date("2007-02-02"))

## Create a file named plot4.png with dimension of 480x480
png("plot4.png", height=480, width=480)

## Prepare to draw multiple graphs in a 2x2 layout
par(mfrow=c(2,2))

## Build the wrapping timeline
plot(data$DateTime, data$Global_active_power, pch=NA, xlab="", ylab="Global Active Power (kilowatts)")
## Draw the timeline
lines(data$DateTime, data$Global_active_power)


## Voltage timeline plot
plot(data$DateTime, data$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(data$DateTime, data$Voltage)


## Build the wrapping timeline
plot(data$DateTime, data$Sub_metering_1, pch=NA, xlab="", ylab="Energy sub metering")
## Draw the timeline
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c('black', 'red', 'blue'), bty='n')

## Global_reactive_power timeline plot
plot(data$DateTime, data$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", pch=NA)
lines(data$DateTime, data$Global_reactive_power)

# Close PNG file
dev.off()
