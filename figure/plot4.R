#Course 4 - Project 1:
#Plot 4:


#Loading library 

library(dplyr)

#Loading the data

ColNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", "Sub_meterings_3")
data_frame <- read.table(file = "household_power_consumption.txt", header = FALSE, sep = ";", col.names = ColNames, skip = 1)

#Modifying the dataset

data_frame <- data_frame[apply(data_frame, 1, function(x) !any(grepl("\\?", x))),  ]
data_frame <- data_frame %>% mutate(across(3:9, as.numeric))
data_frame <- data_frame %>% mutate(date_time = as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M"))
data_frame <- data_frame[, -c(1:2)]


# Subsetting from dates

final_frame <- data_frame[as.Date(data_frame$date_time) >= as.Date("2007-02-01") &
                            as.Date(data_frame$date_time) <= as.Date("2007-02-02"),  ]


# Plot 4:

png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
ticks <- seq(from = min(final_frame$date_time), to = max(final_frame$date_time + 60), by = "1 day")


par(mar = c(4,4,4,4))
ticks <- seq(from = min(final_frame$date_time), to = max(final_frame$date_time + 60), by = "1 day")

plot(final_frame$date_time, final_frame$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")
axis(1, at = ticks, labels = format(ticks, "%a"))

plot(final_frame$date_time, final_frame$Sub_metering_1, col = "black", xaxt = "n", type = "l", ylab = "Energy sub metering", xlab = "")
lines(final_frame$date_time, final_frame$Sub_metering_2, col = "red", type = "l")
lines(final_frame$date_time, final_frame$Sub_meterings_3, col = "blue", type = "l")


ticks <- seq(from = min(final_frame$date_time), to = max(final_frame$date_time + 60), by = "1 day")
axis(1, at = ticks, labels = format(ticks, "%a"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n" )

#Voltage vs datetime

plot(final_frame$date_time, final_frame$Voltage, xaxt = "n", ylab = "Voltage", xlab = "datetime", type = "l")
axis(1, at = ticks, labels = format(ticks, "%a") )

#Global Reactive Power

plot(final_frame$date_time, final_frame$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n", type = "l")
axis(1, at = ticks, labels = format(ticks, "%a"))



#Close connection
dev.off()
