#Load data from household_power_consumption.txt for 2 days: 2/1/2007 & 2/2/2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "./explore_project1/household_power_consumption.txt"'),
                   header=F, sep=';',na.strings="?",stringsAsFactors=FALSE)
colnames(data) <-names(read.table('./explore_project1/household_power_consumption.txt',
                                  header=TRUE,sep=";",nrows=1))

#Combine date and time fields to form a new field and format as time/date
data$datetime <- paste(data$Date, data$Time,sep = " ")
data$datetime <- strptime(data$datetime, "%d/%m/%Y %T")

#Open *.png output file
outputfile <- "./explore_project1/ExData_Plotting1/Plot2.png"
png(filename = outputfile, width = 480, height = 480)

#plot chart
with(data,plot(datetime,Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",xlab = ""))

#close output file
dev.off()