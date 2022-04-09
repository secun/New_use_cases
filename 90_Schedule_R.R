#install.packages("later")
library("later")


########## Schedule based upon a LOGIC VARIABLE

loop<- TRUE

myfunc <- function() { 
  print("This is the output of the scheduled later loop") 
  while(loop) { later(myfunc, 10); break;} 
  }
myfunc()

loop<- FALSE

########## Schedule based upon a call to a function to Trigger & Stop
myfunc2 <- function() { cat("this is the output of the scheduled later loop, run at ", 
                            format(Sys.time(),"%a %b %d %X %Y"), "\n") 
                      cancelfunc <<- later(myfunc2, 10) 
                      } 
cancelfunc <- later(myfunc2, 10)

cancelfunc()

##########
loop <- TRUE 

myfunc3 <- function() { print("This is the output of the scheduled later loop") 
  while(loop) { cancelfunc <<- later(myfunc3, 10); break;} 
  }

myfunc3()
loop <- FALSE 
