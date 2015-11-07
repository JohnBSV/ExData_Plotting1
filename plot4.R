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

# #preserve the existing locale
# #Those lines were used to generate png files.
# #For users inside US should be left commented
#my_locale <- Sys.getlocale("LC_ALL")

# change locale to English
#Sys.setlocale("LC_ALL", "English")

House$Datetime<-paste(House$Date,House$Time)
House$Datetime<-strptime(House$Datetime,
                         format="%d/%m/%Y %T")
png(filename = "plot4.png")

par(mfrow=c(2,2))

#Plot number 1 generation
with(House,plot(Datetime,
                Global_active_power,
                type = "l",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"
                )
     )

#Plot number 2 generation
with(House, plot(Datetime,
                 Voltage,
                 type = "l",
                 xlab="datetime"
                 )
     )

#Plot number 3 generation
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
       bty = "n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)

#Plot number 4 generation
with(House,
     plot(Datetime,
          Global_reactive_power,
          type = "l",
          xlab = "datetime"
          )
     )

dev.off()     

## restore locale
#Sys.setlocale("LC_ALL", my_locale)