library(data.table)

# Load data from Feb 1, 2007 and Feb 2, 2007 (lines 66638 through 69517)
consumption_tbl <- fread("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
names(consumption_tbl) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Create PNG file containing histogram of frequencies for global active power 
png(file = "plot1.png", height = 480, width = 480)
par(mar = c(5, 5, 5, 2))
hist(consumption_tbl$Global_active_power, freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()