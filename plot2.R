library(data.table)
library(dplyr)
library(lubridate)
f1 <- fread("household_power_consumption.txt", nrow = 1)
x <- dmy_hms(paste(c(f1$Date, f1$Time), collapse = " "))
y <- dmy_hms("01/02/2007 00:00:00")
z <- difftime(y, x, units = "mins")
f2 <- fread("household_power_consumption.txt", skip = as.numeric(z) + 1, nrow = 60*24*2)
names(f2) <- names(f1)

# Create a new variable that contains Date and Time
datetime = strptime(paste(f2$Date, f2$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Add new variable to exited dataset with cbind and data.table

f2 <- cbind(f2, data.table(datetime))

#plot png file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(f2$datetime, f2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()