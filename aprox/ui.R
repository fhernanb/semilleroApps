library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  
  # Application title
  
  titlePanel("APROXIMACIÓN ENTRE DISTRIBUCIONES"),
  
  navbarPage(" ",
             tabPanel("Introducción",
                      sidebarLayout(
                        sidebarPanel(h3("Objetivo:"),
                                     h4(" El objetivo principal de la aplicación es mostrar
                                        gráficamente cómo se comportan las aproximaciones entre
                                        distribuciones, variando los parámetros necesarios de 
                                        cada distribución y viendo su comportamiento.")),
                        
                        
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          
                          h2("Casos:"),
                          h3("Aprox 1: de la binomial a la normal"),
                          h3("Aprox 2: de la Poisson a la normal"),
                          h3("Aprox 3: de la binomial a la Poisson"),
                          h3("Aprox 4: de la hipergeométrica a la binomial")
                          
                          
                        )
                                     )
                      
                        ),
             
             
             tabPanel("Aproximación 1",
                      sidebarLayout(
                        sidebarPanel(
                          
                          sliderInput("n",
                                      "Tamaño de muestra n",
                                      min = 5,
                                      max = 100,
                                      value = 10,
                                      step = 1, animate=TRUE),
                          
                          sliderInput("p",
                                      "Probabilidad de éxito p",
                                      min = 0,
                                      max = 1,
                                      value = 0.84,
                                      step = 0.01, animate=TRUE)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la binomial a la normal"),
                                  tabsetPanel(tabPanel("Grafica", plotOutput("Grafica")),
                                              tabPanel("Teoria", 
                                                       h4(HTML("Cuando la cantidad de experimentos tiende a 
                                                          infinito (generalmente se considera que esto sucede 
                                                          cuando n≥30), la distribución binomial tiende a la 
                                                          distribución normal, siempre y cuando p y q (q=1-p) no sean 
                                                          ninguna menor a 0.1 y además np≥10 y nq≥10. 
                                                          Cuando aproximamos una distribución binomial mediante una normal,
                                                          estamos convirtiendo una variable X discreta (toma un número 
                                                          determinado de valores) en una continua X’ (toma valores en un intervalo) 
                                                          ,entonces se tiene en cuenta un factor de corrección por continuidad de + o - 0.5."))
                                                       )
                                              
                                                       )
                                              )
                                  )
                      
                        ),
             
             
             tabPanel("Aproximación 2",
                      sidebarLayout(
                        sidebarPanel(
                          
                          
                          sliderInput("l",
                                      HTML("Tasa promedio &lambda;"),
                                      min = 1,
                                      max = 50,
                                      value = 2,
                                      step = 1, animate=TRUE)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la poisson a a normal"),
                                  tabsetPanel(tabPanel("Grafica", plotOutput("Grafica1")),
                                              tabPanel("Teoria", 
                                                       h4("Para el caso de la distribución de Poisson,
                                                          cuando λ≥10, la forma de esta distribución se 
                                                          asemeja lo suficiente a la distribución Normal
                                                          como para que puede utilizarse ésta última como
                                                          aproximación. Para realizar la aproximación,
                                                          debe considerarse que la distribución Normal 
                                                          tendrá parámetros lambda y raiz de lambda para la
                                                          media y la desviación estándar respectivamente.")
                                              ))
                                  
                        )
                      )
             ),
             tabPanel("Aproximación 3",
                        sidebarLayout(
                          sidebarPanel(
                            
                            sliderInput("n2",
                                        "Tamaño de muestra n",
                                        min = 5,
                                        max = 300,
                                        value = 5,
                                        step = 1, animate=TRUE),
                            
                            sliderInput("p2",
                                        "Probabilidad de éxito p",
                                        min = 0,
                                        max = 1,
                                        value = 0.9,
                                        step = 0.05, animate=TRUE)
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(h2("Aproximación de la binomial a la poisson"),
                                    tabsetPanel(tabPanel("Grafica", plotOutput("Grafica2")),
                                                tabPanel("Teoria", 
                                                         h4("Se puede demostrar que una binomial cuyo n es muy
                                                            grande y p tiende a 0, es decir, un suceso raro, 
                                                            se aproxima como una Poisson con λ=np. Una regla 
                                                            general aceptable es emplear esta aproximación 
                                                            si n≥20 y p≤0.05: sí n≥100, la aproximación es ge
                                                            neralmente excelente siempre y cuando np≤10. P
                                                            or esta razón se considera a veces al modelo de 
                                                            Poisson como una forma límite de la distribución
                                                            Binomial y se le utiliza para aproximar 
                                                            probabilidades en ésta.")
                                                         )
                                                
                                                )
                                                )
                                                )
                        
                                                ),
             tabPanel("Aproximación 4",
                      sidebarLayout(
                        sidebarPanel(
                          
                          
                          sliderInput("m",
                                      "Número de éxitos en la población m",
                                      min = 0,
                                      max = 300,
                                      value = 10,
                                      step = 1),
                          sliderInput("n",
                                      "Número de fracasos en la población n",
                                      min = 0,
                                      max = 300,
                                      value = 50,
                                      step = 1),
                          sliderInput("k",
                                      "tamaño de muestra k",
                                      min = 0,
                                      max = 300,
                                      value = 25,
                                      step = 1)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la hipergeométrica a la binomial"),
                                  tabsetPanel(tabPanel("Grafica", plotOutput("Grafica3")),
                                              tabPanel("Teoria", 
                                                       h4("En general puede mostrarse que la hipergeométrica
                                                          h(x;m,n,k) se aproxima a la binomial b(x;k,p) con 
                                                          p = m/N = m/(m+n) cuando N tiende a infinito.Se usa la aproximación
                                                          generalmente cuando: 1.) n es menor que N/10, 2.)N-n/N-1 sea cercano a 1,
                                                          3.) n/N es menor que 0.05, es decir cuando la muestra es inferior al 5%
                                                          de la población.")
                                                       )
                                              
                                                       )
                                              )
                                              )
                      
                                              )
             
                   )
  
             ))