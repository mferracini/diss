### carrega pacotes
require(ggplot2)
require(stats)
require(dplyr)
require(magrittr)

# ## cria lista com todas as densidades estimadas
# densidades <- list()
# 
# for (i in tam){
# titulo <- paste("Densidade estimada - ", anos[i])
# teste <- PNAD_PES[[i]]
# densidades[i] <- list(ggplot(teste, aes(x = renda_ajustada)) +
#   stat_density(position="identity",geom="line", bw= "nrd", colour = "red") +
#   geom_histogram(aes(y = ..density..), bins=53, alpha= 0.3, colour = "blue")+
#   xlim(0,5000)+
#   ggplot2::ggtitle(titulo) +
#   ggplot2::xlab("Renda mensal ajustada") +
#   ggplot2::ylab("Densidade") +  
#   ggplot2::theme_bw())
#   
# }
# rm(teste)


## Cria data frame para plotar todas densidades juntas

#densidades[[1]]

df <- NULL
for (i in tam){
dt <- PNAD_PES[[i]] %>% 
  dplyr::select(Ano,renda_ajustada)
df <- rbind(df,dt)
}
rm(dt)
df$Ano <- as.factor(df$Ano)

ggplot(df, aes(x = renda_ajustada, fill = Ano, colour = Ano)) +
  stat_density( bw= "bcv", alpha= 0.3) +
  xlim(0,5000) +
  ylim(0,0.012) + 
#  ggplot2::ggtitle("Densidades estimadas") +
  ggplot2::xlab("Renda mensal ajustada") +
  ggplot2::ylab("Densidade")+  
  ggplot2::theme_bw()


## grid para plotar todas as densidades estimadas juntas
ggplot(df, aes(x = renda_ajustada)) +
  stat_density(position="identity",geom="line", bw= "bcv", colour = "red") +
  geom_histogram(aes(y = ..density..), bins=53, alpha= 0.3, colour = "blue")+
  xlim(0,5000)+
  ggplot2::xlab("Renda mensal ajustada") +
  ggplot2::ylab("Densidade")+
  facet_wrap(~Ano, ncol = 3)


ggplot(df, aes(Ano, renda_ajustada))+
 geom_boxplot() + 
  ggplot2::ylab("Renda mensal ajustada") +
  ggplot2::ggtitle("Box plot - Renda mensal", subtitle = "Valores ajustados pelo INPC")
