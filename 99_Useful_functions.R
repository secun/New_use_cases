#Check variable in your environment, and creates it if it doesn't exist
ifelse(!exists("variable"),variable <- getvariable(),"")


#Save and read variable in R format
saveRDS(tophothist, file="tophothist.rds")
readRDS(file="tophothist.rds")

#When updating R, check where R Libraries are stored
.libPaths()

#Send interactive message / alert
library(svDialogs) 
dlg_message(c("Hello World! It's ", 
                format(Sys.time(),"%a %b %d %X %Y")
                )
            )

#Pushover Homepage
library("pushoverr")
# Notifications to be sent over Pushover service (license is 4.99€ per year)

