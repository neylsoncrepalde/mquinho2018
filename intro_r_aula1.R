5 + 6  # soma
5 / 2  # divisao
5 * 10 # multiplicacao
5 - 6  # subtracao
5^2    #eleva ao quadrado
5^3    # eleva ao cubo
sqrt(25)  # raiz quadrada
exp(5)    # exponencial
log(148.4132) # log natural
log10(14)     # log base 10
#########################
# Trabalhando com objetos
# outro comentario

x <- 5  # x recebe 5
x       # exibe o x
y <- 7  # y recebe 7
y       # exibe o y

x + y   
x * y

sqrt(x) + exp(y*(4*x))

x = 9
x + y


#####################
# Trabalhar com vetores

a <- c(3,6,1,32)
b <- c(5,12,27,14)

a
b

a + b
a - b
a * b

# Sequências e repetições
10:100

seq(from = 2, to = 20, by = 2)

seq(from = 2, to = 20, by = 5)


rep(1:4, times = 3)
rep(1:4, each = 10)
##################################
## Classes

a
class(a)

vetor <- c(1.4, 5.67, 89.453, 2)
vetor
class(vetor)

inteiros <- c(2L, 4L, 10L)
inteiros
class(inteiros)

#############################
# Character
nome <- "Neylson"
nome
sobrenome <- "Crepalde"
sobrenome
class(nome)

paste(nome, sobrenome, sep = "PÊ")
paste0(nome, sobrenome)
##################################
# Matrizes
A <- matrix(data = 1:16,
            nrow = 4,
            ncol = 4)
A
class(A)
B <- matrix(data = 1:16,
            nrow = 4,
            ncol = 4,
            byrow = TRUE)
B

A + B
A - B

A %*% B
#######################
###



























