# R-script to create plot3

# go to working directory
wd <- "C:\\Users\\Coen\\Documents\\Coursera\\Exploratory Data Analysis\\week 1\\ExData_Plotting1\\"
setwd(wd)

# read the data from the file
filename <- "exdata-data-household_power_consumption//household_power_consumption.txt"
data <- read.csv(file=filename, sep = ";")

# set data to numerics
for ( i in c(3:9) ) { data[,i] <- as.numeric(data[,i]) }

# add a date time variable
data$dt  <- strptime(paste(data[,1],data[,2]),"%d/%m/%Y %H:%M:%S")

# set a Date variable
data[,1] <- as.Date(  data[,1], "%d/%m/%Y")

# Subset from 2007-02-01 to 2007-02-02
startdate   <- as.Date("2007-02-01")
enddate    <- as.Date("2007-02-02")
cond     <- data$Date >= startdate & data$Date <= enddate
data_sub <- data[cond,]


# plot and save the data
## Create a png device
png('plot4.png', 480, 480)

#Create place for 4 graphs
par( mfcol=c(2,2) );

#Topleft
plot(data_sub$dt, data_sub$Global_active_power/1000, type='l', 
     xlab="", ylab= "Global Active Power (kilowats)")

#Bottomleft
plot(x=data_sub$dt,y=data_sub$Sub_metering_1,
     type="n", ylab="Energy sub metering", xlab="")

points(x=data_sub$dt, y=data_sub$Sub_metering_1,
       type="l", col="black")
points(x=data_sub$dt, y=data_sub$Sub_metering_2,
       type="l", col="red")
points(x=data_sub$dt, y=data_sub$Sub_metering_3,
       type="l", col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1, 1, 1), col=c("Black","Red","Blue"))


#Topright
plot(data_sub$dt, data_sub$Voltage/3, type='l', 
     xlab="datetime", ylab= "Voltage")

#Bottomright
plot(data_sub$dt, data_sub$Global_reactive_power/400, type='l', 
     xlab="datetime",ylab="Global_reactive_power")


dev.off()


