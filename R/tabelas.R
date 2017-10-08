### Cria as tabelas com as variaveis da PNAD para fazer o JOIN

UF_index <- c(seq(11,17, by = 1),seq(21,29, by = 1),c(31:33),35,c(41:43),c(50:53))
UF_nomes <- c("Rondônia","Acre","Amazonas","Roraima", "Pará","Amapá", "Tocantins",
              "Maranhão","Piaui", "Ceará","Rio Grande do Norte",
              "Paraíba","Pernambuco","Alagoas","Sergipe","Bahia", "Minas Gerais",
              "Espirito Santo", "Rio de Janeiro", "São Paulo", "Paraná",
              "Santa Catarina", "Rio Grandedo Sul", "Mato Grosso do Sul",
              "Mato Grosso", "Goiás", "Distrito Federal")
tab_UF <- data.frame(index_UF = UF_index, Estado = UF_nomes)


SEXO_index <- c(2,4)
SEXO_nomes <- c("Maculino","Feminino")
tab_SEXO <- data.frame(index_SEXO = SEXO_index, Sexo = SEXO_nomes)

COR_index <- c(2,4,6,8,0,9)
COR_nomes <- c("Branca","Preta","Amarela","Parda","indigena","Sem declaracao")
tab_COR <- data.frame(index_COR = COR_index, Cor = COR_nomes)
