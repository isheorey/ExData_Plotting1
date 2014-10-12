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
                  sep = ";")

# Select relevant data for time period
hpc.short <- hpc[as.Date(hpc$Date) >= '2002-02-01' &
                     as.Date(hpc$Date) <= '2002-02-02', ]
hist(hpc.short$Global_active_power, col = "red")
