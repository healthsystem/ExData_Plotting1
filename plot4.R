#Load data from household_power_consumption.txt for 2 days: 2/1/2007 & 2/2/2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "./explore_project1/household_power_consumption.txt"'),
                   header=F, sep=';',na.strings="?",stringsAsFactors=FALSE)
colnames(data) <-names(read.table('./explore_project1/household_power_consumption.txt',
                                  header=TRUE,sep=";",nrows=1))

#Combine date and time fields to form a new field and format as time/date
data$datetime <- paste(data$Date, data$Time,sep = " ")
data$datetime <- strptime(data$datetime, "%d/%m/%Y %T")

#Open *.png output file
outputfile <- "./explore_project1/ExData_Plotting1/Plot4.png"
png(filename = outputfile, width = 480, height = 480)

#arrange 4 plots in a 2 x 2 matrix on the page
par(mfcol = c(2,2))
with (data, {

#plot charts
plot(datetime,Global_active_power,type = "l",
               ylab = "Global Active Power",xlab = "")

with(data,plot(datetime,Sub_metering_1,type = "l",xlab = "",
               ylab = "Energy sub metering"))
with(data,lines(datetime,Sub_metering_2,type = "l", col = "red"))
with(data,lines(datetime,Sub_metering_3,type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

plot(datetime,Voltage,type = "l",
               ylab = "Voltage",xlab = "datetime")

plot(datetime,Global_reactive_power,type = "l",
     ylab = "Global_reactive_power",xlab = "datetime")

})
#close output file
dev.off()
