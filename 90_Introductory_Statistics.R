#Based upon the book
# simpleR - Using R for Introductory Statistics (John Verzani) - 2014
require("UsingR")
library(tidyr)
library(dbplyr)
##### 1-Univariate data ############
####   Read & generate data from command line ####
a = scan() #finish with empty line / CR

seq(0, 100, by = 10)
seq(0, 100, length.out = 11)
rep(1:3, times = 4)
paste("X", 1:10, sep = "")

#### Concept of Attributes: names ####
View(precip)
head(precip)
head(names(precip))
head(sort(precip, decreasing = TRUE))

#Creating names components
test_scores <- c(Alice = 87,
                 Bob = 72,
                 Shirley = 99)

#### Indexing data ####
exec.pay [5]
exec.pay [1:5]
exec.pay [-5]

head(precip)
precip[1]
precip["Mobile"]
precip[length(precip)]
precip[c(2, 3)]

#### Factors ####
x <- paste("X", rep(1:3, 4), sep = "")
y <- factor(x)
levels(y) <- c(levels(y), "X4") #add level
y
y[1] <- "X4" #add value

#### Dates #### Handling dates in R
current_time <- now()
class(current_time)
as.numeric(current_time) #seconds since Jan 1, 1970
month(current_time, label = TRUE) #ordered factors


#### Working with logical functions ####
exec.pay
plot(exec.pay)
any(exec.pay > 2000)
all(exec.pay > 50)
which(exec.pay > 500 & exec.pay < 5000)

292 %in% exec.pay
any(exec.pay == 136)

##### Summaries - Numerical data #############
mean(exec.pay)
mean(exec.pay, trim = 0.10)  #trim 10% on both ends / skew
median(exec.pay)
quantile(exec.pay, 0.10)
quantile(exec.pay, 0.50)
quantile(exec.pay, seq(0, 1, by=0.2)) # quintiles

var(exec.pay) #variance
sum( (exec.pay - mean(exec.pay))^2 ) / (length(exec.pay) - 1)  
sd(exec.pay) #standard deviation
scale(exec.pay)[,1] #normalized deviation or z-score> Shifting and scaling
length(exec.pay)

#Example, grading by z-score
grades = c(54, 50, 79, 79, 51, 69, 55, 62, 100, 80)
mean(grades)
scale(grades)[,1]

# The first applies to “bell-shaped” data (normally distributed) which has the
# 68-95-99.7 rules of thumb that approximately 68% of the data will have a zscore
# between 􀀀1 and 1 (no more than 1 standard deviation from the mean),
# 95% will be within 􀀀2 and 2 and 99.7% will be within 􀀀3 to 3


#Visuals
stripchart(exec.pay) #dot.plot
stem(exec.pay) #steam-and-leaf
hist(exec.pay) #histogram
plot( density(exec.pay) ) #densityplot
boxplot(exec.pay, horizontal=TRUE, main="Exec pay") #boxplot: center, spread and shape

########## Summaries - Categorical data ##########
x <- babies$smoke
table(x)
x <- factor(x, labels=c("never", "now", "until current",
                        "once, quit", "unknown"))
table(x)
barplot(table(x), horiz=TRUE, main="Smoking mothers") #Bar chart
dotchart(table(x)) #cleveland dot chart
pie(table(x)) # Pie chart


##### 2-Bivariate data ############
# Data involving 2 variables
##### 2.1-Independent samples ############
#measurement of the speed of light in air made

View(michelson)
speed <- michelson$Speed 
expt <- michelson$Expt

fourth <- speed[expt == 4] 
fifth <- speed[expt == 5]

boxplot(fourth,fifth) #boxplot
qqplot(fourth, fifth) #quantile plot


##### Lists ############
lmichelson <- list(exp4=fourth, exp5=fifth)
#Indexing [ to return a list and [[ to return the component:

lmichelson[1] # list
lmichelson[[2]] #component 2

##### Data frames ############
str(michelson)
boxplot(Speed ~ Expt, data=michelson)
out <- summary(Speed ~ Expt, data=michelson) 
plot(out)

##### 2.2-Dependent samples ############
str(SAT)
summary(SAT)
# We would expect that states that offer higher pay (salary)
# have an increased chance of attracting more effective teachers 
# who would generally have students with higher SAT scores (total).
# (perc) recording the percentage of students who took the SAT.

cov(SAT$salary, SAT$total) #absolute value
cor(SAT$salary, SAT$total) #normalized value
plot( total ~ salary, SAT)
points(total ~ salary, SAT, subset = perc < 10, pch=15) ## square 
points(total ~ salary, SAT, subset = perc > 40, pch=16) ## solid

res=lm(total ~ salary, SAT, subset=perc > 40)
res$coefficients
abline(res)

#Association between two variables... Causation, common response, confounding (pag 113 of book)
predict(res,data.frame(salary=c(40,45))) 
#Explanatory (predictors, independent) and response (dependent,outcome) variable


##### 2.3-Categorical data ############
##### Unsummarized data #####
str(grades) #grades from current & previous class 
head(grades)
table(grades$prev,grades$grade)


#marginal distribution
marginSums(table(grades$prev,grades$grade), margin=1)
marginSums(table(grades$prev,grades$grade), margin=2)
#graphical representation
par(mfrow=c(1,2))
plot( marginSums(table(grades$prev,grades$grade), margin=1) ,  col="red" )
plot( marginSums(table(grades$prev,grades$grade), margin=2) ,  col="green")


#Let's do the condition distribution (if student gets A, then...)
prop.table(table(grades$prev, grades$grade), margin=1) * 100 #proportion of rows
mosaicplot(table(grades$prev,grades$grade)) #graphical representation
# Conclusion - It is apparent that the previous grade has a big influence on the current grade.

# Other way, xtabs maps data frame into a contingency table
xtabs( ~ grade + prev, grades)

#Numerical correlation
aux = xtabs( ~ grade + prev, grades)
cor(as.numeric(aux[1,]), as.numeric(aux[,1]), method="kendall")
summary(aux) #Chisq is observed frequencies minus expected frequencies
##### Summarized data #####

 
##### 2-Multivariate data ############
#Construction

index=seq(1, 10, by = 1)
peso = scan() #finish with empty line / CR

#Construction
df1=data.frame(ID=index, peso=peso)
#Accessing column
df1$peso  
#Accessing element
df1[1,2]
df1[2,1]
df1[10,2]
df1[2,10]

#Modifying elements
df1[10,2] =76
#Modifying name of column
names(df1)[1] = "identificador"
#Adding column
df1 = cbind(df1,"color_pelo" = c("R","M","M","M","M","M","M","M","M","M"))
df1= subset(df1, 
            select=identificador:peso)

df1= subset(df1, 
            select=-identificador)

#Vectorization 
#Visualization [x1 x2 ... xn] -> [f(x1) f(x2) ... f(xn)]
df1$peso*1000 

with(df1, tapply(peso,color_pelo,mean)
     )


##### 3-Multivariate graphics ############
########## Base graphics ##########
#3 variables
with(iris, 
     plot(Sepal.Length, Sepal.Width, 
          pch=as.numeric(Species), cex=1.2))
legend(6.1, 4.4, c("setosa", "versicolor", "virginica"), cex=1.5, pch=1:3)

      
fm <- Sepal.Width ~ Sepal.Length 
plot(fm, iris, pch=as.numeric(Species)) 
out <- mapply(function(i, x) abline(lm(fm, data=x), lty=i), i=1:3, x = split(iris, iris$Species)) 
legend(6.5, 4.4, levels(iris$Species), cex=1.5, lty=1:3)
#Bubble chart      
plot(total ~ salary, data=SAT, cex=sqrt(perc/10), pch=16, # filled circles 
  col=rgb(red=1, green=0, blue=0, alpha=0.250)) # use alpha
           
#Pair chart
species <- iris$Species 
values <- Filter(is.numeric, iris) 
pairs(values, col=species)
      
#Heatmap
x <- sapply(as.data.frame(state.x77), rank) 
rownames(x) <- rownames(state.x77)

heatmap(x, Rowv=NA, Colv=NA, scale="column", # scale columns 
        margins=c(8, 6), # leave room for labels 
        col=rev(gray.colors(50))) # darker -> larger
        
########## lattice graphics ##########
Cars93 = transform(Cars93, price=cut(Price, c(0, 15, 30, 75), labels=c("cheap", "affordable", "expensive"))) 
xyplot(MPG.highway ~ Weight | price, data=Cars93)

str(babies) #description: https://rdrr.io/cran/UsingR/man/babies.html
#Dot chart
dotplot(factor(smoke) ~ wt, data=babies, subset=wt < 999 & ded==3)
#Box plot
bwplot(factor(smoke) ~ wt, data=babies, subset=wt < 999)
#Histogram
histogram(~ wt | factor(smoke), data=babies, subset=wt < 999)


########## ggplot2 graphics ##########
