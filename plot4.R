# downloading and unzipping the data
if(!file.exists("data")) dir.create("data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

# reading the data
files <- file("./data/household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ";", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = "?")

# converting dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

# Plot 4
if(!file.exists("figures")) dir.create("figures")
png(filename = "./figures/plot4.png", width = 480, height = 480, units="px")
par(mfrow = c(2, 2))

## SubPlot 1
plot(data$DateTime, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatt)", type = "l")


## SubPlot 2
plot(data$DateTime, data$Voltage, xlab = "", ylab = "Voltage", type = "l", sub = "datetime")


## SubPlot 3
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

## SubPlot 4
plot(data$DateTime, data$Global_reactive_power, xlab = "", ylab = "Global_reactive_power (kilowatt)", type = "l", sub = "datetime")

dev.off()