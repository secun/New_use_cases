################Vectors / Observations################
marks <- c(7.5,9,9,6)
marks[1]
typeof(marks)

names <- c("Sahir", "Simon","Nimai", "Madvesh")
typeof(names)

marriages <- c(TRUE, FALSE,TRUE,TRUE)
typeof(marriages)

################Lists / MBA Student ################
name <- "Sahir" 
nationality <- "Egyptian"
age <- 40
married <- TRUE 
gender <- "male"
siblings <- 3
offsprings <- integer(1)
salary <- 62500
mark <- 7.5

#Types of variables
#typeof(), length(), class() and str()
typeof(name)
typeof(married)
typeof(offsprings)
typeof(mark)

################MBA Student Class################
library("readxl")
class_data <- as.data.frame(read_excel("Student_data.xlsx"))
View(class_data)
print(class_data)
class(class_data)

marks <-class_data[,9]
print(marks)
class(marks)
