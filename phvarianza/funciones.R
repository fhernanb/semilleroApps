
#Función para crear la prueba chi-cuadrado para varianza

#Argumentos
#variable, es un vector columna, con los datos que representan la variable.
#varianza_h_n, es el valor de la hipotesis nula
#nivel_significancia, es el nivel de significancia
#tipo_de_prueba, representa las desigualdades de la hipotesis alternativa: dos colas, mayor que, menor que

#Funcion que permite generar el texto de la conclusion de la prueba de hipotesis



#Función que genera el data frame con los elementos de la prueba de hipótesis
prueba_hip_varianza <- function(variable, varianza_h_n, nivel_significancia,
                            tipo_de_prueba){
        
        grados_de_libertad <- length(variable) - 1
        
        if(tipo_de_prueba == "two.sided"){
                #Valor de la distribucion chi-cuadrado
                #a partir del cual inicia la region de rechazo en el lado derecho
                #de la distribución
                lado_der <- qchisq(nivel_significancia + (1-nivel_significancia)/2, grados_de_libertad)
                
                #Valor de la distribucion chi-cuadrado
                #a partir del cual inicia la region de rechazo en el lado izquierdo
                #de la distribución
                lado_izq <- qchisq((1-nivel_significancia)/2, grados_de_libertad)
                
                varianza_muestral <- var(variable)
                
                #Estadístico de prueba
                ep <- grados_de_libertad*varianza_muestral/varianza_h_n
                
                ValorP <- if(pchisq(ep,grados_de_libertad) <= pchisq(ep,grados_de_libertad,lower.tail = FALSE)){
                        pchisq(ep,grados_de_libertad)*2 #Valor p
                }else{
                        pchisq(ep,grados_de_libertad,lower.tail = F)*2 #Valor p
                }
               
                #Data frame con todos los componentes de la prueba de hipotesis. 
               bd <- data.frame(Resultados=c("Varianza muestral",
                                             "Estadistico de prueba (EP)",
                                             "Nivel de significancia",
                                             "Grados de libertad",
                                             "Valor p",
                                             "Region critica de rechazo de hipotesis nula",
                                            paste("Intervalo de confianza del", nivel_significancia*100,"%"),
                                            "Conclusion con el Valor P",
                                            "Conclusion con la region de rechazo")
                                ,
                                 Valores=c(as.character(round(varianza_muestral,8)),
                                           as.character(round(ep,8)),
                                           as.character(1-nivel_significancia),
                                           as.character(grados_de_libertad),
                                           as.character(ValorP),
                                           paste("EP <= ",as.character(round(lado_izq,4)),
                                                 "o",
                                                 "EP >= ", as.character(round(lado_der,4)),
                                                 sep = "  "),
                                           paste("(",
                                                 as.character(
                                                         round(grados_de_libertad * varianza_muestral/lado_der,8)),
                                                 ",",
                                                 as.character(round(grados_de_libertad * varianza_muestral/lado_izq,8)),
                                                 ")"),
                                           if(ValorP <= 1-nivel_significancia){
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         "con un valor p igual a", ValorP,
                                                         "Como el valor p es inferior o igual a", 1-nivel_significancia,
                                                         "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                         alternativa.")
                                           }else{
                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                         "con un valor p igual a", ValorP,
                                                         "Como el valor es mayor a", 1-nivel_significancia,
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
                        #Valor de la distribucion chi-cuadrado
                        #a partir del cual inicia la region de rechazo en el lado izquierdo
                        #de la distribución
                        lado_izq <- qchisq(1-nivel_significancia,grados_de_libertad)
                        
                        #Valor de la distribucion chi-cuadrado
                        #a partir del cual inicia la region de rechazo en el lado derecho
                        #de la distribución
                        #lado_der <- qchisq((1-nivel_significancia/2), grados_de_libertad)
                        
                        varianza_muestral <- var(variable)
                        
                        #Estadístico de prueba
                        ep <- grados_de_libertad*varianza_muestral/varianza_h_n
                        
                        #Valor P
                        ValorP <- pchisq(ep,grados_de_libertad)
                        
                        bd <- data.frame(Resultados=c("Varianza muestral",
                                                      "Estadistico de prueba (EP)",
                                                      "Nivel de significancia",
                                                      "Grados de libertad",
                                                      "Valor P",
                                                      "Region critica de rechazo de hipotesis nula",
                                                      paste("Intervalo de confianza del", nivel_significancia*100,"%"),
                                                      "Conclusion con el Valor P",
                                                      "Conclusion con la region de rechazo")
                                         ,
                                         Valores=c(as.character(round(varianza_muestral,8)),
                                                   as.character(round(ep,8)),
                                                   as.character(1-nivel_significancia),
                                                   as.character(grados_de_libertad),
                                                   as.character(ValorP), #Valor P
                                                   paste("EP <= ",as.character(round(lado_izq,4)),
                                                         sep = "  "),
                                                   paste("(",
                                                         as.character(
                                                                 round(grados_de_libertad * varianza_muestral/qchisq(nivel_significancia + (1-nivel_significancia)/2, grados_de_libertad),8)),
                                                         ",",
                                                         as.character(
                                                                 round(grados_de_libertad * varianza_muestral/qchisq((1-nivel_significancia)/2, grados_de_libertad),8)),
                                                         ")"),
                                                   if(ValorP <= 1-nivel_significancia){
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 "con un valor p igual a", ValorP,
                                                                 "Como el valor p es inferior o igual a", 1-nivel_significancia,
                                                                 "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                                 alternativa.")
                                                   }else{
                                                           paste("El estadistico de prueba es igual a", round(ep,8),
                                                                 "con un valor p igual a", ValorP,
                                                                 "Como el valor p es mayor a", 1-nivel_significancia,
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
                                
                                #Valor de la distribucion chi-cuadrado
                                #a partir del cual inicia la region de rechazo en el lado derecho
                                #de la distribución
                                lado_der <- qchisq(nivel_significancia, grados_de_libertad)
                                
                                varianza_muestral <- var(variable)
                                
                                #Estadístico de prueba
                                ep <- grados_de_libertad*varianza_muestral/varianza_h_n
                                
                                #Valor P
                                ValorP <- pchisq(ep,grados_de_libertad,lower.tail = FALSE)
                                
                                bd <- data.frame(Resultados=c("Varianza muestral",
                                                              "Estadistico de prueba (EP)",
                                                              "Nivel de significancia",
                                                              "Grados de libertad",
                                                              "ValorP",
                                                              "Region critica de rechazo de hipotesis nula",
                                                              paste("Intervalo de confianza del", nivel_significancia*100,"%"),
                                                              "Conclusion con el Valor P",
                                                              "Conclusion con la region de rechazo")
                                                 ,
                                                 Valores=c(as.character(round(varianza_muestral,8)),
                                                           as.character(round(ep,8)),
                                                           as.character(1-nivel_significancia),
                                                           as.character(grados_de_libertad),
                                                           as.character(ValorP),
                                                           paste("EP >= ", as.character(round(lado_der,4)),
                                                                 sep = "  "),
                                                           paste("(",
                                                                 as.character(
                                                                         round(grados_de_libertad * varianza_muestral/qchisq(nivel_significancia + (1-nivel_significancia)/2, grados_de_libertad),8)),
                                                                 ",",
                                                                 as.character(
                                                                         round(grados_de_libertad * varianza_muestral/qchisq((1-nivel_significancia)/2, grados_de_libertad),8)),
                                                                 ")"),
                                                           if(ValorP <= 1-nivel_significancia){
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         "con un valor p igual a", ValorP,
                                                                         "Como el valor p es inferior o igual a", 1-nivel_significancia,
                                                                         "(nivel de significancia), entonces se rechaza la hipotesis nula en favor de la hipotesis
                                                                         alternativa.")
                                                           }else{
                                                                   paste("El estadistico de prueba es igual a", round(ep,8),
                                                                         "con un valor p igual a", ValorP,
                                                                         "Como el valor p es mayor a", 1-nivel_significancia,
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
                        }else{
                                "Usted debe proporcionar el argumento tipo de prueba. Este asume tres valores:

                                Diferente (dos colas)
                                Menor (una cola)
                                Mayo (una cola)
                                
                                Usted debe elegir uno."
                        }
                }
        }
        
        
}



#bd <- read.table("geardata.txt", col.names = c("diametro", "bold number"))
#head(bd)
#prueba_hip_varianza(bd$diametro,0.01,0.95,"two.sided")
#Valor p
#ValorPgeneral <- function(tipo_de_prueba){
        #if(tipo_de_prueba=="two.sided"){
         #       if(pchisq(ep,grados_de_libertad) <= pchisq(ep,grados_de_libertad,lower.tail = FALSE)){
          #              pchisq(ep,grados_de_libertad)*2 #Valor p
           #     }else{
            #            pchisq(ep, grados_de_libertad, lower.tail = F)*2 #Valor p
             #   }
        #}else{
         #       if(tipo_de_prueba=="less"){
          #              pchisq(ep, grados_de_libertad)
           #     }else{
            #            if(tipo_de_prueba=="greater"){
             #                   pchisq(ep, grados_de_libertad,lower.tail = FALSE)
              #          }
               # }
        #}
#}
