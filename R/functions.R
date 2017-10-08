##### função medida de divergência J
##### base no paper de ROHDE 2015
require(tibble)
require(dplyr)
require(magrittr)
require(tidyr)
require(plyr)

j_div <- function(x){
  ### parâmetro x é um vetor (numeric) de quantidades
  vetor_media <- mean(x)
  vetor_media <- c(rep(vetor_media , times = nrow(as_tibble(x))))
  j_index <- (1/sum(x))*sum((x-vetor_media)*log(x/vetor_media))
  return(j_index)
}

### subgroup decomposition
j_decom_aditiva <- function(x,group){
  ### parâmetro x é um vetor (numeric) de quantidades
  ### group é um vetor de quantidade (discreta) cujas entradas podem ser string
  base <- data.frame (x = x, group = group)
  grp <- levels(group)
  mu <- mean(x)
  n <- nrow(as_tibble(x))
  dec_between <- NULL
  dec_within <- NULL
  for(j in 1:length(grp)){
    b_temp <- base %>% 
      dplyr::filter(group == grp[j]) 
    mu_grupo <- mean(b_temp$x)
    n_grupo <- nrow(b_temp)
    vetor_mu_grupo <- c(rep(mu_grupo , times = n_grupo))    
    dec_between[j] <- log(mu_grupo/mu)*((n_grupo*(mu_grupo - mu))/(n*mu))
    dec_within[j] <-(1/(n*mu))*sum((b_temp$x)*log((b_temp$x)/vetor_mu_grupo))+
      ((-1/n)*sum(log((b_temp$x)/vetor_mu_grupo))) 
  }
  result_between <- data.frame(grupo = grp, D_between = dec_between)
  result_within <- data.frame(grupo = grp, D_within = dec_within)
  resultado <- plyr::join(result_between,result_within, by = "grupo")
  total_grupo <- resultado$D_between + resultado$D_within
  resultado <- list(cbind(resultado, total_grupo))
  #resultado <- list(result_between, result_within)
  return(resultado)
}

limpa_PNAD_PES <- function(x){
  vars_selecionadas <- c('V0101', "UF",'V0102',"V0103","V0404","V0302",'V4720','V8005')
  rr <- tibble::as_tibble(x[[1]]) %>% select(one_of(vars_selecionadas)) 
  ss <- rr
  rr <- rr %>% 
    tidyr::drop_na(V4720) %>% 
#    dplyr::filter(V4720 < 999999999999 & V4720 > 0) %>% 
    dplyr::filter(V4720 < 250000 & V4720 > 0) %>%
    dplyr::filter(V8005 >= 15 & V8005 <= 65)
  pct_PNAD_PES <- nrow(rr)/nrow(ss)
  my.result <- list(rr,pct_PNAD_PES)
  return(my.result)
}

theil_T <- function(x){
  tamanho <- nrow(as_tibble(x))
  vetor_media <- c(rep(mean(x) , times = tamanho))
  resultado <- (1/tamanho)*sum((x/vetor_media)*log(x/vetor_media))
  return(resultado)
}

theil_L <- function(x){
  tamanho <- nrow(as_tibble(x))
  vetor_media <- c(rep(mean(x) , times = tamanho))
  resultado <- (-1/tamanho)*sum(log(x/vetor_media))
  return(resultado)
}
