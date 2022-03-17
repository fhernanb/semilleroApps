
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Binomial Negativa - Versión 2"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      HTML("En esta parametrización de la Binomial Negativa 
        el parámetro &mu; representa la media y 
        k representa el parámetro de precisión"),
      br(),
      p("Modifique los valores de los parámetros y 
        observe lo que sucede en el diagrama."),
      br(),
      sliderInput(inputId = "mu",
                  label = HTML("Media &mu;:"),
                  min = 0,
                  max = 50,
                  value = 2.5,
                  step= 0.1,
                  animate = TRUE),
      sliderInput(inputId = "k",
                  label = "Valor de k:",
                  min = 1,
                  max = 100,
                  value = 5,
                  step = 0.5,
                  animate = TRUE),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el máximo valor de x para el cual desea 
                  ver las probabilidades:",
                  min = 1,
                  max = 50,
                  value = 30,
                  step = 1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))
