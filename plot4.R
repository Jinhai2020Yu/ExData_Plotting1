library(data.table)
library(dplyr)
library(lubridate)
f1 <- fread("household_power_consumption.txt", nrow = 1)
x <- dmy_hms(paste(c(f1$Date, f1$Time), collapse = " "))
y <- dmy_hms("01/02/2007 00:00:00")
z <- difftime(y, x, units = "mins")
f2 <- fread("household_power_consumption.txt", skip = as.numeric(z) + 1, nrow = 60*24*2)
names(f2) <- names(f1)
datetime = strptime(paste(f2$Date, f2$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
f2 <- cbind(f2, data.table(datetime))
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# create 4 positions for plots, row-wise
par(mfrow = c(2,2))

# plot figure 1
plot(f2$datetime, f2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# plot figure 2
plot(f2$datetime, f2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot figure 3
plot(f2$datetime, f2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(f2$datetime, f2$Sub_metering_2, type = "l", col = "red")
lines(f2$datetime, f2$Sub_metering_3, type = "l", col = "blue")

# use bty = n to get rid of legend box, use cex = 0.7 to smaller the legend
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.7)

# plot figure 4, use yaxt = n to get rid of original tick label on y axis
plot(f2$datetime, f2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", yaxt = "n")

# add y axis tick labels, use cex.axis = 0.8 to smaller the font size to put all 5 labels there
axis(2, at = seq(0, 0.5, 0.1), labels = c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5"), cex.axis = 0.8)
dev.off()