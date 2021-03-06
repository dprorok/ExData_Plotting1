library(lubridate)

colNames <- as.character(read.table("household_power_consumption.txt", 
                                    sep=";", nrows=1, 
                                    stringsAsFactors = FALSE))

colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                "numeric", "numeric", "numeric", "numeric")

#My computer is eight years old and I'm impatient, so I'm loading in
#only the data I need and not one ounce more.
data <- read.table("household_power_consumption.txt", sep=";",
                   na.strings = "?", nrows=2880, skip=66637, 
                   col.names = colNames,
                   colClasses=colClasses)

data$Date <- dmy(data$Date)
data$Time <- strptime(data$Time, "%H:%M:%S", tz="CET")
data$Time <- update(data$Time, day=day(data$Date), 
                    month=month(data$Date), year=year(data$Date))

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))
#Plot 1
with(data, plot(Time, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power"))

#Plot 2
with(data, plot(Time, Sub_metering_1, type = "l", col="black",
                xlab = "", ylab = "Energy sub metering"))
with(data, points(Time, Sub_metering_2, type="l", col="red"))
with(data, points(Time, Sub_metering_3, type="l", col="blue"))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col=c("black", "red", "blue"), bty="n")

#Plot 3
with(data, plot(Time, Voltage, type = "l", 
                xlab = "datetime", ylab = "Voltage"))

#Plot 4
with(data, plot(Time, Global_reactive_power, type = "l", 
                xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()