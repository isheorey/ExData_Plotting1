# plot1.R
# 
# Created:  2014-10-12
# Author:   Indraneel Sheorey
# Purpose:  Downloads, unzips, and reads in the "individual household electric
#           power consumption data set", then saves the required plot 1 to PNG.

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
hpc$Date <- dmy(hpc$Date)
hpc$Time <- hms(hpc$Time)
hpc.short <- hpc[hpc$Date > "2007-01-31" &
                     hpc$Date < "2007-02-02", ]

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
hist(hpc.short$Global_active_power,
     main = "Global Active Power",
     col = "red",
     xlab = "Global Active Power (kilowatts)")
