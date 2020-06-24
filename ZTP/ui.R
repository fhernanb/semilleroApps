  library(shiny)

  shinyUI(fluidPage(
  # Application title
  titlePanel("Distribución Zero Truncated Poisson"),

  sidebarLayout(
  sidebarPanel(
    p("Modifique los valores de los parámetros y 
      observe lo que sucede en el gráfico."),
    br(),
  sliderInput("lambda", HTML("Media de la Poisson, &lambda;:"),
              min = 0,
              max = 15,
              step= 0.5,
              value = 5,
              animate = TRUE),
numericInput("xmax",
            "Ingrese el máximo valor de x para el cual desea ver las probabilidades:",
            min = 5,
            max = 50,
            step= 1,
            value = 15),
br(),
p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
tags$a(href="https://srunal.github.io/", "https://srunal.github.io/")
 ),
 # Show a plot of the generated distribution
 mainPanel(
 plotOutput("distPlot")
 )
 )
))
