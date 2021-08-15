## reading data from the working directory and formatting the date column
data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", na.strings = "?")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_t <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

Date_time <- as.POSIXct(paste(data_t$Date, data_t$Time),
                        tz = "America/Los_Angeles")

data_t <- cbind(Date_time, data_t)

# Removing un-needed objects from workspace
remove(data)
data_t$Date <- NULL
data_t$Time <- NULL
remove(Date_time)

# opening graphing device
png(filename = "plot4.png",
    width = 480, height = 480)

#Configure par() parameters
par(mfrow = c(2, 2))

#graph 1
with(data_t, plot(
  Date_time, Global_active_power,
  main = "",
  xlab = "",
  ylab = "Global Active Power",
  pch = "",
  lines(Date_time, Global_active_power, lwd = 1)
)
)

#graph 2
with(data_t, plot(Date_time, Voltage, pch="", xlab = "datetime",
                  lines(Date_time, Voltage, lwd = 1))
     )

#graph 3
with(data_t, plot(Date_time, Sub_metering_1, 
                  main = "", type = "n", 
                  ylab = "Energy sub metering",
                  xlab = ""))

with(data_t, lines(Date_time, Sub_metering_1, col = "black", lwd = 1))
with(data_t, lines(Date_time, Sub_metering_2, col = "red", lwd = 1))
with(data_t, lines(Date_time, Sub_metering_3, col = "blue", lwd = 1))

legend("topright", col = c("black", "red", "blue"), lwd = 1, lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", x.intersp = 1)


#graph 4
with(data_t, plot(Date_time, Global_reactive_power, pch="", xlab = "datetime",
                  lines(Date_time, Global_reactive_power))
)

# Turning off graphing device and generating file
dev.off()