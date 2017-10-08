#### Script que simula os dados de erros de medida
#### Carrega os pacotes necessários
library(stats)

### sta o seed para a simulação
set.seed(666)
vec_erromedida <- NULL
vec_erromedida1 <- NULL

a <- -0.2
b <- 0.2
a1 <- 0
b1 <- 0.2

for (i in tam){
  teste <- PNAD_PES[[i]]
  vec_erromedida = runif(nrow(teste),min = a,max = b)
  vec_erromedida1 = runif(nrow(teste),min = a1,max = b1)
  renda_erro_medida <- (PNAD_PES[[i]]$renda_ajustada*vec_erromedida)+PNAD_PES[[i]]$renda_ajustada
  erro_medida <- renda_erro_medida - PNAD_PES[[i]]$renda_ajustada
  renda_erro_medida1 <- (PNAD_PES[[i]]$renda_ajustada*vec_erromedida1)+PNAD_PES[[i]]$renda_ajustada
  erro_medida1 <- renda_erro_medida1 - PNAD_PES[[i]]$renda_ajustada  
  PNAD_PES[[i]] <- cbind(PNAD_PES[[i]],
                         vec_erromedida,
                         renda_erro_medida,
                         erro_medida,
                         renda_erro_medida1,
                         erro_medida1)
}

rm(list = c("teste",
            "vec_erromedida",
            "renda_erro_medida",
            "erro_medida",
            "renda_erro_medida1",
            "erro_medida1"))
