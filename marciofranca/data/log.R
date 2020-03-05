library(tidyverse)
library(lubridate)
setwd("/Users/isiscosta/RScript/objectiva2020/marciofranca")

#### TIMELINE
dat <- readRDS("data/timeline_politicos.rds")

p1<-dat  %>% 
  mutate(date = round_date(ymd_hms(created_at),"month")) %>% 
  filter(date >= ymd("2019-01-01")) %>% 
  filter(screen_name == "marciofrancasp") %>%
  count(date) %>%  
  ggplot(aes(x = date,y=n)) + 
  geom_bar(stat="identity") +
  labs(title="Número de tweets", 
       subtitle = "@marciofrancasp",
       caption ="Núcleo de Inteligência", 
       x = "Data", 
       y = "Número de tweets") + 
  theme_bw()
png("figures/tweets_per_month.png",width=3200,height=1800,res=300)
print(p1)
dev.off()

p1<-dat %>% 
  mutate(tamanho_do_texto = if_else(display_text_width < 100, 
                                    "0-100",
                                    if_else(display_text_width < 200,
                                            "100-200",
                                            "+200"))) %>%
  mutate(tamanho_do_texto = factor(tamanho_do_texto,levels = c("0-100","100-200","+200")))%>%
  ggplot(aes(x = tamanho_do_texto, y = log(favorite_count))) +
  geom_boxplot() +
  labs(title="Número de favoritos", 
       subtitle = "@marciofrancasp",
       caption ="Núcleo de Inteligência", 
       x = "Tamanho do tweet (caracteres)", 
       y = "Log do Número de favoritos") + 
  theme_bw()
png("figures/tamanho_do_texto_favoritos.png",width=3200,height=1800,res=300)
print(p1)
dev.off()


library(tokenizers)
library(tidytext)
#### Márcio França
datPSB <- readRDS("data/PSB.rds")
dat <- readRDS("data/Márcio França.rds")
dat %>% 
  count(screen_name,text, favorite_count) %>% 
  arrange(favorite_count) %>%
  tail(20) %>%
  View()

dat <- readRDS("data/mentions_politicos.rds")

p1 <- dat %>% mutate(date = round_date(ymd_hms(created_at),"month")) %>% 
  filter(date >= ymd("2020-01-01")) %>% 
  group_by(screen_name) %>%
  summarise(total = sum(favorite_count)) %>%
  arrange(total) %>% 
  ggplot(aes(x = reorder(screen_name,total), y = log(total), fill = screen_name)) +
  geom_bar(stat="identity") +
  geom_text(aes(x = reorder(screen_name,total), y = log(total), label = total),hjust=1.3) +
  coord_flip() +
  labs(title="Número de favoritos", 
       subtitle = "Pré-candidatos",
       caption ="Núcleo de Inteligência", 
       x = "Pré-candidatos", 
       y = "log-Número de favoritos",
       fill = "Pré-candidatos") + 
  theme_bw()
png("figures/favoritos_precandidatos.png",width=3200,height=1800,res=300)
print(p1)
dev.off()

dat %>% filter(screen_name == "GuilhermeBoulos") %>%
  mutate(date = round_date(ymd_hms(created_at),"month")) %>% 
  filter(date >= ymd("2020-01-01")) %>% 
  select(date,status_id,text,screen_name,favorite_count) %>%
  arrange(favorite_count)%>%
  tail(20) %>%
  View()

### Boulos
dat <- readRDS("data/Boulos.rds")
dat %>% arrange(favorite_count) %>%
  select(text,screen_name,favorite_count) %>%
  tail(20) %>%
  View()
