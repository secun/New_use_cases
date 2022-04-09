car::recode(99,"lo:59 = 'F'; 59.01:69 = 'D'; 69.01:79 = 'C'; 79.01:89 = 'B'; 89.01:hi = 'A'")


#Function definition
LetterGrade <- function(percentage) { 
  library("car") 
  return(recode(percentage,"lo:59 = 'F'; 59.01:69 = 'D'; 69.01:79 = 'C'; 79.01:89 = 'B'; 89.01:hi = 'A'"))
  
}

LetterGrade (99)



