# Retrieve data for specified dates only
elec_data <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", skip = 66637, header = FALSE, nrows = 2880, na.strings = "?")
header <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = FALSE)
colnames(elec_data) <- c(header[1,1],header[1,2],header[1,3],header[1,4],header[1,5],header[1,6],header[1,7],header[1,8],header[1,9])

# Converts Date and Time variables to Date and Time classes
elec_data <- transform(elec_data, Date=as.Date(elec_data$Date, "%d/%m/%Y"))
elec_data$Time <- strptime(paste(elec_data$Date, elec_data$Time), "%Y-%m-%d %H:%M:%S")

# Plot the graph in file
png(filename = "./plot3.png", height = 480, width = 480)
with(elec_data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(elec_data, lines(Time, Sub_metering_2, type = "l", col = "red"))
with(elec_data, lines(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()
