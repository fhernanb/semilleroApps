
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Conway Maxwell Poisson"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y 
        observe lo que sucede en el diagrama."),
      br(),
      sliderInput(inputId = "lambda",
                  label = HTML("&lambda;:"),
                  min = 0,
                  max = 20,
                  value = 3.0,
                  step= 0.1,
                  animate = TRUE),
      sliderInput(inputId = "nu",
                  label = HTML("&nu;:"),
                  min = 0,
                  max = 20,
                  value = 1.1,
                  step = 0.1,
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
