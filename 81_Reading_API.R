#NasdaQ Data Link
#Access data: https://data.nasdaq.com/
#https://docs.data.nasdaq.com/docs/r-installation
key="TPewcg3VKP_QkPmnBBXV"

install.packages("Quandl")
library(Quandl)

Quandl.api_key(key)


data <- Quandl('FRED/NROUST', type = "xts")