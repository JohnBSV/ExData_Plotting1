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

# #preserve the existing locale
# #Those lines were used to generate png files.
# #For users inside US should be left commented
# my_locale <- Sys.getlocale("LC_ALL")
# 
# # change locale to English
# Sys.setlocale("LC_ALL", "English")

# 
# Date and time columns were merged and converted to "date" class

House$Datetime<-paste(House$Date,House$Time)
House$Datetime<-strptime(House$Datetime,
                         format="%d/%m/%Y %T")

# PNG device is initiated and plots created

png(filename = "plot3.png")
with(House,
     plot(Datetime,
          Sub_metering_1,
          col="black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"
          )
)

# Adding extra lines
lines(House$Datetime,
      House$Sub_metering_2,
      type = "l",
      col="red")

lines(House$Datetime,
      House$Sub_metering_3,
      type = "l",
      col="blue")

# Adding legend square
legend("topright",
       lty = 1,
       col = c("black",
               "red",
               "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
dev.off()

## restore locale
#Sys.setlocale("LC_ALL", my_locale)