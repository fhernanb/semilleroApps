
# Para generar base de datos DIFERENCIA DE MEDIAS -------------------------

dt <- data.frame(y=c(rnorm(n=100, mean=170, sd=5),
                     rnorm(n=150, mean=173, sd=5)),
                 group=rep(c('Grupo 1', 'Grupo 2'), times=c(100, 150)))


write(x=t(dt), file='equal_var_data.txt', ncolumns=2, sep='\t')


dt <- data.frame(y=c(rnorm(n=100, mean=65, sd=10),
                      rnorm(n=150, mean=70, sd=5)),
                 group=rep(c('Grupo 1', 'Grupo 2'), times=c(100, 150)))


write(x=t(dt), file='unequal_var_data.txt', ncolumns=2, sep='\t')



# Para generar base de datos MEDIAS ---------------------------------------

dt <- data.frame(y=rnorm(n=100, mean=60, sd=5),
                 x=rnorm(n=100, mean=170, sd=15))

write(x=t(dt), file='means_data.txt', ncolumns=2, sep='\t')

