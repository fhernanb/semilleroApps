library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  
  # Application title
  
  titlePanel("Aproximación de distribuciones"),
  
  navbarPage(" ",
             tabPanel("Introducción",
                      sidebarLayout(
                        sidebarPanel(h3("Objetivo:"),
                                     h5("El objetivo de esta aplicación es mostrar
                                        gráficamente la aproximación de una distribución a otra
                                        a medida que el usuario varía los parámetros
                                        de una de ellas."),
                                     img(src="medellin.png", height = 80, width = 200),
                                     br(),
                                     br(),
                                     p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
                                     tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")),
                        
                        mainPanel(
                          h2("Casos:"),
                          h3("Aproximación 1: de la binomial a la normal"),
                          h3("Aproximación 2: de la Poisson a la normal"),
                          h3("Aproximación 3: de la binomial a la Poisson"),
                          h3("Aproximación 4: de la hipergeométrica a la binomial")
                          
                          
                        )
                        )
                        ),
             
             
             tabPanel("Aproximación 1",
                      sidebarLayout(
                        sidebarPanel(
                          h4('Ingrese los parámetros de la binomial'),
                          br(),
                          sliderInput("n",
                                      "Número de ensayos n",
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
                                  tabsetPanel(tabPanel("Gráfica", plotOutput("Grafica1")),
                                              tabPanel("Teoría", includeHTML("teo1.html"))
                        )
                        )
                        )
                        ),
             
             
             tabPanel("Aproximación 2",
                      sidebarLayout(
                        sidebarPanel(
                          h4('Ingrese los parámetros de la Poisson'),
                          br(),
                          sliderInput("l",
                                      HTML("Tasa promedio &lambda;"),
                                      min = 1,
                                      max = 50,
                                      value = 2,
                                      step = 1, animate=TRUE)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la Poisson a a normal"),
                                  tabsetPanel(tabPanel("Gráfica", plotOutput("Grafica2")),
                                              tabPanel("Teoría", includeHTML("teo2.html")))
                                  
                        )
                      )
             ),
             tabPanel("Aproximación 3",
                        sidebarLayout(
                          sidebarPanel(
                            h4('Ingrese los parámetros de la binomial'),
                            br(),
                            sliderInput("n2",
                                        "Número de ensayos n",
                                        min = 5,
                                        max = 100,
                                        value = 5,
                                        step = 1, animate=TRUE),
                            
                            sliderInput("p2",
                                        "Probabilidad de éxito p",
                                        min = 0,
                                        max = 1,
                                        value = 0.9,
                                        step = 0.01, animate=TRUE)
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(h2("Aproximación de la binomial a la poisson"),
                                    tabsetPanel(tabPanel("Gráfica", plotOutput("Grafica3")),
                                                tabPanel("Teoría", includeHTML("teo3.html"))
                                                )))
                        
                                                ),
             tabPanel("Aproximación 4",
                      sidebarLayout(
                        sidebarPanel(
                          h4('Ingrese los parámetros de la hipergeométrica'),
                          br(),
                          sliderInput("m4",
                                      "Número de éxitos en la población m",
                                      min = 1,
                                      max = 100,
                                      value = 10,
                                      step = 1, animate=TRUE),
                          sliderInput("n4",
                                      "Número de fracasos en la población n",
                                      min = 1,
                                      max = 100,
                                      value = 10,
                                      step = 1, animate=TRUE),
                          sliderInput("k4",
                                      "Tamaño de muestra k, recuerde que k 
                                      tiene que ser menor o igual que m + n",
                                      min = 1,
                                      max = 30,
                                      value = 7,
                                      step = 1, animate=TRUE)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la hipergeométrica a la binomial"),
                                  tabsetPanel(tabPanel("Gráfica", plotOutput("Grafica4")),
                                              tabPanel("Teoría", includeHTML("teo4.html"))
                                              )))
                      )
             
                   )
  
             ))