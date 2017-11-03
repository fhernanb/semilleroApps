library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Weibull"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Modifique los valores de los parámetros y 
            observe lo que sucede con la densidad."),
      br(),
      br(),
      numericInput(inputId = "shape",
                   label = HTML("Ingrese el valor del parámetro shape:"),
                   min = 0.001,
                   value = 1.7,
                   step= 0.1),
      numericInput(inputId = "scale",
                   label = HTML("Ingrese el valor del parámetro scale:"),
                   min = 0.001,
                   value = 1.5,
                   step= 0.1),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el máximo valor de x para
                  mostrar en el gráfico:",
                  min = 1,
                  max = 30,
                  value = 9,
                  step = 1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Weibull", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))