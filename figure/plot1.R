
#Course 4 - Project 1:
#Plot 1:


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

# Plot 1:
png("plot1.png", width = 480, height = 480)
hist(final_frame$Global_active_power, col = "Red", main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200), xlim = c(0,6))


#Close connection
dev.off()
