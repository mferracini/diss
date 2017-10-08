#### limpa as bases da PNAD para deixar apenas as colunas uteis e remover os valores com NA.

#chama script que le as bases da PNAD
source('R/read_PNAD.R')

## pacotes para realizar data wrangling
require(dplyr)
require(magrittr)
require(tibble)
require(tidyr)

vars_selecionadas <- c('V0101', "UF",'V0102',"V0103","V0404","V0302",'V8005',
                       'V0408','V0601','V9001','V4803', 'V4704', 'V4720')

PNAD_PES_LIMPA <- list()
pct_bases <- NULL
for (i in 1:5){
rr <- tibble::as_tibble(PNAD_PES[[i]]) %>% select(one_of(vars_selecionadas)) 
a <- nrow(rr)
PNAD_PES[i] <- rr %>% 
  tidyr::drop_na(V4720) %>% 
  dplyr::filter(V4720 < 999999999999) %>% 
  dplyr::filter(V4720 > 0) %>% 
  list()

  pct_bases[i] <- nrow(PNAD_PES[[i]]) / a
}




View(PNAD_PES_LIMPA[[5]])








#rm(PNAD_DOM)
#rm(PNAD_PES)
#rm(i)
#rm(rr)
#rm(vars_selecionadas)
 
qtd_NA_col <- PNAD %>% 
   purrr::map_df(function(x) (sum(is.na(x)))) %>% 
   tidyr::gather(covariada, num_NA) %>%
   dplyr::filter(num_NA>1)
 
qtd_ZERO_col <- PNAD %>% 
   dplyr::filter(is.na(V4720)==FALSE) %>% 
   purrr::map_df(function(x) (sum(x == 0))) %>% 
   tidyr::gather(covariada, num_ZERO) 

 
 covars <- c(qtd_NA_col$covariada)
