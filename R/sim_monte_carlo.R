### simula monte carlo da distribuição
source('R/functions.R')

set.seed(666)
num_it <- 1000
num_sim <- 1000

resultado <- list()

tab <- matrix(NA,num_sim,3)

for (i in 1:num_it){
  for (j in 1:num_sim){
  vetor_renda <- rlnorm(num_sim,0,3)
  media <- mean(vetor_renda)
  vetor_teorico <- runif(num_sim, 0.5*media,1.5*media)
  tab[j,1] <-  j_div(vetor_renda)
  tab[j,2] <-  theil_L(vetor_renda)
  tab[j,3] <-  theil_T(vetor_renda)
  }
  resultado[i] <- tab
}


res_mean <- apply(tab, c(2), mean)
res_var <- apply(tab, c(2), var)

plot(res_var[,1])
