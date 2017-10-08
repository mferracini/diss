#### Join entre as tabelas aux com os nomes das vairaveis e as bases da PNAD

source('R/tabelas.R')
require(data.table)
require(plyr)

indexes <- c("index_COR","index_SEXO","index_UF")
indexes_mod <- c("index_COR","index_SEXO","index_UF","Renda","Ano",'Codigo',"Idade")
tabs <- list(tab_COR,tab_SEXO,tab_UF)


for (j in tam){
  setnames(PNAD_PES[[j]], old = c('V0404','V0302',"UF","V4720","V0101","V0102","V8005"), new = indexes_mod)  
  for (i in 1:length(indexes)){
    PNAD_PES[[j]] <- plyr::join(PNAD_PES[[j]], tabs[[i]], by = indexes[i]) 
  }
  PNAD_PES[[j]] <- PNAD_PES[[j]]  %>% 
    dplyr::select(Ano, Codigo, Cor,Sexo,Estado,Renda,Idade)
}

rm(list = c("indexes","tabs","COR_index","COR_nomes","i","j",
            "SEXO_index","SEXO_nomes","UF_index","UF_nomes",
            "tab_COR","tab_SEXO","tab_UF","V0101"))
