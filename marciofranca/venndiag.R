library(VennDiagram)
library(tidyverse)

setwd("/Users/isiscosta/RScript/objectiva2020/marciofranca")
##### usuarios
usuarios <- c("marciofrancasp","brunocovas","martasuplicy_","GuilhermeBoulos","maragabrilli","jdoriajr","DatenaOficial","LulaOficial")
abbreviatures <- c("MF","BC","MS","GB","MG","JD","Datena","Lula")
followers <- tibble()
##### redes
#for(i in 1:(length(usuarios)-1)){
for(i in 1:1){
   myuser_i <- usuarios[i]
   myabb_i <- abbreviatures[i]
   foll_i <- readRDS(followers, file=paste0("data/followers_",myuser_i,".rds"))
   for(j in (i+1):length(usuarios)){
      myuser_j <- usuarios[j]
      myabb_j <- abbreviatures[j]
      foll_j <- readRDS(followers, file=paste0("data/followers_",myuser_j,".rds"))
      ##plot VennDiagram
   }
}
 
