## Plots a 2x2 plotting grid for the "household_power_consumption.txt" dataset.

## The grid plots are:
##      top-left: date+time v. Global Active Power
##   bottom-left: date+time v. active energy by sub-meter
##     top-right: date+time v. Voltage
##  bottom-right: date+time v. Global Reactive Power

## Assumes "household_power_consumption.txt" is in working directory.

plot4 <- function() {

  # read and condition the data
  col_classes <- c("character", "character", "double", "double", "double", 
                 "double", "double", "double", "double")
  data <- read.delim("household_power_consumption.txt", sep = ";",
                     na.strings = "?", colClasses = col_classes)
  data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]  
  datetime <- strptime(paste(data$Date, data$Time, sep = " "),
                       "%d/%m/%Y %H:%M:%S")
  data <- data.frame(datetime, data[, 3:9])
  
  # open the file device, set the plotting grid and plot
  png(file = "plot4.png", height = 504, width = 504, bg = "transparent")
  par(mfcol = c(2,2)) # set grid
  with(data, {
    
    # plot top-left graph
    plot(datetime, Global_active_power, 
         type = "n", 
         xlab = "", 
         ylab = "Global Active Power")
    lines(datetime, Global_active_power)
    
    # plot bottom-left graph
    plot(datetime, Sub_metering_1, 
         type = "n", 
         xlab = "", 
         ylab = "Energy sub metering")
    lines(datetime, Sub_metering_1, col = "black")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", lwd = 1, 
           bty = "n",
           col = c("black", "red", "blue"), 
           legend = names(data[6:8]))
    
    # plot top-right graph
    plot(datetime, Voltage, type = "n")
    lines(datetime, Voltage)
    
    # plot bottom-right graph
    plot(datetime, Global_reactive_power, type = "n")
    lines(datetime, Global_reactive_power)  
    
  })
  
  # close the file device
  dev.off()
}