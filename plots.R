#In reading the data, I set my working directory into the directory where the raw data is stored.
#And from there, the following code is applied.
householdPC <- file.path("2ndminiproject/specdata2", "household_power_consumption.txt")
householdPCData <- read.table(file = householdPC, header = TRUE, sep = ";", na.strings = "?")

tidyDataHPC <- householdPCData[householdPCData$Date %in% c("1/2/2007", "2/2/2007"),]
setTime <- strptime(paste(tidyDataHPC$Date, tidyDataHPC$Time, sep = ""), "%d/%m/%Y %H:%M:%S")
tidyDataHPC <- cbind(setTime, tidyDataHPC)

#Plot 1
png("2ndminiproject/plot1.png")
hist(tidyDataHPC$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

#Plot 2
png("2ndminiproject/plot2.png")
plot(tidyDataHPC$setTime, tidyDataHPC$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

#Plot 3
png("2ndminiproject/plot3.png")
colLines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_1, type="l", col=colLines[1], xlab="", ylab="Energy Submetering")
lines(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_2, col=colLines[2])
lines(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_3, col=colLines[3])
legend("topright", legend=labels, col=colLines, lty="solid")
dev.off()

#Plot 4
png("2ndminiproject/plot4.png")
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
colLines2 <- c("black","red","blue")
par(mfrow=c(2,2))
plot(tidyDataHPC$setTime, tidyDataHPC$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(tidyDataHPC$setTime, tidyDataHPC$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_2, type="l", col="red")
lines(tidyDataHPC$setTime, tidyDataHPC$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=colLines2)
plot(tidyDataHPC$setTime, tidyDataHPC$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global Reactive Power")
dev.off()