library("tidyverse")
library("dplyr")


### file locs ###
mob_2020_loc <- "data/2020_CA_Region_Mobility_Report.csv"
mob_2021_loc <- "data/2021_CA_Region_Mobility_Report.csv"
mob_2022_loc <- "data/2022_CA_Region_Mobility_Report.csv"
covid_loc <- "data/new_data.csv"



### Read files ###
mob_2020 <- read.csv(mob_2020_loc, header= TRUE, sep=",")
mob_2021 <- read.csv(mob_2021_loc, header= TRUE, sep=",")
mob_2022 <- read.csv(mob_2022_loc, header= TRUE, sep=",")
covid <- read.csv(covid_loc)
covid_incid <- covid$New_cases[which(covid$Country == 'Canada')]
covid_death <- covid$New_deaths[which(covid$Country == 'Canada')]
covid_date <- covid$Date_reported[which(covid$Country == 'Canada')]
covid <- data.frame(date = covid_date, case = covid_incid, death = covid_death)

mob_2020 <- mob_2020 %>%
  filter(sub_region_1 == "")%>%
  select(9:15)
mob_2021 <-mob_2021 %>%
  filter(sub_region_1 == "")%>%
  select(9:15)
mob_2022 <-mob_2022 %>%
  filter(sub_region_1 == "")%>%
  select(9:15)

mob<- rbind(mob_2020, mob_2021, mob_2022)


### Checking date, need to be replace with a better code, but will do for now ###
mob$date[1]
mob$date[nrow(mob)]

covid$date[1]
covid$date[nrow(covid)]

mob$date[16]
covid$date[59]
covid$date[876]

# Starting 2020-03-01, ending 2022-05-27 #
mob_pro <- mob[16:nrow(mob),]
covid_pro <- covid[59:876,]

pro_all <- mob_pro

pro_all$case <- covid_pro$case
pro_all$death <- covid_pro$death


write.csv(pro_all, "data/processed/mob_covid.csv")

