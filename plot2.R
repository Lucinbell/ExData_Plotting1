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

#opening graphing device
png(filename = "plot2.png",
    width = 480, height = 480)

# Creating the graph
with(data_t, plot(
                  Date_time, Global_active_power,
                  main = "",
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)",
                  pch = "",
                  lines(Date_time, Global_active_power, lwd = 1)
                  )
     )

# Turning off graphing device and generating the file
dev.off()