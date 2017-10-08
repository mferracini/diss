### cria as tabelas de resultados formatadas pro latex
require(stargazer)
require(xtable)
library(formattable)
require(dplyr)
require(tibble)
### tabela mostrando quantos dados foram excluidos

num_dados <- dados_num
rownames(num_dados) <- num_dados$anos
num_dados <- num_dados[,-1]
num_dados <- num_dados %>% 
  select(n_base_raw,
         pct_bases,
         n_base)
num_dados[,2] <- num_dados[,2]*100
colnames(num_dados) <- c("Número inicial de observações", "excluídos (%)","Número final de observações")
  xtable(num_dados,
         caption = "Observações referentes a cada ano após tratamento dos dados",
         label = "tab: summary_dados_tratados",
         align = "cccc")

rm(num_dados)

## tabelas descritivas de renda
  ## tabela raça/cor
descr_cor <- tab_descritiva[1:6,]
descr_cor <- descr_cor*100 
rownames(descr_cor) <- rownames(tab_descritiva)[1:6]

xtable(descr_cor,
       caption = "Dados descritivos - Raça/Cor (%)",
       label = "tab: descritiva_raca",
       align = "cccccccccc")

rm(descr_cor)

  ## tabela raça/cor
descr_sexo <- tab_descritiva[7:8,]
descr_sexo <- descr_sexo*100 
rownames(descr_sexo) <- rownames(tab_descritiva)[7:8]

xtable(descr_sexo,
       caption = "Dados descritivos - Sexo (%)",
       label = "tab: descritiva_sexo",
       align = "cccccccccc")

rm(descr_sexo)

  ## tabela estados
descr_estado <- tab_descritiva[9:35,]
descr_estado <- descr_estado*100 
rownames(descr_estado) <- rownames(tab_descritiva)[9:35]

xtable(descr_estado,
       caption = "Dados descritivos - Estados (%)",
       label = "tab: descritiva_estado",
       align = "cccccccccc")

rm(descr_estado)


## tabelaa descritiva da renda

xtable(round(tab_descritiva_renda,0),
       caption = "Renda ajusta",
       label = "tab: descritiva_RendaAjustada",
       align = "cccccccccc")


## tabelas com as estatisticas J e THEIL calculadas com erro de medida e sem erro

  ## sem erro de medida
  indices_SemErro <- as.data.frame(t(cbind(vetor_Jdiv,vetor_TL,vetor_TT)))
  colnames(indices_SemErro) <- anos
  rownames(indices_SemErro) <- c("Indíce J", "Theil L", "Theil T")
  xtable(indices_SemErro,
         caption = "Evolução dos índices de desigualdade de renda",
         label = "tab: indices_RendaAjustada",
         align = "cccccccccc")
  rm(indices_SemErro)  
  
  ## com erro de medida 1
  indices_ComErro <- as.data.frame(t(cbind(vetor_JdivErro,vetor_TLErro,vetor_TTErro)))
  colnames(indices_ComErro) <- anos
  rownames(indices_ComErro) <- c("Indíce J", "Theil L", "Theil T")
  xtable(indices_ComErro,
         caption = "Evolução dos índices de desigualdade de renda - Com erro de medida (a = x, b = y)",
         label = "tab: indices_RendaAjustadaErro1",
         align = "cccccccccc")
  rm(indices_ComErro) 
  
  ## com erro de medida 2
  indices_ComErro <- as.data.frame(t(cbind(vetor_JdivErro1,vetor_TLErro1,vetor_TTErro1)))
  colnames(indices_ComErro) <- anos
  rownames(indices_ComErro) <- c("Indíce J", "Theil L", "Theil T")
  xtable(indices_ComErro,
         caption = "Evolução dos índices de desigualdade de renda - Com erro de medida (a = x1, b = y1)",
         label = "tab: indices_RendaAjustadaErro2",
         align = "cccccccccc")
  rm(indices_ComErro) 
  
## tabelas com os resultados das decomposições
## cria CSV/xls com os data frames
## codigo em latex gerado por uma planilha auxiliar fora do R
require(WriteXLS)

  setwd("~/Documents/Mateus/R_related/dissertacao/planilhas_aux")  

for (i in tam){
  for (j in 1:3){
    nome_arquivo <- paste("decomp",anos[i],j, sep="_")
    nome_arquivo <- paste(nome_arquivo,"xls",sep=".")
    dados_temp <-  as.data.frame(lista_decomp[[i]] [j])
    #write.table(dados_temp, file = nome_arquivo,row.names=FALSE, na="",col.names=TRUE, sep=",")
    WriteXLS(dados_temp,ExcelFileName =nome_arquivo,col.names = TRUE )
  }
}      
rm(nome_arquivo)
rm(dados_temp)
setwd("~/Documents/Mateus/R_related/dissertacao")
##################

### tabela com as variacoes dos índices ano a ano

