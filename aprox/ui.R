library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  
  # Application title
  
  titlePanel("Aproximación de distribuciones"),
  
  navbarPage(" ",
             tabPanel("Introducción",
                      sidebarLayout(
                        sidebarPanel(h3("Objetivo:"),
                                     h5("Esta aplicación muestra gráficamente la aproximación 
                                        de una distribución candidata a otra distribución 
                                        a medida que se modifican los parámetros
                                        de la distribución candidata."),
                                     h5("En las pestañas de la parte superior están las diferentes aproximaciones."),
                                     br(),
                                     p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
                                     img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
                                         height = 56, width = 140),
                                     tags$a(href="https://srunal.github.io", "https://srunal.github.io")),
                        
                        mainPanel(
                          h2("Casos"),
                          h4("Aproximación 1, de la binomial a la normal"),
                          h4("Aproximación 2, de la Poisson a la normal"),
                          h4("Aproximación 3, de la binomial a la Poisson"),
                          h4("Aproximación 4, de la hipergeométrica a la binomial")
                          
                          
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
                                      step = 0.01, animate=TRUE),
                          p("Nota: puede dar clic en el triángulo para obtener una animación.")
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
                          h4('Ingrese el parámetro de la Poisson'),
                          br(),
                          sliderInput("l",
                                      HTML("Tasa promedio &lambda;"),
                                      min = 1,
                                      max = 200,
                                      value = 2,
                                      step = 1, animate=TRUE),
                          p("Nota: puede dar clic en el triángulo para obtener una animación.")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la Poisson a la normal"),
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
                                        max = 150,
                                        value = 5,
                                        step = 1, animate=TRUE),
                            
                            sliderInput("p2",
                                        "Probabilidad de éxito p",
                                        min = 0,
                                        max = 1,
                                        value = 0.9,
                                        step = 0.01, animate=TRUE),
                            p("Nota: puede dar clic en el triángulo para obtener una animación.")
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(h2("Aproximación de la binomial a la Poisson"),
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
                                      value = 50,
                                      step = 1, animate=TRUE),
                          sliderInput("n4",
                                      "Número de fracasos en la población n",
                                      min = 1,
                                      max = 100,
                                      value = 50,
                                      step = 1, animate=TRUE),
                          sliderInput("k4",
                                      "Tamaño de muestra k, recuerde que k 
                                      tiene que ser menor o igual que m + n",
                                      min = 1,
                                      max = 50,
                                      value = 40,
                                      step = 1, animate=TRUE),
                          p("Nota: puede dar clic en el triángulo para obtener una animación.")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(h2("Aproximación de la hipergeométrica a la binomial"),
                                  tabsetPanel(tabPanel("Gráfica", plotOutput("Grafica4")),
                                              tabPanel("Teoría", includeHTML("teo4.html"))
                                              )))
                      )
             
                   )
  
             ))