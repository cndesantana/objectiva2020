dat <- readRDS("data/timeline_politicos.rds")
library(tidyverse)
library(lubridate)

dat  %>% 
  mutate(date = round_date(ymd_hms(created_at),"day")) %>% 
  filter(date > ymd("2019-10-01")) %>% 
  group_by(date,screen_name) %>% 
  summarise(total = mean(favorite_count)) %>% 
  ggplot(aes(x = date,y=total,col=screen_name)) + 
  geom_line(stat="identity") + 
  facet_wrap(~screen_name,scales="free_y")

dat <- readRDS("data/mentions_politicos.rds")
dat %>% count(screen_name)

dat %>% group_by(screen_name) %>% summarise(total = sum(retweet_count))
