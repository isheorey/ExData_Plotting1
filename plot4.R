# plot2.R
# 
# Created:  2014-10-12
# Author:   Indraneel Sheorey
# Purpose:  Downloads, unzips, and reads in the "individual household electric
#           power consumption data set", then saves the required plot 3 to PNG.

# Download data
message("Downloading data...")
url <- paste("https://d396qusza40orc.cloudfront.net/",
             "exdata%2Fdata%2Fhousehold_power_consumption.zip", sep = "")
dir.create("data")
path <- "data/household_power_consumption.zip"
download.file(url, path)

# Unzip data
message("Extracting data...")
unzip("data/household_power_consumption.zip", exdir = "data")

# Read in data
message("Reading in dataset...")
hpc <- read.table("data/household_power_consumption.txt",
                  header = TRUE,
                  sep = ";",
                  colClasses = rep("character", 9))

# Select relevant data for time period
library(lubridate)
hpc$Date.Time <- dmy_hms(paste(hpc$Date, hpc$Time))
hpc.short <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007", ]

# Convert data types
hpc.short$Global_active_power <-
    as.numeric(ifelse(hpc.short$Global_active_power == "?",
                      NA,
                      hpc.short$Global_active_power))
hpc.short$Global_reactive_power <-
    as.numeric(ifelse(hpc.short$Global_reactive_power == "?",
                      NA,
                      hpc.short$Global_reactive_power))
hpc.short$Voltage <-
    as.numeric(ifelse(hpc.short$Voltage == "?",
                      NA,
                      hpc.short$Voltage))
hpc.short$Global_intensity <-
    as.numeric(ifelse(hpc.short$Global_intensity == "?",
                      NA,
                      hpc.short$Global_intensity))
hpc.short$Sub_metering_1 <-
    as.numeric(ifelse(hpc.short$Sub_metering_1 == "?",
                      NA,
                      hpc.short$Sub_metering_1))
hpc.short$Sub_metering_2 <-
    as.numeric(ifelse(hpc.short$Sub_metering_2 == "?",
                      NA,
                      hpc.short$Sub_metering_2))
hpc.short$Sub_metering_3 <-
    as.numeric(ifelse(hpc.short$Sub_metering_3 == "?",
                      NA,
                      hpc.short$Sub_metering_3))

# Plot data
png(file = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2, 2))
with(hpc.short,
    {
        plot(Date.Time,
             Global_active_power,
             type = "l",
             xlab = "",
             ylab = "Global Active Power")
        plot(Date.Time,
             Voltage,
             type = "l",
             xlab = "datetime",
             ylab = "Voltage")
        plot(Date.Time,
             Sub_metering_1,
             type = "l",
             xlab = "",
             ylab = "Energy sub metering")
        with(hpc.short, lines(Date.Time, Sub_metering_2, col = "red"))
        with(hpc.short, lines(Date.Time, Sub_metering_3, col = "blue"))
        legend("topright",
               lwd = 1,
               col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty = "n")
        plot(Date.Time,
             Global_reactive_power,
             type = "l",
             xlab = "datetime",
             ylab = "Global_reactive_power")
    })
dev.off()
