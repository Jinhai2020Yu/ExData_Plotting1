library(data.table)
library(dplyr)
library(lubridate)

# Read Line 1 to get the starting time and column name
f1 <- fread("household_power_consumption.txt", nrow = 1)

# Transform the date and time of staring point
x <- dmy_hms(paste(c(f1$Date, f1$Time), collapse = " "))

# Transform the date and time that we wanted
y <- dmy_hms("01/02/2007 00:00:00")

# Do the calculation to get the rows need to skip
z <- difftime(y, x, units = "mins")

# Read files with skip and select rows we want to keep
f2 <- fread("household_power_consumption.txt", skip = as.numeric(z) + 1, nrow = 60*24*2)

# Name the columns from original data
names(f2) <- names(f1)

# Plot to png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(f2$Global_active_power, col = "red", xlab = " Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()