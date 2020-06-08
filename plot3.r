
d <- read.table( "household_power_consumption.txt", sep=";", 
                 header=TRUE, na.strings = c(NA, "?"))
dim(d)
# 2075259       9

names(d) <- tolower(names(d))

head(d)
#         date     time global_active_power global_reactive_power voltage
# 1 16/12/2006 17:24:00               4.216                 0.418  234.84
# 2 16/12/2006 17:25:00               5.360                 0.436  233.63
# 3 16/12/2006 17:26:00               5.374                 0.498  233.29
# 4 16/12/2006 17:27:00               5.388                 0.502  233.74
# 5 16/12/2006 17:28:00               3.666                 0.528  235.68
# 6 16/12/2006 17:29:00               3.520                 0.522  235.02
#   global_intensity sub_metering_1 sub_metering_2 sub_metering_3
# 1             18.4              0              1             17
# 2             23.0              0              1             16
# 3             23.0              0              2             17
# 4             23.0              0              1             17
# 5             15.8              0              1             17
# 6             15.0              0              2             17

# We will only be using data from the dates 2007-02-01 and 2007-02-02.

d$date <- as.Date( d$date, "%d/%m/%Y")
head(d$date)

i <- d$date == "2007-02-01" | d$date == "2007-02-02"
sum(i)
# 2880

d <- d[ i, ]
nrow(d)
# 2880

# time in format hh:mm:ss
head(d$time)
# 00:00:00 00:01:00 00:02:00 00:03:00 00:04:00 00:05:00

d$time <- as.character(d$time)

# d$time <- strptime(d$time, "%H:%M:%S")
# head(d$time)
# # "00:00:00" "00:01:00" "00:02:00" "00:03:00" "00:04:00" "00:05:00"
# 
# tail(d$time)
# # "23:54:00" "23:55:00" "23:56:00" "23:57:00" "23:58:00" "23:59:00"

head( paste( d$date, d$time))
# [1] "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00"
# [4] "2007-02-01 00:03:00" "2007-02-01 00:04:00" "2007-02-01 00:05:00"

d$date.time <- strptime( paste(d$date, d$time), "%Y-%m-%d %H:%M:%S")
head(d$date.time)
# [1] "2007-02-01 00:00:00 MST" "2007-02-01 00:01:00 MST" "2007-02-01 00:02:00 MST"
# [4] "2007-02-01 00:03:00 MST" "2007-02-01 00:04:00 MST" "2007-02-01 00:05:00 MST"


#--------------- Plot 3 -------------------------------------------------------

png( "plot3.png", width = 480, height = 480, units = "px")

par(mfrow = c( 1, 1))

plot( d$date.time, d$sub_metering_1, type="n",
      xlab = "",
      ylab = "Energy sub metering")
lines( d$date.time, d$sub_metering_1)
lines( d$date.time, d$sub_metering_2, col="red")
lines( d$date.time, d$sub_metering_3, col="blue")
legend( "topright", 
        legend = c( "Sub_metering_1", 
                    "Sub_metering_2", 
                    "Sub_metering_3"),
        lty = 1,
        col = c( "black", "red", "blue"))

dev.off()

