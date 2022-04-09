########## Importance of random sampling 
######### Exercise 1 - Does honey improve running performance? ######### 
# Does a treatment induce a notable effect? 
# The lowest value, the better
library("dplyr") # for pipe operator
ctrl <- c(23, 33, 40) 
treatment <- c(19, 22, 25, 26) 
the_data <- stack(list(ctrl=ctrl, treatment=treatment)) 
aggregate(data=the_data, values ~ ind,  mean) 

#A less elegant solution for the same problem vs aggregate
the_data %>%
group_by(ind) %>%
mutate(m=mean(values)) %>%
group_by(ind) %>%
summarise(group= ind, mean=m) %>%
  unique()

#A difference of 9 suggest that there was an improvement (a difference of 9 over 23-32)
#The skeptical comes in?
#Maybe the selected cohort put the better performers into the treatment group? 
#Or is it just due to the randomization chosen?

#We could create different groups , in total 35 groups, though we have selected one single combination
cmbs <- combn (7,3)
cmbs 

#For that specific selected combination, we find the difference of 9
ind <- cmbs[,1]
obs <- mean(the_data$value[ind]) - mean(the_data$value[-ind]) #control and treatment as originally designed
obs

#Let's do the calculation for all the 35 possibilities, obtaining the randomization distribution
res <- apply(cmbs, 2, function(ind) { mean(the_data$value[ind]) - mean(the_data$value[-ind]) })
res
plot(res) 

sum(res >= obs) / length(res) 
#In almost 8.57% of the cases the difference is higher than 9. Is it a significance value?

#Take away: Whether this is a true difference or not is ambiguous, 
# but what the above illustrates is a process for investigating 
# differences from random samples.
#Alternative way

#########  Exercise 2 - Does caffeine make you jittery? ######### 
#We recruit 20 classmates to participate and randomly divides them into two cohorts of size 10. 
#WE serve all a large cup of coffee, but one cohort has decaffeinated and one caffeinated.
#The number of finger taps the students made is then secretly counted with the aid of videotape.

caf <- c(245, 246, 246, 248, 248, 248, 250, 250, 250, 252) 
no_caf <- c(242, 242, 242, 244, 244, 245, 246, 247, 248, 248) 
the_data <- stack(list(caffeine=caf, no_caffeine=no_caf))

obs <- mean(caf) - mean(no_caf) 
obs

cmbs <- combn (20,10) 
length(cmbs) #too many combinations

ind <- cmbs[,1]
obs <- mean(the_data$value[ind]) - mean(the_data$value[-ind]) #control and treatment as originally designed
obs

#Let's do the calculation for all the 35 possibilities, obtaining the randomization distribution
res <- apply(cmbs, 2, function(ind) { mean(the_data$value[ind]) - mean(the_data$value[-ind]) })

sum(res >= obs) / length(res) 
#In only 0.2% of the cases the difference is higher than 3.5. Is it a significance value?

#Take aways: This value is very small. In this case, there is not much ambiguity implying that 
#caffeine increases tapping with this group of 20 students.

#We will see the key to this seeming paradox is understanding that differences 
#must be measured on scales suitable for the data.  

########### Importance of volume of data sampled ############
############ How well does a sample statistic (from sample)  estimate an unknown parameter (from population)? ############
# Intuition should tell us that the sample mean is a better estimate for µ than 
# a single value if we have a large sample

library("Hmisc")
library("UsingR")

diabetes <- subset(Medicare, subset= DRG.Definition =="638 - DIABETES W CC") 
gap <- with(diabetes, Average.Covered.Charges-Average.Total.Payments) #Difference between covered charges and total payment
range(gap) #Gap has 128 elements
plot(gap)
xbar <- mean(gap)

res <- replicate(2000, { 
  xstar <- sample(gap, length(gap), replace=TRUE) #Choose elements with replacement (repeat elements)
  mean(xstar) - xbar 
  }) #res will have 2000 elements
plot (res)
#This is the basic bootstrap confidence interval for µ using the quantile function:
xbar + quantile(res, c(0.025, 0.975))


#if certain assumptions on the population that a random sample is drawn from are valid, 
#then a certain precision can be made as to how a sample statistic can be used to 
#estimate or make inferences about a population parameter.

############### Confidence interval for proportion mean (binom dist.) ##############
#A biology student reads that moderate physical activity is defined as an activity that burns 
#about 150 calories of energy per day. She wants to know what percent of her college’s 1, 812 students 
#achieve this level at least 5 times per week. To do so, with the aid of some friends, she finds a random 
#sample of 125 students of which 80 said they engaged in moderate exercise 5 or more
#times per week. What is a 90% confidence level for the proportion of all 1,812 students?
  
x = 80
n =125 # 80 students out of 125 
prop.test(x, n)

binom.test(x, n)$conf.int
confint(binom.test(x, n))

#22695 out of 150000 figure for the year 2021 (15.13%) shows an increase from the year-2020 figure (15%)- Ratio of podemitas in Spain 
#The null hypothesis is that it is the same as the 15.00% amount of 2020; 
#the alternative is that the new figure is greater than the old: 
#H0 : p = 0.1500, HA : p > 0.1500.

prop.test(x=22695, n=150000, p=.1500, alternative="greater")
#Ho cannot be discarded - Test is not significant


############### Confidence interval for the population mean (normal dist.) ##############
#A barista at “t-test espresso” has been trained to set the bean grinder so that a 25-second espresso shot 
#results in 2 ounces of espresso. Knowing that variations are the norm, he pours eight shots and measures the 
#amounts to be 1.95, 1.80, 2.10, 1.82, 1.75, 2.01, 1.83, and 1.90 ounces.
#Find a 90% confidence interval for the mean shot size. Does it include 2.0?
ozs <- c(1.95, 1.80, 2.10, 1.82, 1.75, 2.01, 1.83, 1.90)
qqnorm(ozs)
t.test(ozs, conf.level=0.80)$conf.int

# My Mini is advertised to consume 7.1l. I record my consumption and gets this:
# Shall I file a claim to BMW becuase the comsuption is higher?
mini <- c(7.4, 6.1, 8.7, 6.7, 7.0, 7.5, 7.6, 6.9, 6.0, 6.8)
mean(mini)
t.test(mini, mu = 7.1, alternative="greater")
#Ho (consumption is 7.1) cannot be discarded - Test is not significant

#we have also assumed a model for our data (a normal distribution) and that our data 
#comes from a random sample.


############### One-side confidence interval for the population mean (normal dist.) ##############
#In R the prop.test, binom.test, and t.test functions can return onesided confidence intervals.
#The barista at “t-test espresso” is told that the optimal serving temperature for coffee is 180°F. 
#Five temperatures are taken of the served coffee: 175, 185, 170, 184, and 175 degrees. 
#Find a 90% confidence interval of the form (−∞, b] for the mean temperature.

x <- c(175, 185, 170, 184, 175)
t.test(x,conf.level = 0.90, alt="less")

############### Confidence interval for the variance ##############
#A commuter believes her commuting times are independent and vary according to a normal distribution, 
# with unknown mean and variance. She would like to estimate the variance to get an idea of the spread of times.
#Over 10 commutes she reports a mean commute time of 25 minutes, with a sample variance of 12 minutes. 
#What is a 95% confidence interval for the population variance?
  
s2 <- 12
n <- 10 
alpha <- 1 - 0.95 
lstar = qchisq(alpha/2, df=n - 1) 
rstar = qchisq(1 - alpha/2, df=n - 1) 
(n-1) * s2 * c(1/rstar, 1/lstar) # CI for sigma squared


############### Confidence intervals for differences (porportions) ###############
#In a span of two weeks the same poll is taken. The first time, 1, 000 people are interviewed, and 560 agree;
#the second time, 1, 200 are interviewed, and 570 agree. 
#Find a 95% confidence interval for the difference of proportions.

prop.test(x=c(560,570), n=c(1000,1200), conf.level=0.95)
#Confidence interval misses 0, so We conclude that there appears to be a real difference in the population parameters.


############### Confidence intervals for differences (independent means) ###############
#A weight-loss drug is tested against a placebo to see whether the drug is effective. 
#The amount of weight loss for each group is given by the following data
#Find a 90% confidence interval for the difference in mean weight loss.
x <- c(0, 0, 0, 2, 4, 5, 13, 14, 14, 14, 15, 17, 17) 
y <- c(0, 6, 7, 8, 11, 13, 16, 16, 16, 17, 18) 
boxplot(list(placebo=x, notplacebo=y), col="gray") # compare spreads

t.test(x,y, var.equal=TRUE) #Assuming equal variances
t.test(x,y, var.equal=FALSE) #Assuming NOT equal variances

#The difference of 0 is still in the confidence interval, even though the sample means differ quite a bit
#at first glance (8.846 versus 11.636).

############### Confidence intervals for differences (dependent means) ###############
#Two cocktails have been given to same customers.
#Results are shown below.
#Find an 80% confidence interval for the difference of means.

x<-c(3.1,3.3,1.7,1.2,0.7,2.3,2.9)
y<- c(1.8, 2.3, 2.2, 3.5, 1.7, 1.6, 1.4)
boxplot(list(cocktailA=x, cocktailB=y), col="gray") # compare spreads

t.test(x-y, conf.level=0.9, var.equal=FALSE)

#The 90% confidence interval does include 0, indicating a certain confidence 
#in the two population means do not differ.


 