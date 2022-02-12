
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr") 
install.packages("tidyverse")
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)  
library(tidyverse)
library(ggplot2)


data <-read.csv("athlete_events.csv", header =T)
head(data)
summary(data)
View(data)

clData<- data %>% mutate(Year= as.factor(Year)) %>% filter(!is.na(Medal))
View(clData)
str(clData)

#1 official
USA <- subset(clData, Team == 'United States')

#2 official
by_sport <- USA %>% group_by(Sport) %>% summarise(c = length(Medal)) %>% arrange(desc(c))

#3 official
by_city_year <- USA %>% group_by(City, Year)  %>% summarise(c = length(Medal)) %>% arrange(desc(c))
by_city_year

#4 official
usa_swim <- subset(clData, Sport == "Swimming")
usa_swim
by_year <- usa_swim %>% group_by(Year) %>% count(Medal)  %>% summarise(sum(n))
by_year

ggplot(by_year, aes(x=`sum(n)`, y= Year,group=1 ) )+ geom_line()

#5 have not used tally.. but count works
by_country <- usa_swim %>% group_by(Team) %>% count(Medal, sort = TRUE)
by_country

#5 official 
tally(group_by(usa_swim, Team), sort = TRUE) # this is correct 

#6
top_10_countries <- clData %>% group_by(Team) %>% count(Medal, sort = TRUE) %>% top_n(10)

#6 official 
top_10 <- tally(group_by(usa_swim, Team), sort = TRUE) %>% top_n(10)

#7
chart <- table(top_10$n, top_10$Team)
barplot(chart)

ggplot(data = top_10)+ geom_bar(mapping = aes(x = Team))

#7 official 
top_10 %>% ggplot() +geom_col(mapping = aes(x=Team, y=n))

#8 followed instructions
medal_tally <- tally(group_by(clData,Team, Year, Medal)) %>% summarise(sum(n)) %>% arrange(desc(`sum(n)`))
medal_tally

#9 followed instructions
clData %>% group_by(Team, Medal) %>% summarise(c=length(Medal)) %>% arrange(desc(c))

#10 official
countries <- subset(clData, clData$Team == "United States" | 
                  clData$Team == "France" |clData$Team == "Germany"| clData$Team == "Great Britain")
View(countries)
tally(group_by(countries, Team, Medal)) # keeping this code just in case

c <-countries %>% group_by(Team) %>% count(Medal)
c
c %>% ggplot() +geom_col(mapping = aes(x=Team, y=n))

#11 official
gold <- subset(clData, clData$Medal == "Gold")
View(gold)
tally(group_by(gold, Team), sort = TRUE)      

#12 official
silver <- subset(clData, clData$Medal == "Silver")
View(silver)
tally(group_by(silver, Team), sort = TRUE)      

#13 official
bronze <- subset(clData, clData$Medal == "Bronze")
View(bronze)
tally(group_by(bronze, Team), sort = TRUE)      

#14 official
countries <- subset(clData, clData$Team == "United States" | 
                      clData$Team == "France" |clData$Team == "Germany"| clData$Team == "Great Britain")
View(countries)
total_medals<- countries %>% group_by(Team) %>% count(Medal)  %>% summarise(sum(n))
total_medals

#15 have not used tally but count is crct
countries2 <- subset(clData, clData$Team == "United States" | clData$Team == "China" |
                       clData$Team == "France" |clData$Team == "Germany"| clData$Team == "Russia")
View(countries2)
medals_in_summer <- countries2 %>% filter(grepl('Summer', Games)) %>% group_by(Team) %>% count(Medal)  %>% summarise(sum(n))
medals_in_summer%>% ggplot() +geom_col(mapping = aes(x=Team, y=`sum(n)`))

medals_in_winter <- countries2 %>% filter(grepl('Winter', Games)) %>% group_by(Team) %>% count(Medal)  %>% summarise(sum(n))
medals_in_winter%>% ggplot() +geom_col(mapping = aes(x=Team, y=`sum(n)`))

#16 official
Medals_women_2016<- clData %>%filter(Year == 2016 & Sex == 'F') %>% count(Medal)
Medals_women_2016



     