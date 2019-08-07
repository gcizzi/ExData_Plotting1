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

png(filename = "plot2.png", width=480,height=480)
plot(hp$`Date/Time`,hp$Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",xlab = NA)
dev.off()
