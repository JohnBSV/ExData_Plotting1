House<-read.table("household_power_consumption.txt",
                  header = T,
                  sep = ";",
                  skip = 66637,
                  nrows = 69517-66638,
                  stringsAsFactors = F,
                  na.strings = "?")

Housecolnames<-read.table("household_power_consumption.txt",
                          header = F,
                          sep = ";",
                          nrows =1)
Housecolnames<-lapply(Housecolnames,as.character)

colnames(House)<-Housecolnames

House$Datetime<-paste(House$Date,House$Time)
House$Datetime<-strptime(House$Datetime,
                         format="%d/%m/%Y %T")

#png(filename = "plot3.png")
with(House,
     plot(Datetime,
          Sub_metering_1,
          col="black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"
          )
)
lines(House$Datetime,
      House$Sub_metering_2,
      type = "l",
      col="red")

lines(House$Datetime,
      House$Sub_metering_3,
      type = "l",
      col="blue")
legend("topright",
       lty = 1,
       col = c("black",
               "red",
               "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
#dev.off()