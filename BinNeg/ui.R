
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Binomial Negativa"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y 
        observe lo que sucede en el diagrama"),
      br(),
      sliderInput(inputId = "p",
                  label = "Probabilidad individual de éxito p:",
                  min = 0,
                  max = 1,
                  value = 0.6,
                  step= 0.1,
                  animate = TRUE),
      sliderInput(inputId = "exitos",
                  label = "Número de éxitos",
                  min = 1,
                  max = 30,
                  value = 5,
                  step = 1,
                  animate = TRUE),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el máximo valor de x para el cual desea 
                  ver las probabilidades:",
                  min = 1,
                  max = 50,
                  value = 15,
                  step = 1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io",
             "https://srunal.github.io")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))
