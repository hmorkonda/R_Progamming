# The pipe operator %>%
# %>% is used to update a value by first piping it into one or more expressions, and then assigning the result.It allows us to pass the result of one function/argument to the other one in sequence.It's available in the magrittr, tidyverse, dplyr and other packages. 

install.packages("magrittr")
library(magrittr)
library(dplyr)

#-------------------------------------
##Example: 

#take the mtcars dataframe, THEN
#Group its entries by number of cylinders, THEN 
#Compute the mean miles-per-gallon of each group
result <- mtcars %>% 
  group_by(cyl) %>% 
  summarise(meanMPG = mean(mpg))
#You can understand the %>% as "then"
# display result
result

#Example 2
# pipe syntax
3.1415926 %>% round(3)

# alternative:
round(3.1415926, 3)

#--------------------------------------
#Let's use the iris dataset and view the first 6 rows using head()
head(iris)
#alternative
iris %>% head()

##select() function

#select columns-Species and Petal.Width
iris %>% select(Species, Petal.Width)

#assign the result to a variable x
x <-iris %>% select(Species, Petal.Width)

x %>% head()

#drop a column
y <- iris %>% select(-Species)
y %>% head()

# we can chain the arguments together

iris %>% select(-Species) %>% head()

#select a few columns using ":"

iris %>% select(Sepal.Length:Petal.Length) %>% head()


##select_if() in the dplyr package, 
#let's select all columns with numeric values 
iris %>% select_if(is.numeric) %>% head()


#select based on column name-use the start_with() function 
iris %>% select(starts_with("S")) %>% head()

iris %>% select(ends_with("h")) %>% head()

iris %>% select(contains("Width")) %>% head()

iris %>% select(contains("Length")) %>% head()

##dplyr for Data Manipulation

#-------------------------filter()---------------------------------------
#The filter() function is used to subset a data frame, retaining all rows that satisfy your conditions. To be retained, the row must produce a value of TRUE for all conditions. 
#Note that when a condition evaluates to NA the row will be dropped, unlike base subsetting with [.


#There are many functions and operators that are useful when constructing the expressions used to filter the data:
#== equal to , > greater than, >= greater than or equal to 

#& and, | or , ! not

#is.na() returns value if NA


#Let's load tidyverse and dplyr packages
install.packages("tidyverse")
library(tidyverse)
library(dplyr)

#We are going to use the dataset msleep

m <- msleep
view(m)
m %>% glimpse()


#find rows with bodywt>5
m %>% filter(bodywt>=5)%>% glimpse()
m %>% filter(bodywt>=5)%>% head()

#find conservation type "en" (endangered)
m %>% filter(conservation=="en")%>% glimpse()

#Filter on basis of more conditions, and filter out the values in common 

#and 
#filter animals with bodywt>5 and endangered
m %>% filter(conservation=="en", bodywt>=5)%>% glimpse()

#or 
#filter animals with bodywt>5 or endangered
m %>% filter(conservation=="en"| bodywt>=5)%>% glimpse()

#!
#filter rows without meeting a condition-find not endangered animals.
m %>% filter(conservation!="en") %>% glimpse()

#compare columns using >, <, >=, <= 
#find animals whose sleep_total > awake
m %>% filter(sleep_total>awake) %>% glimpse()

##Select desired rows and columns-use both select() and filter(), and chain pipe operator
m %>% select (contains("vore"))%>% filter(vore=="omni")%>% glimpse()

#question: try this code and find out why it doesn't work
m %>% select(contains("sleep")) %>% filter(order=="Carnivora") %>% glimpse()


###--------------------------------------part2---------------------------
library(dplyr)
m<-msleep

#--------------------------------mutate()----------------------------------
#mutate() adds new variables and preserves existing ones;
#create a new column/variable sleeping= sleep_total+sleep_rem+sleep_cycle
m %>% mutate(sleeping=sleep_total+sleep_rem+sleep_cycle)%>% glimpse()

#number + NA =NA Let's remove the NAs using the filter(is.na())
m %>% mutate(sleeping=sleep_total+sleep_rem+sleep_cycle)%>% filter(!is.na(sleep_rem))

m %>% mutate(sleeping=sleep_total+sleep_rem+sleep_cycle)%>% filter(!is.na(sleep_rem)) %>% filter(!is.na(sleep_cycle)) %>% glimpse()

ms <- m %>% mutate(sleeping=sleep_total+sleep_rem+sleep_cycle)%>% filter(!is.na(sleep_rem)) %>% filter(!is.na(sleep_cycle)) %>% glimpse()

view(ms)

#---------------------------transmute()------------------------------
##create a new variable and remove the old one using transmute()
m %>% transmute(sleeping=sleep_total+sleep_rem+sleep_cycle)%>% glimpse()

#---------------------------group_by() & summarise()-----------------------
##Group data by category 
##summarise() reduces multiple values down to a single summary.

#n() to summarize the number of variables under each category 
m%>% group_by(conservation)%>% summarise(n())
m%>% group_by(order)%>% summarise(n())
m%>% group_by(vore)%>% summarise(n())

#lc least concern
#vu vulnerable 

#summarize by the mean of awake time 
m%>% group_by(conservation)%>%summarise(mean(awake))

#add more categories 
m%>% group_by(conservation, vore)%>%summarise(mean(awake)) 






