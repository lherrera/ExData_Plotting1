#########################################################################
#
## DESCRIPTION - Plot4.R
# This assignment uses data from the UC Irvine Machine Learning Repository. In particular, we will be using the 
# "Individual household electric power consumption Data Set" to plot Global Active Power, Voltage, Energy sub metering and 
# Energy reactive power over time.
#
# Our overall goal here is  to examine how household energy usage varies over a 2-day period in February, 2007
#
## AUTHOR
# Luis Herrera
#
## USAGE
# source("plot4.R")
#
## REQUIRERMEMENTS 
# None, the program checks for required libraries and downloads the file from its localtion in internet
#
## INPUT
# This program downloads and unzip the file
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
## OUTPUT
# A png file with the corresponding plot- plot4.png 
#########################################################################


# To ensure English locale is used for Date/Time
Sys.setlocale(category="LC_TIME", locale="C")


########################################################################
# Downloads and unzip files
######################################################################### 
dataDir <- "./data"
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

dataFile <- paste0(dataDir,"/household_power_consumption.txt")
if (!file.exists(dataFile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  
  fileName <- paste0(dataDir,"/dataset.zip")
  download.file(fileUrl, fileName, method="curl")
  unzip(fileName, exdir=dataDir)
}

#########################################################################
# Loads file and selects  only the dates from 2007-02-01 to 2007-02-02.
######################################################################## 
dataSet <- read.table(dataFile,
                      header = TRUE,
                      sep = ";",
                      na.strings = "?",
                      colClasses=c("character","character",rep("numeric",7)) )

dataSet <- subset(dataSet, Date %in% c('1/2/2007','2/2/2007'))

#########################################################################
# Adds and Converts Data and Time variables
######################################################################## 
dataSet$DateTime <- strptime(paste(dataSet$Date, dataSet$Time), format="%d/%m/%Y %H:%M:%S")

#########################################################################
# generates 
######################################################################## 


png(filename = "plot4.png",
    width = 480, 
    height = 480, 
    units = "px")

par(mfrow = c(2,2))

with ( dataSet, {
  
  # 1: Global Active Power over time
  plot(DateTime,
       Global_active_power,
       type="l",
       xlab="",
       ylab="Global Active Power")
  
  # 2:Voltage over time
  plot(DateTime,
       Voltage, 
       type = "l",
       xlab = "datetime",
       ylab = "Voltage")
  
  # 3:Energy sub metering over time
  
  plot(DateTime,
       Sub_metering_1, 
       type="l",
       xlab="", 
       ylab="Energy sub metering")
  
  points(DateTime,
        Sub_metering_2, 
        type = "l",  
        col = "red")
  
  points( DateTime,
         Sub_metering_3, 
         type = "l", 
         col = "blue")
  
  legend( "topright",
          lwd=1,
          col = c("black","red","blue"), 
          legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # 4: Global Reactive Power over time
  plot( DateTime,
       Global_reactive_power, 
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
})
       
dev.off()