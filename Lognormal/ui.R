library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución log-normal"),
  
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe 
        lo que sucede con la densidad."),
      br(),
      sliderInput(inputId = "mu",
                  label = HTML("Ingrese el valor de &mu; (meanlog):"),
                  min = 0,
                  max = 30,
                  value = 0.7,
                  step= 0.1,
                  animate =TRUE),
      sliderInput(inputId = "sigma",
                  label = HTML("Ingrese el valor de &sigma; (sdlog): "),
                  min = 0.1,
                  max = 30,
                  value = 0.3,
                  step= 0.1,
                  animate =TRUE),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/", 
             "https://srunal.github.io/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución log-normal", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))