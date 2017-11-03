library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Normal"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Modifique los valores de los parámetros y 
            observe lo que sucede con la densidad."),
      br(),
      br(),
      numericInput(inputId = "media",
                   label = HTML("Ingrese el valor de la media:"),
                   min = -5000,
                   max = 5000,
                   value = 1.5,
                   step= 0.1),
      numericInput(inputId = "desvi",
                   label = HTML("Ingrese el valor de la desviación:"),
                   min = 0.001,
                   value = 1.5,
                   step= 0.1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Normal", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))