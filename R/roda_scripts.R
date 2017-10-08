### chama os scripts na ordem para gerar as analises
setwd("~/Documents/Mateus/R_related/dissertacao")
options(scipen = 999)

source('R/read_PNAD.R')
source('R/merge_bases.R')
source('R/INPC_ajuste.R')
source('R/simulacao_dados.r')
source('R/results_descritivos.R')
source('R/calc_medidas_divergencia.R')

