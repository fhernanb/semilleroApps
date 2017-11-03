library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Cauchy"),
  
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y 
        observe lo que sucede con la densidad."),
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
                  step= 0.01, animate = TRUE),
      tags$br(),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el máximo valor de x para mostrar
                  alrededoral parámetro de localización:",
                  min = 0.01,
                  max = 100,
                  value = 5,
                  step = 0.1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Cauchy", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))