# Introdução ao R
# Aula 03
# Enade 2014
# Script: Neylson Crepalde
##################

### Carrega os pacotes
library(readr)
library(dplyr)
library(ggplot2)
library(descr)

enade <- read_csv2("https://github.com/neylsoncrepalde/introducao_ao_r/blob/master/dados/enade_2014_amostra.csv?raw=true")
dim(enade)
names(enade)

sapply(enade, class)
#########################
# Investigar a nota geral
# nt_ger
summary(enade$nt_ger)
var(enade$nt_ger, na.rm = T)
sd(enade$nt_ger, na.rm = T)

ggplot(enade, aes(x = nt_ger)) +
  geom_histogram()
qqnorm(enade$nt_ger)

############
# tp_sexo
freq(enade$tp_sexo)
freq(enade$qe_i2)

enade = enade %>%
  mutate(sexo = case_when(
    tp_sexo == "M" ~ "M",
    tp_sexo == "F" ~ "F"
  )) %>% 
  mutate(cor = case_when(
    qe_i2 == "a" ~ "Branco",
    qe_i2 == "b" ~ "Negro",
    qe_i2 == "c" ~ "Pardo",
    qe_i2 == "d" ~ "Amarelo",
    qe_i2 == "e" ~ "Indígena"
  ))

freq(enade$sexo)
freq(enade$cor)

#####
### selecionar apenas as colunas
### idade, sexo, cor e notageral
### considerar apenas pessoas de 20 a 45
### tirar media da nota geral para homens
## e mulheres
# e a media da nota geral para cada 
# categoria de cor

# R nativo
selecao = enade[,c("nu_idade",
                   "sexo",
                   "cor",
                   "nt_ger")]
selecao = selecao[selecao$nu_idade >= 20 &
                    selecao$nu_idade <= 45,]
mean(selecao$nt_ger[selecao$sexo == "M"], na.rm = T)
mean(selecao$nt_ger[selecao$sexo == "F"], na.rm = T)

##########################
#
enade %>% select(nu_idade, sexo, cor, nt_ger) %>%
  filter(nu_idade >= 20, nu_idade <= 45) %>% 
  filter(is.na(cor) == F) %>% 
  group_by(cor) %>% 
  summarise(media = mean(nt_ger, na.rm = T))
