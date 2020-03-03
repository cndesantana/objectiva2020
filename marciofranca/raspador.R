library(rtweet)
library(tidyverse)
library(lubridate)

tweetsHAB <- search_tweets("habitação",n = 1000, lang="pt-br")
tweetsHAB$timeline <- rep("Habitação",nrow(tweetsHAB))

tweetsSP <- search_tweets("São Paulo",n = 1000, lang="pt-br")
tweetsSP$timeline <- rep("São Paulo",nrow(tweetsSP))

tweetsPAU <- search_tweets("paulistano",n = 1000, lang="pt-br")
tweetsPAU$timeline <- rep("paulistano",nrow(tweetsPAU))

tweets <- rbind(tweetsHAB,tweetsSP,tweetsPAU)

saveRDS(file = "data/tweets_SP.rds", tweets) 

