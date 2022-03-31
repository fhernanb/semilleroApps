library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Logística"),
  
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe 
        lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "location",
                  label = p("Ingrese el valor del parámetro Location:"),
                  min = -Inf,
                  max = Inf,
                  value = 0.7,
                  step= 0.1),
      sliderInput(inputId = "scale",
                  label = p("Ingrese el valor del parámetro Scale:"),
                  min = 0.1,
                  max = 10,
                  value = 0.3,
                  step= 0.1,
                  animate = TRUE),
      numericInput(inputId = "distribuciones",
                   label = p("Ingrese el valor de desviaciones estándar
                             para modificar el rango horizontal:"),
                   min = 1,
                   value = 0.5,
                   step= 0.5),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/", 
             "https://srunal.github.io/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Logística", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))