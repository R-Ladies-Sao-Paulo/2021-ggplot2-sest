########################################################################################
######## Script de apoio para o Minicurso Princípios de Dataviz com R e ggplot2 ########
########                                 R-Ladies                               ########
########          Semana da Estatística (SEst) - UFSCar e USP 2021              ########
########################################################################################



################################################
#####        Bibliotecas utilizadas        #####
################################################
# install.packages('dplyr')
# install.packages('ggplot2')
# install.packages('friends')
library(ggplot2)
library(dplyr)
library(friends)

################################################
##### Conhecendo a base que vamos utilizar #####
################################################

# Carregando os dados 
df_friends_info <- friends::friends_info

#Primeiras 5 linhas do dataframe
head(df_friends_info)

#Amostra de cada coluna e respectivo tipo de dados
str(df_friends_info)

################################################
#####        Gráfico de Histograma         #####
################################################

# Gráfico com distribuição das notas dos episódios no IMDB
df_friends_info %>% 
  ggplot(aes(season)) + 
  geom_histogram(bins=20, fill = "lightblue3") + 
  theme_minimal() +
  labs(x = "Temporada")


## HANDS ON! ##

################################################
#####          Gráfico de Barras           #####
################################################

# Alcance das temporadas
df_friends_info %>% 
  ggplot(aes(x = factor(season),
             y = us_views_millions)) + 
  geom_col() +
  theme_bw() +
  labs(title = "Alcance das temporadas",
       x = "Temporada",
       y = "Total de Visualizações (mi)")

#Quebra o volume de visualizações por nota no IMDB
  
## Cria faixa de nota
df_friends_info <- df_friends_info %>%
  mutate(tipo_nota = ifelse(imdb_rating < 9, "0 a 9", "9 ou mais"))

## Gera gráfico de alcance com a quebra de nota
df_friends_info %>% 
  ggplot(aes(x = factor(season), y = us_views_millions, fill = tipo_nota)) + 
  geom_col() +
  scale_fill_manual(values = c("grey", "darkgreen")) +
  theme_bw() +
  labs(title = "Alcance das temporadas de Friends")

## HANDS ON! ##

################################################
#####         Gráfico de Dispersão         #####
################################################

#Relação entre o número de visualizações e a nota do episódio
  
df_friends_info %>% 
  ggplot(aes(x = imdb_rating,
             y = us_views_millions)) + 
  geom_point() 

# Adiciona linha de regressão para entender a relação
df_friends_info %>% 
  ggplot(aes(x = imdb_rating,  y = us_views_millions)) + 
  geom_point() +
  geom_smooth(method = "lm")  

# Altera a regressão para uma função polinomial de segunda ordem

df_friends_info %>% 
  ggplot(aes(x = imdb_rating, y = us_views_millions)) + 
  geom_point() +
  geom_smooth(formula = y ~ poly(x, 2), method = "lm")

## HANDS ON! ##

# Discrimina cores no gráfico de acordo com uma 3ª variável

df_friends_info %>% 
  ggplot(aes(x = season, y = us_views_millions)) + 
  geom_point(aes(colour = tipo_nota)) +
  geom_smooth(formula = y ~ poly(x, 3), method = "lm",
              colour = "magenta3", size = 1.5)

# Discrimina também as formas dos pontos no gráfico de acordo com uma 3ª variável
df_friends_info %>% 
  ggplot(aes(x = season, y = us_views_millions)) + 
  geom_point(aes(colour = tipo_nota, shape = tipo_nota), size = 2.5) +
  geom_smooth(formula = y ~ poly(x, 3), method = "lm",
              colour = "magenta3", size = 1.5) 

################################################
#####         Gráfico de Box-Plot          #####
################################################

# Box-plot com relação entre visualizações e temporadas:
ggplot(df_friends_info,
       aes(x = factor(season), y = us_views_millions, fill = factor(season))) + 
  geom_boxplot()

## Tabelas auxiliares:

# Agrupa os dados para pegar a média e mediana
df_friends_agrup <- df_friends_info %>% 
  dplyr::group_by(season) %>% 
  dplyr::summarise(media_visu = mean(us_views_millions),
                   mediana_visu = median(us_views_millions))

# Seleciona os 2 episódios mais assistidos 
top_2 <- df_friends_info %>% 
  arrange(desc(us_views_millions)) %>% 
  select(season, title, us_views_millions) %>% 
  distinct() %>%
  head(2)  

# Adiciona ao gráfico uma camada com pontos com a média de visualizações:
gg <- ggplot(df_friends_info, aes(x = factor(season),  y = us_views_millions, 
                                  fill = factor(season))) + 
  geom_boxplot() +
  geom_point(data = df_friends_agrup, aes(x = factor(season), y = media_visu), 
             colour = "yellow", size = 2)
print(gg)

# Adiciona ao gráfico uma camada que exibe a mediana como texto:
gg2 <- gg +
  geom_text(data = df_friends_agrup, 
            aes(x = factor(season), y = mediana_visu, 
                label = format(mediana_visu, digits = 1, nsmall = 1)),
            fontface = "bold", size = 3, vjust = -0.5)
print(gg2)

#Adiciona uma camada que exibe label nos 2 episódios que mais tiveram visualizações
gg3 <- gg2 +
  geom_label(data = top_2, 
             aes(x = factor(season), y = us_views_millions, 
                 label = title),
             fill = "white", size = 2.5)
print(gg3)

## HANDS ON! ##

################################################
#####          Gráfico de Linhas           #####
################################################

df_friends_info %>% 
  ggplot() +
  geom_line(aes(x = air_date, y = us_views_millions, color = factor(season))) +
  theme_dark()
