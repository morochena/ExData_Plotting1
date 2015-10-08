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

## convert global active power to numeric
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)

## create device
png(file = "plot2.png", width = 480, height = 480)

## create line chart
plot(
  dataset$datetime, dataset$Global_active_power, 
  type="l",
  ylab = "Global Active Power (kilowatts)",
  xlab = "")

## close device
dev.off()