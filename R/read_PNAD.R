setwd("~/Documents/Mateus/R_related/dissertacao")
source('R/functions.R')

### le arquivos da PNAD
### chama os pacotes necessários

library(bit64)
library(data.table)
library(descr)

## set variaveis
PNAD_DOM <- list()
PNAD_PES <- list()
list_res <- list()
pct_bases <- NULL
anos <- c(2006:2009,2011:2015)
tam <- c(1:9)
#i = 1

## Criando o dicionário a partir das três primeiras colunas da planilha
## loop para abrir todos aqruivos e salvar em uma lista
for (i in tam){
  caminho <- "~/Documents/Mateus/mestrado/Dissertacao/projeto_PNAD/raw_data_bases"
  caminho <- paste(caminho,anos[i], sep = "/")
  setwd(caminho)
 
  dicionario <- paste("dicdom_",anos[i],".csv", sep="")
  dicdom <- read.csv(file = dicionario, header=T)
  dicdom <- dicdom[complete.cases(dicdom),]
  colnames(dicdom) <- c('inicio', 'tamanho', 'variavel')

  dicionario1 <- paste("dicpes_",anos[i],".csv", sep="")
  dicpes <- read.csv(file = dicionario1, header=T)
  dicpes <- dicpes[complete.cases(dicpes),]
  colnames(dicpes) <- c('inicio', 'tamanho', 'variavel')
  
  ## Parâmetro com o final de cada campo
  end_dom = dicdom$inicio + dicdom$tamanho - 1
  end_pes = dicpes$inicio + dicpes$tamanho - 1
  
  ## Converte o microdado para um arquivo csv
  arquivo <- paste("DOM",anos[i],".txt", sep = "")
  arquivo <- paste(caminho,arquivo, sep = "/")
  arquivo1 <- paste("PES",anos[i],".txt", sep = "")
  arquivo1 <- paste(caminho,arquivo1, sep = "/")
  
  fwf2csv(fwffile= arquivo, csvfile='dadosdom.csv', names=dicdom$variavel, begin=dicdom$inicio, end=end_dom)
  fwf2csv(fwffile= arquivo1, csvfile='dadospes.csv', names=dicpes$variavel, begin=dicpes$inicio, end=end_pes)
  
  ## Efetua a leitura do conjunto de dados com o fread do data.table
  PNAD_DOM[i] <- list(fread(input='dadosdom.csv', sep='auto', sep2='auto', integer64='double'))
  PES_temp <- list(fread(input='dadospes.csv', sep='auto', sep2='auto', integer64='double'))
  list_res <- limpa_PNAD_PES(PES_temp)
  PNAD_PES[i] <- list(list_res[[1]])
  pct_bases[i] <- list_res[[2]]
  file.remove(c('dadosdom.csv','dadospes.csv'))

}
pct_bases <- cbind(anos,pct_bases)

### setwd para pasta do projeto
setwd("~/Documents/Mateus/R_related/dissertacao")

V0101 <- c(rep(anos[7], times = nrow(PNAD_PES[[7]])))
PNAD_PES[[7]] <- cbind(V0101 ,PNAD_PES[[7]])

rm(list = c("arquivo", "caminho","dicionario","end_dom","i","dicdom", "end_pes",
            "arquivo1","dicionario1","dicpes","PES_temp","list_res","Vetor_comp"))


