
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribucion Gamma aumentada con ceros"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parametros y observe lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "mu",
                  label = HTML("Ingrese el valor de &mu;:"),
                  min = 0.1,
                  value = 0.7,
                  step= 0.1),
      numericInput(inputId = "sigma",
                  label = HTML("Ingrese el valor de &sigma;:"),
                  min = 0.1,
                  value = 0.3,
                  step= 0.1),
      sliderInput(inputId = "nu",
                  label = HTML("Ingrese el valor de &nu;:"),
                  min = 0.01,
                  max = 0.99,
                  value = 0.2,
                  step = 0.01),
      tags$br(),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el maximo valor de x para mostrar en el grafico:",
                  min = 5,
                  max = 20,
                  value = 5,
                  step = 1),

      img(src="logo.png", height = 60, width = 150),
      br(),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribucion ZAGA", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))
