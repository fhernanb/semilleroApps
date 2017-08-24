library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Distribución Poisson"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe lo que sucede en el grafico."),
      br(),
      sliderInput(inputId = "l",
                  label = HTML("Media &lambda;:"),
                  min = 0,
                  max = 40,
                  value = 5,
                  step= 1,
                  animate = TRUE),
      tags$hr(),
      numericInput(inputId = "n",
                  label = "Ingrese el maximo valor de x para el cual desea ver las probabilidades:",
                  min = 10,
                  max = 500,
                  value = 20,
                  step= 1),
      br(),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1")
    )
  )
))
