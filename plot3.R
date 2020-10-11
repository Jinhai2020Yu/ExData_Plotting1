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
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# plot sub_metering_1
plot(f2$datetime, f2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")

# add sub_metering_2
lines(f2$datetime, f2$Sub_metering_2, type = "l", col = "red")

# add sub_metering_3
lines(f2$datetime, f2$Sub_metering_3, type = "l", col = "blue")

# add legend
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()