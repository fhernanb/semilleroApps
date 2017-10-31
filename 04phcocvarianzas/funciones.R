


#Funcion que crea un data frame con todos los elementos de 
#la prueba de hipótesis de la igualdad de dos varianzas poblacionales
ph_igual_varianzas <- function(var_cuant, var_cual, nivel_de_significancia,tipo_de_prueba){
        grados_de_libertad_num <- tapply(var_cuant, var_cual, length)[1]-1
        grados_de_libertad_den <- tapply(var_cuant, var_cual, length)[2]-1
        nivel_de_significancia <- 1 - nivel_de_significancia
        
        if(tipo_de_prueba == "two.sided"){
                
                #Lado izquierdo y lado de recho donde inician las zonas de rechazo de la hipotesis nula
                lado_der <- qf(1-(nivel_de_significancia/2), grados_de_libertad_num, grados_de_libertad_den)
                lado_izq <- qf(nivel_de_significancia/2, grados_de_libertad_num, grados_de_libertad_den)
                
                #Varianza muestral grupo 1
                var1 <- tapply(var_cuant, var_cual, var)[1]
                
                #Varianza muestral grupo 2
                var2 <- tapply(var_cuant, var_cual, var)[2]
                
                #Estadistico de prueba
                ep <- var1/var2
                
                #Valor P
                ValorP <- if(pf(ep,grados_de_libertad_num,grados_de_libertad_den) <= pf(ep,grados_de_libertad_num,grados_de_libertad_den,lower.tail = FALSE)){
                        pf(ep,grados_de_libertad_num,grados_de_libertad_den)*2 #Valor P
                }else{
                        pf(ep,grados_de_libertad_num,grados_de_libertad_den,lower.tail = FALSE)*2 #Valor P
                }
                
                #Data frame que se imprime en el aplicativo
                bd <- data.frame(Resultados=c("Varianza muestral del numerador",
                                              "Varianza muestral del denominador",
                                              "Estadistico de prueba (EP)",
                                              "Nivel de significancia",
                                              "Grados de libertad del numerador",
                                              "Grados de libertad del denominador",
                                              "Valor P",
                                              "Regiones criticas de rechazo de hipotesis nula",
                                              "Conclusion con el valor P",
                                              "Conclusion con la region de rechazo")
                                 ,
                                 Valores=c(as.character(var1),
                                           as.character(var2),
                                           as.character(round(ep,8)),
                                           as.character(nivel_de_significancia),
                                           as.character(grados_de_libertad_num),
                                           as.character(grados_de_libertad_den),
                                           as.character(ValorP),
                                           paste("EP <= ",as.character(round(lado_izq,4)),
                                                 "o",
                                                 "EP >= ", as.character(round(lado_der,4)),
                                                 sep = "  "),
                                           if(ValorP <= nivel_de_significancia){
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         "con un valor p igual a", ValorP,
                                                         "Como el valor p es inferior o igual a", nivel_de_significancia,
                                                         "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                         alternativa.")
                                           }else{
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         "con un valor p igual a", ValorP,
                                                         "Como el valor es mayor a",nivel_de_significancia,
                                                         "(nivel de significancia), entonces se concluye que los datos no son suficientes para
                                                         rechazar la hipotesis nula.")
                                           },
                                           if(ep <= lado_izq |
                                              ep >= lado_der){
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         ". Como el estadistico de prueba se encuentra
                              dentro de la region critica de rechazo entonces se rechaza
                              la hipotesis nula en favor de la hipotesis alternativa.")
                                           }else{
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         ". Como el estadistico de prueba se encuentra fuera
                              de la region critica de rechazo entonces se concluye que
                              los datos no son suficientes para rechazar la hipotesis nula.")
                                           }
                                 ))
                bd
                
        }else{
                if(tipo_de_prueba == "less"){
                        
                        #Lado izquierdo  donde inicia la zona de rechazo de la hipotesis nula
                        lado_izq <- qf(nivel_de_significancia, grados_de_libertad_num, grados_de_libertad_den)
                        
                        #Varianza muestral grupo 1
                        var1 <- tapply(var_cuant, var_cual, var)[1]
                        
                        #Varianza muestral grupo 2
                        var2 <- tapply(var_cuant, var_cual, var)[2]
                        
                        #Estadistico de prueba
                        ep <- var1/var2
                        
                        #Valor P
                        ValorP <- pf(ep, grados_de_libertad_num, grados_de_libertad_den)
                        
                        #Data frame que se imprime en el aplicativo
                        bd <- data.frame(Resultados=c("Varianza muestral del numerador",
                                                      "Varianza muestral del denominador",
                                                      "Estadistico de prueba (EP)",
                                                      "Nivel de significancia",
                                                      "Grados libertad numerador",
                                                      "Grados libertad denominador",
                                                      "Valor P",
                                                      "Region critica de rechazo de hipotesis nula",
                                                      "Conclusion con el valor P",
                                                      "Conclusion con la region de rechazo")
                                         ,
                                         Valores=c(as.character(var1),
                                                   as.character(var2),
                                                   as.character(round(ep,8)),
                                                   as.character(nivel_de_significancia),
                                                   as.character(grados_de_libertad_num),
                                                   as.character(grados_de_libertad_den),
                                                   as.character(ValorP),
                                                   paste("EP <= ",as.character(round(lado_izq,4))),
                                                   if(ValorP <= nivel_de_significancia){
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 "con un valor p igual a", ValorP,
                                                                 "Como el valor p es inferior o igual a", nivel_de_significancia,
                                                                 "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                                 alternativa.")
                                                   }else{
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 "con un valor p igual a", ValorP,
                                                                 "Como el valor es mayor a", nivel_de_significancia,
                                                                 "(nivel de significancia), entonces se concluye que los datos no son suficientes para
                                                                 rechazar la hipotesis nula.")
                                                   },
                                                   if(ep <= lado_izq){
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 ". Como el estadistico de prueba se encuentra
                                                                 dentro de la region critica de rechazo entonces se rechaza
                                                                 la hipotesis nula en favor de la hipotesis alternativa.")
                                                   }else{
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 ". Como el estadistico de prueba se encuentra fuera
                                                                 de la region critica de rechazo entonces se concluye que
                                                                 los datos no son suficientes para rechazar la hipotesis nula.")
                                                   }
                                         ))
                        bd
                        
                }else{
                        if(tipo_de_prueba == "greater"){
                                
                                #Lado derecho donde inician las zonas de rechazo de la hipotesis nula
                                lado_der <- qf(1-nivel_de_significancia, grados_de_libertad_num, grados_de_libertad_den)
                                
                                #Varianza muestral del numerador
                                var1 <- tapply(var_cuant, var_cual, var)[1]
                                
                                #Varianza muestral del denominador
                                var2 <- tapply(var_cuant, var_cual, var)[2]
                                
                                #Estadistico de prueba
                                ep <- var1/var2
                                
                                #Valor P
                                ValorP <- pf(ep,grados_de_libertad_num,grados_de_libertad_den,lower.tail = FALSE)
                                
                                #Data frame que se imprime en el aplicativo
                                bd <- data.frame(Resultados=c("Varianza muestral del numerador",
                                                              "Varianza muestral del denominador",
                                                              "Estadistico de prueba (EP)",
                                                              "Nivel de significancia",
                                                              "Grados de libertad del numerador",
                                                              "Grados de libertad del denominador",
                                                              "Valor P",
                                                              "Region critica de rechazo de hipotesis nula",
                                                              "Conclusion con el valor P",
                                                              "Conclusion con la region de rechazo")
                                                 ,
                                                 Valores=c(as.character(var1),
                                                           as.character(var2),
                                                           as.character(round(ep,8)),
                                                           as.character(nivel_de_significancia),
                                                           as.character(grados_de_libertad_num),
                                                           as.character(grados_de_libertad_den),
                                                           as.character(ValorP),
                                                           paste("EP >= ", as.character(round(lado_der,4)),
                                                                 sep = "  "),
                                                           if(ValorP <= nivel_de_significancia){
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         "con un valor p igual a", ValorP,
                                                                         "Como el valor p es inferior o igual a", nivel_de_significancia,
                                                                         "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                                         alternativa.")
                                                           }else{
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         "con un valor p igual a", ValorP,
                                                                         "Como el valor es mayor a",nivel_de_significancia,
                                                                         "(nivel de significancia), entonces se concluye que los datos no son suficientes para
                                                                         rechazar la hipotesis nula.")
                                                           },
                                                           if(ep >= lado_der){
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         ". Como el estadistico de prueba se encuentra
                                                                         dentro de la region critica de rechazo entonces se rechaza
                                                                         la hipotesis nula en favor de la hipotesis alternativa.")
                                                           }else{
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         ". Como el estadistico de prueba se encuentra fuera
                                                                         de la region critica de rechazo entonces se concluye que
                                                                         los datos no son suficientes para rechazar la hipotesis nula.")
                                                           }
                                                 ))
                                bd
                }
        }
        }
}