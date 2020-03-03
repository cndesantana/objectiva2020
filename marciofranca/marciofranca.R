library(tidyverse)
library(lubridate)
library(gtrendsR)


trendsMF <- gtrends("Márcio França", 
                    geo = "BR", 
                    time = "2019-01-01 2020-03-01",
                    category = 396,
                    onlyInterest = FALSE)


setwd("/Users/isiscosta/RScript/marciofranca/")
dat <- readRDS("data/tweets_MF.rds")
dat <- dat %>% mutate(data = round_date(ymd_hms(created_at),"day"))

p1 <- dat %>% 
filter(data >= ymd("2019-01-01")) %>% 
group_by(data) %>% 
summarise(ntweets = n()) %>% 
ggplot(aes(x = data, y = ntweets)) + 
geom_line(col="#E69F00", size=1) + 
labs(title = "Número de tweets por dia", subtitle = "@marciofrancasp", caption ="Núcleo de Inteligência", x = "data", y = "Número de tweets") + 
theme_bw() 

png("figures/tweets_por_dia.png",width=3200,height=1800,res=300)
print(p1)
dev.off()


p2 <- dat %>% 
filter(data >= ymd("2019-01-01")) %>% 
group_by(data) %>% 
summarise(nfavoritos = sum(favorite_count)) %>% 
ggplot(aes(x = data, y = nfavoritos)) + 
geom_line(col="#E69F00", size=1) + 
labs(title = "Número de favoritos", subtitle = "@marciofrancasp", caption ="Núcleo de Inteligência", x = "data", y = "Número de favoritos") + 
theme_bw() 

png("figures/favoritos_por_dia.png",width=3200,height=1800,res=300)
print(p2)
dev.off()

p3 <- dat %>% 
filter(data >= ymd("2019-01-01")) %>% 
group_by(data) %>% 
summarise(nretweets = sum(retweet_count)) %>% 
ggplot(aes(x = data, y = nretweets)) + 
geom_line(col="#E69F00", size=1) + 
labs(title = "Número de retweets", subtitle = "@marciofrancasp", caption ="Núcleo de Inteligência", x = "data", y = "Número de retweets") + 
theme_bw() 

png("figures/retweets_por_dia.png",width=3200,height=1800,res=300)
print(p3)
dev.off()

#########
library(dplyr)
library(tidytext)
library(igraph)
library(ggraph)
library(stringr)


datSP <- readRDS("data/tweets_SP.rds")
datSP <- datSP %>% 
  filter(
    location %in% c("São Paulo, Brasil","São Paulo", "Sao Paulo, Brazil", "Taubaté, São Paulo"
                    )
  )
datSP <- datSP %>% 
  mutate(data = round_date(ymd_hms(created_at),"day"))

## networks
badwords <-  stopwords::stopwords(language = "pt")
badwords <- c(badwords, "https","t.co")
set.seed(2017)
a <- grid::arrow(type = "closed", length = unit(.15, "inches"))
datSP %>% select(text) %>%  
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
  count(bigram, sort = TRUE) %>%
  filter(n > 20) %>%
  graph_from_data_frame()%>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = 0.5), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()
  


