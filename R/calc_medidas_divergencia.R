##### calcula medida de divergência J
##### calcula tambem os indices de THEIL

vetor_Jdiv <- NULL
vetor_JdivErro <- NULL
vetor_JdivErro1 <- NULL
vetor_TT <- NULL
vetor_TL <- NULL
vetor_TTErro <- NULL
vetor_TLErro <- NULL
vetor_TTErro1 <- NULL
vetor_TLErro1 <- NULL
lista_decomp <- list()
lista_decompErro <- list()

for(i in tam){
  rr <- PNAD_PES[[i]]
  vetor_Jdiv[i] <- j_div(rr$renda_ajustada)
  vetor_JdivErro[i] <- j_div(rr$renda_erro_medida)
  vetor_JdivErro1[i] <- j_div(rr$renda_erro_medida1)
  vetor_TT[i] <- theil_T(rr$renda_ajustada)
  vetor_TTErro[i] <- theil_T(rr$renda_erro_medida)
  vetor_TTErro1[i] <- theil_T(rr$renda_erro_medida1)  
  vetor_TL[i] <- theil_L(rr$renda_ajustada)
  vetor_TLErro[i] <- theil_L(rr$renda_erro_medida)
  vetor_TLErro1[i] <- theil_L(rr$renda_erro_medida1)  
  lista_decomp[i] <- list(c(j_decom_aditiva(rr$renda_ajustada,rr$Cor),
                            j_decom_aditiva(rr$renda_ajustada,rr$Sexo),
                            j_decom_aditiva(rr$renda_ajustada,rr$Estado)))
  lista_decompErro[i] <- list(c(j_decom_aditiva(rr$renda_erro_medida,rr$Cor),
                            j_decom_aditiva(rr$renda_erro_medida,rr$Sexo),
                            j_decom_aditiva(rr$renda_erro_medida,rr$Estado)))
}
rm(rr)

