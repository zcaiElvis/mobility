library(tidyverse)
library(dplyr)
library(zoo)

### Read processed file ###
data_loc <- "data/processed/mob_covid.csv"
data <- read.csv(data_loc)
data <- data[2:length(data)]


### Plot ###
data %>%
  mutate(rol_7 = rollmean(case, k=7, fill=NA))%>%
  ggplot(aes(x=as.Date(date), y = rol_7))+
  geom_line()

data %>%
  pivot_longer(cols = -c(date))

data %>%
  pivot_longer(cols = -c(date))%>%
  ggplot(aes(x=as.Date(date), y =value))+
  geom_line()+
  facet_wrap(vars(name), scales="free_y")


fit <- lm(case ~ , data= data)

fit <- lm(data$case[2:nrow(data)] ~ data$case[1:nrow(data)-1] + data$workplaces_percent_change_from_baseline[2:nrow(data)])
