library(data.table)

# Load data from Feb 1, 2007 and Feb 2, 2007 (lines 66638 through 69517)
consumption_tbl <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
names(consumption_tbl) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Combine "Date" and "Time" columns into single POSIXlt vector timestamp
timestamp <- strptime(paste(consumption_tbl$Date, consumption_tbl$Time, sep = ":"), format = "%d/%m/%Y:%T")

# Create PNG file containing line graphs of sub metering measurments over the two day period 
png(file = "plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2), mar = c(5, 4, 5, 2), cex = .75)
with(consumption_tbl, {
    tickmarks <- seq(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-03"), by = "days")
    # Plot upper left chart of global active power over time
    plot(timestamp, consumption_tbl$Global_active_power, type = "l", xaxt = "n", col = "black", xlab = "", ylab = "Global Active Power")
    axis.POSIXct(side = 1, at = tickmarks, labels = TRUE)
    # Plot upper right chart of voltage over time
    plot(timestamp, consumption_tbl$Voltage, type = "l", xaxt = "n", col = "black", ylab = "Voltage", xlab = "datetime")
    axis.POSIXct(side = 1, at = tickmarks, labels = TRUE)
    # Plot lower left chart of energy sub metering over time
    plot(timestamp, consumption_tbl$Sub_metering_1, type = "l", xaxt = "n", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(timestamp, consumption_tbl$Sub_metering_2, type = "l", xaxt = "n", col = "red", yaxt = "n")
    lines(timestamp, consumption_tbl$Sub_metering_3, type = "l", xaxt = "n", col = "blue", yaxt = "n")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = c(1, 1, 1), lwd = c(1.5, 1.5, 1.5), col = c("black", "red", "blue"))
    axis.POSIXct(side = 1, at = tickmarks, labels = TRUE)
    # Plot lower right chart of global reactive power over time
    plot(timestamp, consumption_tbl$Global_reactive_power, type = "l", xaxt = "n", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
    axis.POSIXct(side = 1, at = tickmarks, labels = TRUE)
})
dev.off()