# Dplyr for Data Manipulating
# Tidyr for Data Cleaning
# Pipe Operator    %>% 

# Dplyr 
install.packages('dplyr')
# We will be using the NYC 2013 flights data during this examples, first install the package
install.packages('nycflights13')

library(dplyr)
# You will see: **The following objects are masked from â€˜package:statsâ€?: filter, lag **
# This is becasue dplyr will have it's own filter() function and lag() function which is different from the usual filter function that come with the Base R package.
library(nycflights13)
head(flights)
summary(flights)


# filter() function in dplyr allows us to select a subset of rows in a dataframe.
# it allows us to filter by conditions
filter(flights,month == 10, day == 4, carrier =='AA')
head(filter(flights, month == 10, day == 4, carrier == 'AA'))
# instead of using the dplyr, we can use the [ ] notation, it is long and messy :(
head(flights[flights$month == 10 & flights$day == 4 & flights$carrier == 'AA' , ]) # here I have to keep calling the dataframe name, and use the logical operators with '&' and combine them.

# slice() in dplyr
# slice() function  allows us to select rows by the position
slice(flights, 1:15) # selecting first 15 rows

# arrange() in dplyr
# arrange() function works similar to filter() function except that instead of filtering or selcting rows, it reorder the rows
arrange(flights,year,month,day, arr_time)
head(arrange(flights,year,month,day,arr_time))
# if I want to use the descending time instead of accending time, 
head(arrange(flights,year,month,day, desc(arr_time)))

# select() in dplyr
select(flights,carrier)
head(select(flights,carrier))
# We can add aditional columns easily 
head(select(flights, carrier, arr_time))
head(select(flights, carrier, arr_time, day))
head(rename(flights, airline.carrier = carrier))

# distinct() in dplyr
# distinct() function in dplyr helps us to select the distinct or unique values in a column.
distinct(select(flights, carrier))

# mutate() in dplyr
# in additing to selecting sets of existing columns in the dataframe, sometimes 
# we need to add new columns that are functions of existing columns in the dataframe.
# we can use the mutate() function to do that.
head(mutate(flights, MyNewColumn = arr_delay - dep_delay))
# If you only want to see the new column instead of calling the mutate, you can 
# use the transmute() fuction.
# The difference between the mutate() and transmute() is that mutate() function returns
# the entire dataframe along with the new column and the transmute() shows only the new column.
head(transmute(flights, MyNewColumn = arr_delay - dep_delay))

# summarise() in dplyr
# The summarize() allows us to summarize the data frame into a single row using another aggrigate function
summarise(flights, avg_air_time = mean(air_time, na.rm = TRUE)) # average airtime
summarise(flights, TotalFlightTime = sum(air_time, na.rm = TRUE)) # Total Flight Time

# sample_n() in dplyr
# sample_n() function allows us to pick random number of rows that we wish to choose:
sample_n(flights, 15) # random 15 rows. 
sample_n(flights, 71) # random 71 rows. 

# sample_frac() in dplyr
# if you wan to pick a percentage of rows, sample_frac() function allow us to do that,
# you need to assign the fraction, example: 30% = 0.3, similaly 10% = 0.1
sample_frac(flights,0.1) # sample with a 10% of rows from the total number of rows 
sample_frac(flights, 0.3) # sample with a 30% of rows from the total number of rows 
sample_n(flights, 30)
sample_frac(flights, 0.5)
# dbl stands for doubles, or real numbers.
# dttm stands for date-times (a date + a time).

# Pipe operator:  %>%
library(dplyr)
df_mtcars <- mtcars
head(df_mtcars)

# nesting 
filter(df_mtcars, mpg > 20) # filter mpg > 20
# we want to get 10 samples of that
sample_n(filter(df_mtcars, mpg > 20), 10)
# now we want to arrange them in the descending order based on the mpg
arrange( sample_n(filter(df_mtcars, mpg >20), 10) ,desc(mpg))
# we can assign this result to a variable called results_mpg
results_mpg <- arrange( sample_n(filter(df_mtcars, mpg >20), 10) ,desc(mpg))
results_mpg

# You can do the above using the Pipe Operator %>%
# dataFrame %>% op1 %>% op2 <$op3
multivariate<- read.csv("C:/Users/Suyu Tao/Desktop/multivariate.csv")
head(multivariate)
attach(multivariate)
help(lm)
mm<-lm(Homeowners~Immigrant)
mm
summary(mm)$coef
plot(Homeowners~Immigrant)
help(abline)
abline(mm)
abline(mm,col=2,lwd=3)

abline(mm)
abline(mm,col=3,lwd=3)
attributes(mm)
mm$coefficients
plot(mtcars$wt,mtcars$mpg)
library(ggplot2)
qplot(mtcars$wt,mtcars$mpg)
qplot(wt,mpg,data=mtcars)
ggplot(mtcars,aes(x=wt,y=mpg))+geom_point()
plot(pressure$temperature,pressure$pressure,type="l")
points(pressure$temperature,pressure$pressure)

lines(pressure$temperature,pressure$pressure/2,col="red")
points(pressure$temperature,pressure$pressure/2,col="blue")
library(ggplot2)
qplot(pressure$temperature,pressure$pressure,geom="line")
qplot(temperature,pressure,data=pressure,geom="line")
ggplot(pressure,aes(x=temperature,y=pressure))+geom_line()+geom_point()

barplot(BOD$demand,names.arg=BOD$Time)
table(mtcars$cyl)
barplot(table(mtcars$cyl))
qplot(mtcars$cyl)
qplot(factor(mtcars$cyl))
qplot(factor(cyl),data=mtcars)
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar()

hist(mtcars$mpg)
hist(mtcars$mpg,breaks=10)
hist(mtcars$mpg,breaks=5)
hist(mtcars$mpg,breaks=12)
qplot(mpg,data=mtcars,binwidth=4)
ggplot(mtcars,aes(x=mpg))+geom_histogram(binwidth=4)
ggplot(mtcars,aes(x=mpg))+geom_histogram(binwidth=5)

plot(ToothGrowth$supp,ToothGrowth$len)
boxplot(len~supp,data=ToothGrowth)
boxplot(len~supp+dose,data=ToothGrowth)
library(ggplot2)
qplot(ToothGrowth$supp,ToothGrowth$len,geom="boxplot")
ggplot(ToothGrowth,aes(x=supp,y=len))+geom_boxplot()
qplot(interaction(ToothGrowth$supp,ToothGrowth$dose),ToothGrowth$len,geom="boxplot")
qplot(interaction(supp,dose),len,data=ToothGrowth,geom="boxplot")
ggplot(ToothGrowth,aes(x=interaction(supp,dose),y=len))+geom_boxplot()
       





