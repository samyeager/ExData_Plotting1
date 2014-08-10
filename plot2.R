## Plots a line graph for date+time v Global Active Power for the
## "household_power_consumption.txt" dataset.

## Assumes "household_power_consumption.txt" is in working directory.

plot2 <- function() {
  
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
  png(file = "plot2.png", height = 504, width = 504, bg = "transparent")
  with(data, { 
    plot(datetime, Global_active_power, 
         type = "n", 
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    lines(datetime, Global_active_power)
  })
  
  #close the file device
  dev.off()
  
}