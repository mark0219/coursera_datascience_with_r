#################################################
#Exploratory Data Analysis Week 1 Course Project#
#################################################

#Mark Zhang

require(dplyr)

#read data
energyData <- read.table('household_power_consumption.txt', sep = ';', header = T)
#convert into dplyr df
energyData <- tbl_df(energyData)
#convert Date column to date data type
energyData <- mutate(energyData, Date = as.Date(Date, '%d/%m/%Y'))
#subset only 2/1 and 2/2
energyDataSubset <- subset(energyData, Date == '2007-02-01' | Date == '2007-02-02')
#have a quick glance at the data subset
summary(energyDataSubset)
#define a function to convert factor to numeric
columnConversion <- function (column) {
  column <- as.numeric(as.character(column))
}
#convert columns from factor to numeric in bulk
energyDataSubset[, 3:9] <- sapply(energyDataSubset[, 3:9], columnConversion)

#make graph (plot4)
par(mfrow = c(2,2))
#plot1
plot(energyDataSubset$Global_active_power, type = 'l', ylab = 'Global Active Power', xaxt = 'n', xlab = '')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot2
plot(energyDataSubset$Voltage, type = 'l', ylab = 'Voltage', xaxt = 'n', xlab = 'datetime')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot3
plot(energyDataSubset$Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xaxt = 'n', xlab = '')
lines(energyDataSubset$Sub_metering_2, col = 'red')
lines(energyDataSubset$Sub_metering_3, col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), 
       lty = 1, cex = 0.5)
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot4
plot(energyDataSubset$Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xaxt = 'n', xlab = 'datetime')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#export graph to the disk
png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
#plot1
plot(energyDataSubset$Global_active_power, type = 'l', ylab = 'Global Active Power', xaxt = 'n', xlab = '')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot2
plot(energyDataSubset$Voltage, type = 'l', ylab = 'Voltage', xaxt = 'n', xlab = 'datetime')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot3
plot(energyDataSubset$Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xaxt = 'n', xlab = '')
lines(energyDataSubset$Sub_metering_2, col = 'red')
lines(energyDataSubset$Sub_metering_3, col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), 
       lty = 1, cex = 0.9)
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))

#plot4
plot(energyDataSubset$Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xaxt = 'n', xlab = 'datetime')
axis(1, at = c(1, 1441, 2880), labels = c('Thu', 'Fri', 'Sat'))
dev.off()
