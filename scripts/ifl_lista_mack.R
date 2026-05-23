################################################################################
############### IFL - índice de frequência de listas de Mackinnon ##############
################################################################################

# 0. Rodar os pacotes
library(readxl)
library(vegan)
library(ggplot2)
install.packages("here")
library(here)
library(readr)

# 1. Ler dados
ifl <- read_csv2(here("dados", "ifl.csv")) #read_csv2() é para arquivos no padrão brasileiro/europeu (, e ;)
print(ifl, n = Inf)

# 2. Renomear colunas para facilitar (assumindo que são 'Especie' e 'IFL')
colnames(ifl) <- c("Especie", "IFL")

# 3. Ordenar espécies do maior para o menor IFL (opcional, facilita visualização)
ifl <- ifl[order(ifl$IFL, decreasing = TRUE), ]

# 4. Converter 'Especie' em fator para manter a ordem no gráfico
ifl$Especie <- factor(ifl$Especie, levels = ifl$Especie)

# 5. Criar gráfico de barras
ggplot(ifl, aes(x=Especie, y=IFL)) +
  geom_bar(stat="identity", fill="darkgray") +
  labs(x="Espécies", y="IFL",
       title="Índice de frequência de espécies por listas de Mackinnon") +
  theme_minimal(base_size=14) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1))  # gira nomes das espécies
