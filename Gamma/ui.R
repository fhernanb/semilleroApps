library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribucion Gamma"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      HTML("Modifique los valores de los parametros y observe lo que sucede con la densidad.
        Recuerde que Escala = 1 / &lambda;"),
      br(),
      numericInput(inputId = "alpha",
                   label = HTML("Ingrese el valor de &alpha;:"),
                   min = 0.0001,
                   value = 0.7,
                   step= 0.1),
      numericInput(inputId = "lambda",
                   label = HTML("Ingrese el valor de &lambda;:"),
                   min = 0.0001,
                   value = 0.3,
                   step= 0.1),
      tags$br(),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el maximo valor de x para mostrar en el grafico:",
                  min = 1,
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
      h3("Densidad para la distribucion Gamma", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))