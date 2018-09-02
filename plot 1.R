## Assignment 1 

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
df[good,]

df <- with(df, df[(Global_active_power != "?" & Global_reactive_power != "?" & Voltage != "?" & Global_intensity != "?" & Sub_metering_1 != "?" & Sub_metering_2 !=  "?" & Sub_metering_3 != "?" ) , ])

## Plot 

df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_active_power <- df$Global_active_power/500

png(file = "/Users/justinedibarboure/Documents/R/EDA/plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
