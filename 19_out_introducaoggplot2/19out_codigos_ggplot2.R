# Bibliotecas

# install.packages('dplyr')
# install.packages('ggplot2')

library(ggplot2)
library(dplyr)



# Leitura da base de dados
airquality <- as_tibble(datasets::airquality)
head(airquality)


# **Base de dados**: airquality.
#**Mapear as variáveis**: Wind (x) e Temp (y).
#**Objeto geométrico**: pontos (`geom_point()`).

ggplot(data = airquality,
       mapping = aes(x = Wind, y = Temp)) +
  geom_point() # Camada 1


# O mapeamento das variáveis também pode ser inserido no objeto geométrico:

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp))


#### Cores e tamanhos dos objetos geométricos
# Caso 1: meramente estéticos
# Dentro do objeto geométrico (`geom_point()`)
# Cor: `geom_point(color = "cor desejada")`
# Tamanho dos pontos `geom_point(size = valor numérico)`

ggplot(data = airquality,
       mapping = aes(x = Wind, y = Temp)) +
  geom_point(color = "blue", size = 4)  # Camada 1


#### Cores e tamanhos dos objetos geométricos
# Caso 2: associados a uma terceira variável: `aes()` (mapeamento das variáveis)
# Dentro do objeto geométrico (`geom_point()`)
# Cor: `geom_point(color = variável)`
# Tamanho dos pontos `geom_point(size = variável)`
# Vou associar a cor à variável **Month** (numérico de 5 a 9)

# cor
ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 2)  # Camada 1

# cor e tamanho
ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, size = factor(Month), color = factor(Month)))  # Camada 1



#### Títulos e subtítulos
# Nova camada: `ggtitle("Titulo", "subtítulo")`.

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, size = factor(Month), color = factor(Month))) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento")  # Camada 2


#### Eixos
# Nova camada: `labs(x = "nome no eixo x", y = "nome no eixo y")`.

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, size = factor(Month), color = factor(Month))) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") # Camada 3


#### Eixos
# Alterar limites das coordenadas: `xlim(c(a,b))` e `ylim(c(a,b))`.

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, size = factor(Month), color = factor(Month))) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  xlim(c(0,30)) + # Camada 4
  ylim(c(50,150)) # Camada 5


#### Legenda
# Nova camana: `guides()`.
# Associar com o tipo de representação: cor

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 3) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  guides(color=guide_legend(title="Mês")) # Camada 3


#### Temas
# Alterar temas dos gráficos: `theme_()`.
# Tema clássico

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 3) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  guides(color=guide_legend(title="Mês")) + # Camada 3
  theme_classic()  # Camada 4

#### Temas | Clássico / Tamanho da fonte

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 3) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  guides(color=guide_legend(title="Mês")) + # Camada 3
  theme_classic(16)  # Camada 4

# Tema escuro

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 3) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  guides(color=guide_legend(title="Mês")) + # Camada 3
  theme_dark(16)  # Camada 4

# Tema mínimo*

ggplot(data = airquality) +
  geom_point(mapping = aes(x = Wind, y = Temp, color = factor(Month)), size = 3) + # Camada 1
  ggtitle("Qualidade do ar", "Temperatura pelo Vento") +  # Camada 2
  labs(x = "Vento (Km/h)", y = "Temperatura (Farenheit)") + # Camada 3
  guides(color=guide_legend(title="Mês")) + # Camada 3
  theme_minimal(16)  # Camada 4
