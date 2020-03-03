library(rtweet)
library(tidyverse)
library(lubridate)

setwd("/Users/isiscosta/RScript/objectiva2020/marciofranca")
terms1 <- c("Prefeitura","Prefeito")
terms2 <- c("PSB","PSDB","PT","PSOL","MDB","PSD","PDT")
terms3 <- "São Paulo"
terms4 <- c("Márcio França","João Dória","Mara Gabrili","Bruno Covas","Marta Suplicy","Datena","Boulos","Jair Bolsonaro")

for(term2 in terms2){
  tweets <- tibble()
  for(term1 in terms1){
    cat(paste(term1,term2),sep="\n")
    tmp_tweets <- search_tweets(paste(term1,term2,terms3),n=1000,retryonratelimit = TRUE)
    tmp_tweets$term1 <- rep(term1,nrow(tmp_tweets))
    tmp_tweets$term2 <- rep(term2,nrow(tmp_tweets))
    tweets <- rbind(tweets,tmp_tweets)
  }
  saveRDS(tweets, file=paste0("data/",paste(term2,sep="_"),".rds"))
}

for(term2 in terms4){
  tweets <- tibble()
  for(term1 in terms1){
    cat(paste(term1,term2),sep="\n")
    tmp_tweets <- search_tweets(paste(term1,term2,terms3),n=1000,retryonratelimit = TRUE)
    tmp_tweets$term1 <- rep(term1,nrow(tmp_tweets))
    tmp_tweets$term2 <- rep(term2,nrow(tmp_tweets))
    tweets <- rbind(tweets,tmp_tweets)
  }
  saveRDS(tweets, file=paste0("data/",paste(term2,sep="_"),".rds"))
}

##### usuarios
usuarios <- c("marciofrancasp","jdoriajr","brunocovas","DatenaOficial","martasuplicy_","GuilhermeBoulos","maragabrilli")
tweets <- tibble()
for(myuser in usuarios){
  cat(paste(myuser),sep="\n")
  tmp_tweets <- get_timeline(user = myuser, n = 300)
  tweets <- rbind(tweets,tmp_tweets)
}
saveRDS(tweets, file=paste0("data/timeline_politicos.rds"))

##### redes
followers <- tibble()
for(myuser in usuarios){
  cat(myuser,sep = "\n")
  tmp_followers <- get_followers(myuser, n=5000,retryonratelimit = TRUE)
  tmp_followers$user <- myuser
  followers <- rbind(followers,tmp_followers)
}
saveRDS(followers, file=paste0("data/followers.rds"))


##### citations
usuarios <- c("@marciofrancasp","@jdoriajr","@brunocovas","@DatenaOficial","@martasuplicy_","@GuilhermeBoulos","@maragabrilli")
tweets <- tibble()
for(myuser in usuarios){
  cat(paste(myuser),sep="\n")
  tmp_tweets <- get_timeline(user = myuser, n = 300)
  tweets <- rbind(tweets,tmp_tweets)
}
saveRDS(tweets, file=paste0("data/mentions_politicos.rds"))
