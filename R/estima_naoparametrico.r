### carrega pacotes
library(np)
library(decon)
library(cowplot)
library(distrEx)
library(ggplot2)

## chama script que realiza as simulacoes e mostra os histogramas 
#source('R/simulacao_dados.r')

teste <- PNAD_PES[[1]]
ggplot2::ggplot(teste, aes(x = V4720)) +
  ggplot2::stat_density(position="identity",geom="line", bw = "nrd",
                        adjust = 1, kernel = "gaussian",
                        n = 512)+ xlim(0, 20000)





rm(PNAD_DOM)
dens_est <- list()
for (i in tam){

teste <- PNAD_PES[[i]]
#teste <- teste[1:200,]
bw_vardep <- np::npudensbw(dat= teste$V4720, bwmethod = "cv.ml", ckertype = "gaussian")
dens_vardep <- np::npudens(bw_vardep)
#graphics::plot(dens_vardep)
dens_est[i] <- list(list(bw_vardep, dens_vardep))
}
teste <- PNAD_PES[[1]]
sss <- KernSmooth::bkde(teste$V4720)
plot(sss,type = "l",xlim = c(0,10000))
hist(teste$V4720, breaks = 1000, xlim = c(0,10000))
sssss <- tibble(summary(teste$V4720))
sssss
#cria plots dos histogramas

grid_hist_plots <- cowplot::plot_grid(histograma_variavel_dependente, 
                                      histograma_var_dep_err_medida_norm, histograma_var_dep_err_medida_lognorm, nrow = 3)

## estima nao parametricamente os dados simulados (pacote np, baseado praticamente todo no livro "nonparametric
#econometric)
bw_vardep <- np::npudensbw(dat= dados_simulados$variavel_dependente)
bw_vardep_enorm <- np::npudensbw(dat= dados_simulados$var_dep_err_medida_norm)
bw_vardep_lnorm <- np::npudensbw(dat= dados_simulados$var_dep_err_medida_lognorm)

dens_vardep <- np::npudens(bw_vardep)
dens_vardep_enorm <- np::npudens(bw_vardep_enorm) 
dens_vardep_lnorm <- np::npudens(bw_vardep_lnorm)

##plota as densidades estimadas ao lado dos histogramas

graphics::plot(dens_vardep)
graphics::plot(dens_vardep_enorm)
graphics::plot(dens_vardep_lnorm)
graphics::hist(dados_simulados$variavel_dependente, breaks = 30)
graphics::hist(dados_simulados$var_dep_err_medida_norm, breaks = 30)
graphics::hist(dados_simulados$var_dep_err_medida_lognorm, breaks = 30)

## Estima usando deconvoluçao a densidade com erro de medida
# estima a bandwith com bootstrap e resampling
bw_decon_enorm <- bw.dboot2(dados_simulados$var_dep_err_medida_norm, sig=sigma_simulacao, error="normal")
# estima a densidade com erro de medida
dens_decon_enorm <-  DeconPdf(dados_simulados$var_dep_err_medida_norm,
                sigma_simulacao,
                error="normal",bw=bw_decon_enorm, fft=TRUE)

plot(dens_decon_enorm,  col="red", lwd=3, lty=2, xlab="var_dep_err_medida_norm", ylab="f(x)", main="")

### simula uma distribuição uniforme (a ideia de uma distribuição igualitaria teórica)
