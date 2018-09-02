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

# Unit conversion
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_active_power <- df$Global_active_power/500

summary(df)
# Plot 

png(file = "/Users/justinedibarboure/Documents/R/EDA/plot2.png", width = 480, height = 480)
plot(df$Global_active_power ~ df$dt, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()
