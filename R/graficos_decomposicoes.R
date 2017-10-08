### cria graficos com os resultados das decomposicoes
require(ggplot2)

jdiv <- rep(c("Sem erro medida"),times = 9)
jdiv1 <- rep(c("Erro medida 1"),times = 9)
jdiv2 <- rep(c("Erro medida 2"),times = 9)

Jdiv_ <- data.frame(anos,vetor_Jdiv,jdiv)
Jdiv_1 <- data.frame(anos,vetor_JdivErro,jdiv1)
Jdiv_2 <- data.frame(anos,vetor_JdivErro1,jdiv2)
colnames(Jdiv_1) <- colnames(Jdiv_)
colnames(Jdiv_2) <- colnames(Jdiv_)

Jdiv_todos <- rbind(Jdiv_,Jdiv_1,Jdiv_2)
colnames(Jdiv_todos) <- c("Ano","Valor","Indice")

rm(list = c("jdiv","jdiv1","jdiv2","Jdiv_","Jdiv_1","Jdiv_2"))

ggplot(data = Jdiv_todos, aes(x = factor(Ano), y = Valor, color = Indice)) +       
  geom_line(aes(group = Indice)) + 
  geom_point() +
  ggplot2::xlab("Ano")
