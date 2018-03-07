library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribución geométrica"),

  sidebarLayout(
    sidebarPanel(
      p("Modifique el valor del parámetro y observe 
        lo que sucede en el diagrama"),
      br(),
      sliderInput(inputId = "p",
                  label = "Probabilidad de éxito p:",
                  min = 0,
                  max = 1,
                  value = 0.1,
                  step= 0.1,
                  animate = TRUE),
      numericInput(inputId = "x",
                  label = "Ingrese el máximo valor de x para el cual desea 
                  ver las probabilidades:",
                  min = 1,
                  max = 30,
                  value = 20,
                  step = 1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1")
    )
  )
))
