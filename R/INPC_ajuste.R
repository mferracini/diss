### cria tabela com taxa para reajustar os valores das rendas para R$ de 2015
### e reajusta valores

library(readr)
INPC_ipeadata <- read_csv("~/Documents/Mateus/mestrado/Dissertacao/projeto_PNAD/raw_data_bases/INPC_ipeadata.csv")
INPC_ipeadata <- data.frame(ano = INPC_ipeadata[,1], inpc = (INPC_ipeadata[,2]/100))
INPC_ipeadata <- INPC_ipeadata[c(27:35),]
INPC_ipeadata <- data.frame(INPC_ipeadata, indice_mais =(INPC_ipeadata[,2]+1) )
ajuste <- NULL

for (i in 1:nrow(INPC_ipeadata)){
  ajuste[i] <- prod(INPC_ipeadata[c(i:nrow(INPC_ipeadata)),3])
}
ajuste <- data.frame(ano = INPC_ipeadata[,1], taxa = ajuste)
rm(INPC_ipeadata)

aux_range <- tam[1:8]

for (i in aux_range){
  aux <- PNAD_PES[[i]]
  renda_ajustada <- (aux$Renda)*ajuste[i,2]
  PNAD_PES[[i]] <- cbind(aux,renda_ajustada)
}
aux <- PNAD_PES[[9]]
renda_ajustada <- (aux$Renda)
PNAD_PES[[9]] <- cbind(aux,renda_ajustada)

rm(list = c("i","aux_range","aux","renda_ajustada","indexes_mod","ajuste"))
