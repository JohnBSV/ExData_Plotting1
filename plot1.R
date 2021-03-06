# Data is read to the system
House<-read.table("household_power_consumption.txt",
                  header = T,
                  sep = ";",
                  skip = 66637,
                  nrows = 69517-66638,
                  stringsAsFactors = F,
                  na.strings = "?")

# Col names are reasigned
Housecolnames<-read.table("household_power_consumption.txt",
                          header = F,
                          sep = ";",
                          nrows =1)
Housecolnames<-lapply(Housecolnames,as.character)

colnames(House)<-Housecolnames


# PNG device is initiated and plots created

png(filename = "plot1.png")

hist(House$Global_active_power,
     col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
