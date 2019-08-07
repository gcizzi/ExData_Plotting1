setwd("~/RStudio/Coursera/Exploratory Data Analysis")

library(dplyr)
library(tidyr)

housepower <- read.table("household_power_consumption.txt", header=T , sep=";",
                         stringsAsFactors = FALSE, na.strings = "?",
                         colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
twodays <- grep("^[1,2]/2/2007",housepower$Date)
housepower <- housepower[twodays,]
dt <- paste(housepower$Date,housepower$Time)
dt <- strptime(dt, format = "%d/%m/%Y %H:%M:%S",tz="America/Los_Angeles")
hp <- cbind(dt,housepower[3:9])
names(hp)[1] <- "Date/Time"

png(filename = "plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(hp$`Date/Time`,hp$Global_active_power, type = "l",
     ylab = "Global Active Power",xlab = NA)
plot(hp$`Date/Time`,hp$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")
plot(hp$`Date/Time`,hp$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = NA)
lines(hp$`Date/Time`,hp$Sub_metering_2, type = "l", col="red")
lines(hp$`Date/Time`,hp$Sub_metering_3, type = "l", col="blue")
legend("topright",legend = colnames(hp)[6:8], lty = "solid",
       bty = "n", col=c("black","red","blue"), cex=0.9)
plot(hp$`Date/Time`,hp$Global_reactive_power, type = "l",
     ylab = colnames(hp)[3], xlab="datetime")
dev.off()
