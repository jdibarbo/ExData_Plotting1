df <- read.delim('/Users/justinedibarboure/Documents/R/EDA/household_power_consumption.txt', header = TRUE, sep=";")

# Subsetting for specific dates
df$Date <-strptime(df$Date,"%d/%m/%Y")
df$Date <- as.Date(df$Date)
df <- with(df, df[(Date == "2007-02-01" | Date == "2007-02-02") , ])

#Creating datetime variable
df$dt <- paste(df$Date, df$Time)
df$dt <-strptime(df$dt,"%Y-%m-%d %H:%M:%S")

library(lubridate)
df$dt <- ymd_hms(df$dt)

# Eliminating null values
good <- complete.cases(df) # para df
df<- df[good,]
df <- with(df,df[(Sub_metering_1 != "?" & Sub_metering_2 !=  "?" & Sub_metering_3 != "?" ), ])

# Data casting

df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_active_power <- df$Global_active_power/500

df$Sub_metering_1 <- as.numeric(df$Sub_metering_1) 
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2) 
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

df$Voltage <- as.numeric(as.character(df$Voltage))

df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Global_reactive_power <- df$Global_reactive_power/500

# Plot 

png(file = "/Users/justinedibarboure/Documents/R/EDA/plot4.png", width = 480, height = 480)
par(mfrow = c(2,2)) # le digo que sea 1 row y dos columnas
with(df, {
  plot(Global_active_power ~ dt , ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
  plot(df$Voltage ~ df$dt, ylab = "Voltage", xlab = "datetime", type = "l")
  plot(df$Sub_metering_1 ~ df$dt, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(df$Sub_metering_2 ~ df$dt, type = "l", col = "red")
  lines(df$Sub_metering_3 ~ df$dt, type = "l", col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), cex = 0.75)
  plot(df$Global_reactive_power ~ df$dt, ylab = "Global_reactive_power", xlab = "datetime", type = "l")
})
dev.off()
