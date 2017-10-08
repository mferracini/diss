### Realiza as análises descritivas
require(tibble)

descr <- list()

for (i in tam){
  teste <- PNAD_PES[[i]]
  descr[i] <- list(c(summary(teste$Cor)/nrow(teste),summary(teste$Sexo)/nrow(teste),
             summary(teste$Estado)/nrow(teste)))
}

df <- NULL
for (i in tam){
  df <- cbind(df,descr[[i]])
}

tab_descritiva <- data.frame(df)
colnames(tab_descritiva) <- anos

descr <- list()
descr_erro <- list()
df <- NULL
df_erro <- NULL
for (i in tam){
  teste <- PNAD_PES[[i]]
  descr[i] <- list(summary(teste$renda_ajustada))
  descr_erro[i] <- list(summary(teste$renda_erro_medida))
}
for (i in tam){
  df <- cbind(df,descr[[i]])
  df_erro <- cbind(df_erro,descr_erro[[i]])
}

tab_descritiva_renda <- data.frame(df)
colnames(tab_descritiva_renda) <- anos
tab_descritiva_rendaErro <- data.frame(df_erro)
colnames(tab_descritiva_rendaErro) <- anos
rm(list = c("descr","df","teste","i","df_erro","descr_erro"))

require(formattable)
require(purrr)
require(magrittr)
names <- rownames(tab_descritiva)
tab_descritiva <- tab_descritiva %>% 
  purrr::map(percent) %>% 
  as_tibble() 

rownames(tab_descritiva) <- names

rm(names)


n_base <- NULL

for (i in tam){
  n_base[i] <- nrow(PNAD_PES[[i]])  
}

n_base_raw <- n_base/pct_bases[,2]
dados_num <- data.frame(pct_bases,n_base_raw,n_base)
rm(n_base_raw)
rm(n_base)

rownames(tab_descritiva_renda) <- c("Mínimo","1º quartil","Mediana","Média","3º quartil","Máximo")

### analise exploratoria 

#require(ggplot2)
#rr <- PNAD_PES[[1]]
