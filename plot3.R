## Plots a line graph for date+time v active energy for sub-meter on a single graph
## for the "household_power_consumption.txt" dataset.

## Assumes "household_power_consumption.txt" is in working directory.

plot3 <- function() {
  
  # read and condition the data
  col_classes <- c("character", "character", "double", "double", "double", 
                   "double", "double", "double", "double")
  data <- read.delim("household_power_consumption.txt", sep = ";",
                     na.strings = "?", colClasses = col_classes)
  data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
  datetime <- strptime(paste(data$Date, data$Time, sep = " "),
                       "%d/%m/%Y %H:%M:%S")
  data <- data.frame(datetime, data[, 3:9])
  
  # open the file device and plot
  png(file = "plot3.png", height = 504, width = 504, bg = "transparent")
  with(data, {
    plot(datetime, Sub_metering_1, 
         type = "n", 
         xlab = "",
         ylab = "Energy sub metering")
    lines(datetime, Sub_metering_1, col = "black")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", lwd = 1, 
           col = c("black", "red", "blue"), 
           legend = names(data[6:8]))
  })
  
  # close the file device
  dev.off()
}