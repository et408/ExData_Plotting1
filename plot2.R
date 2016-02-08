library(data.table)

# Load data from Feb 1, 2007 and Feb 2, 2007 (lines 66638 through 69517)
consumption_tbl <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
names(consumption_tbl) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Combine "Date" and "Time" columns into single POSIXlt vector timestamp
timestamp <- strptime(paste(consumption_tbl$Date, consumption_tbl$Time, sep = ":"), format = "%d/%m/%Y:%T")

# Create PNG file containing line graph of global active power measurments over the two day period 
png(file = "plot2.png", height = 480, width = 480)
par(mar = c(5, 4, 5, 2))
plot(timestamp, consumption_tbl$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)", oma = 50)
tickmarks <- seq(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-03"), by = "days")
axis.POSIXct(side = 1, at = tickmarks, labels = TRUE)
dev.off()