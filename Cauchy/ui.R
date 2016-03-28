library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribucion Cauchy"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parametros y observe lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "mu",
                  label = HTML("Ingrese el valor de &mu;:"),
                  min = -10,
                  value = 0,
                  step= 0.1),
      sliderInput(inputId = "sigma",
                  label = HTML("Ingrese el valor de &sigma;:"),
                  min = 0.01,
                  max = 10,
                  value = 1,
                  step= 0.01),
      tags$br(),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el maximo valor de x para mostrar alrededoral parametro de localizacion:",
                  min = 0.01,
                  max = 100,
                  value = 5,
                  step = 0.1),

      img(src="https://srunal.files.wordpress.com/2016/03/logotransparente1.png",
          height = 80, width = 150),
      br(),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribucion Cauchy", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))