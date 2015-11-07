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

# my_locale <- Sys.getlocale("LC_ALL")
# 
# # change locale to English
# Sys.setlocale("LC_ALL", "English")

House$Datetime<-paste(House$Date,House$Time)
House$Datetime<-strptime(House$Datetime,
                          format="%d/%m/%Y %T")

png(filename = "plot2.png")
plot(House$Datetime,
     House$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

# ## restore locale
# Sys.setlocale("LC_ALL", my_locale)