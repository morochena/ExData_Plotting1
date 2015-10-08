## load dataset and set column names
dataset <- read.csv2(
  "household_power_consumption.txt", 
  skip = 66637, 
  nrows = 2880, 
  header = FALSE,
  colClasses = "character")
colnames(dataset) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

## create a new column with date & time
dates <- dataset$Date
times <- dataset$Time
x <- paste(dates, times)
dataset$datetime <- strptime(x, format = "%d/%m/%Y %H:%M:%S")

## convert sub meters to numeric
dataset$Sub_metering_1 <- as.numeric(dataset$Sub_metering_1)
dataset$Sub_metering_2 <- as.numeric(dataset$Sub_metering_2)
dataset$Sub_metering_3 <- as.numeric(dataset$Sub_metering_3)

## create device
png(file = "plot3.png", width = 480, height = 480)

## create line chart
plot(
  dataset$datetime, dataset$Sub_metering_1, 
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab = "")

## add sub metering 2 line
lines(dataset$datetime, dataset$Sub_metering_2,
      type = "l",
      col = 'Red')

## add sub metering 3 line
lines(dataset$datetime, dataset$Sub_metering_3,
      type = "l",
      col = 'Blue')


## close device
dev.off()