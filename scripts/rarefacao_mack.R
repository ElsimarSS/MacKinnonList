################################################################################
############ Curva de rarefação para avaliar as listas de MacKinnon ############
################################################################################

# 0. Rodar os pacotes
library(readxl)
library(vegan)
library(ggplot2)
install.packages("here")
library(here)
library(readr)

# 1. Ler dados
mack <- read_csv(here("dados", "lista_aves_mack.csv"))
print(mack, n = Inf)

# 2. Extrair nomes de espécies
especies <- mack[[1]]

# 3. Substituir NAs por 0 e transformar em matriz presença/ausência
matriz <- mack[,-1]
matriz[is.na(matriz)] <- 0
matriz <- as.matrix(matriz)
mode(matriz) <- "numeric"
rownames(matriz) <- especies

# 4. Curva de acumulação por rarefação (com permutações aleatórias)
spec_accum <- specaccum(t(matriz), method="random", permutations=1000)

# 5. Converter resultado em dataframe para usar no ggplot
df_raref <- data.frame(
  Amostras = spec_accum$sites,
  Riqueza_media = spec_accum$richness,
  Desvio = spec_accum$sd
)

# 6. Plotar curva de rarefação com intervalo de confiança
ggplot(df_raref, aes(x=Amostras, y=Riqueza_media)) +
  geom_line(color="darkgray", size=1.2) +
  geom_ribbon(aes(ymin=Riqueza_media-Desvio, ymax=Riqueza_media+Desvio), 
              fill="lightgray", alpha=0.4) +
  labs(x="Número de listas de Mackinnon",
       y="Riqueza de espécies",
       title="Curva de rarefação - Listas de Mackinnon") +
  theme_minimal(base_size=14)
