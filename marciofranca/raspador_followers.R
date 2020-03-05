library(rtweet)
library(tidyverse)
library(lubridate)

setwd("/Users/isiscosta/RScript/objectiva2020/marciofranca")
##### usuarios
usuarios <- c("marciofrancasp","brunocovas","martasuplicy_","GuilhermeBoulos","maragabrilli","jdoriajr","DatenaOficial","LulaOficial")
##### redes
for(myuser in usuarios){
  cat(myuser,sep = "\n")
  followers <- get_followers(myuser, n=150000,retryonratelimit = TRUE)
  followers$user <- myuser
  saveRDS(followers, file=paste0("data/followers_",myuser,".rds"))
}

