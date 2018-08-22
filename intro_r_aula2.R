#### Introdução ao R
#### Aula 02
#### Neylson Crepalde
#### Meu nome super bonito
############################

### Instala os pacotes necessários
# haven, readr, dplyr, ggplot2, descr
# install.packages("haven")
# install.packages("readr")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("descr")

### Carrega os pacotes
library(haven)
library(readr)
library(dplyr)
library(ggplot2)
library(descr)

## Ler o banco de dados
pnad <- read_sav("https://github.com/neylsoncrepalde/introducao_ao_r/blob/master/dados/pes_2012.sav?raw=true")
dim(pnad)
names(pnad)
pnad

###############################
# Arrumar o sexo
# Usando tidyverse (dplyr)

pnad <- pnad %>% 
  mutate(sexo = case_when(
    V0302 == 2 ~ "Masculino",
    V0302 == 4 ~ "Feminino"
  ))

names(pnad)

freq(pnad$V0302)
freq(pnad$sexo)

# Usando o R nativo
pnad$sexo2 = pnad$V0302
pnad$sexo2[pnad$V0302 == 2] = "Masculino"
pnad$sexo2[pnad$V0302 == 4] = "Feminino"

freq(pnad$sexo2)

#########
# Arrumar a cor
# Usando o tidyverse
table(pnad$V0404)

pnad <- pnad %>%
  mutate(cor = case_when(
    V0404 == 2 ~ "Branca",
    V0404 == 4 ~ "Preta",
    V0404 == 6 ~ "Amarela",
    V0404 == 8 ~ "Parda",
    V0404 == 0 ~ "Indígena"
  ))

table(pnad$V0404)
table(pnad$cor)
freq(pnad$cor)

########
names(pnad)
str(pnad)

class(pnad$V8005)
summary(pnad$V8005)
weighted.mean(pnad$V8005, pnad$V4729)

# Renda V4720
summary(pnad$V4720)
pnad$V4720[pnad$V4720 >= 999999999999] = NA
summary(pnad$V4720)
pnad$renda = pnad$V4720
names(pnad)

################
# Preparando "anos de escolaridade"
pnad$anosesco = pnad$V4803
pnad$anosesco[pnad$anosesco == 17] = NA
summary(pnad$anosesco)
pnad$anosesco = pnad$anosesco - 1
summary(pnad$anosesco)

################
#
t.test(pnad$anosesco ~ pnad$sexo)
t.test(pnad$renda ~ pnad$sexo)

### Criar a variável
pnad$branco = ifelse(pnad$cor == "Branca", 1, 0)
freq(pnad$branco)
freq(pnad$cor)

t.test(pnad$anosesco ~ pnad$branco)
t.test(pnad$renda ~ pnad$branco)

##########
# Relação entre escolaridade e renda
cor.test(pnad$renda, pnad$anosesco, 
    use = "complete.obs")

##############################
# Analisando a variável anosesco
summary(pnad$anosesco)
mean(pnad$anosesco, na.rm = T)

weighted.mean(pnad$anosesco, pnad$V4729, 
              na.rm = T)

median(pnad$anosesco, na.rm = T)
quantile(pnad$anosesco, na.rm = T)

var(pnad$anosesco, na.rm = T)
sd(pnad$anosesco, na.rm = T)

###########
hist(pnad$anosesco, col = "red",
     main = "Histograma",
     xlab = "Escolaridade")

### Gráfico com ggplot2
# Gramática dos gráficos
#install.packages("ggthemes")
library(ggthemes)

ggplot(pnad, aes(x = anosesco)) +
  geom_histogram(bins = 15) +
  labs(x = "Escolaridade",
       y = "Frequência",
       title = "Histograma") +
  theme_bw(base_size = 12)

### renda
summary(pnad$renda)
weighted.mean(pnad$renda, pnad$V4729,
              na.rm = T)
var(pnad$renda, na.rm = T)
sd(pnad$renda, na.rm = T)

ggplot(pnad, aes(x = renda)) +
  geom_density()

pnad %>% filter(renda < 3000) %>% 
  ggplot(aes(x=cor, y=renda)) +
  geom_boxplot() +
  facet_wrap(~sexo)


##########################
cor(pnad$renda, pnad$anosesco,
    use = "complete.obs")

ggplot(pnad, aes(x = anosesco,
                 y = renda)) +
  geom_point()

###################
#
pnad$renda = pnad$renda + 0.01
reg = lm(log(renda) ~ anosesco,
         data = pnad)
summary(reg)
exp(reg$coefficients[1])

names(pnad)
