library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribución uniforme continua"),

  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe
        lo que sucede con la densidad"),
      br(),
      sliderInput(inputId = "min",
                  label = "Valor mínimo",
                  min = -20,
                  max = 20,
                  value = 2,
                  step= 0.1,
                  animate = TRUE),
      sliderInput(inputId = "max",
                  label = "Valor máximo",
                  min = -20,
                  max = 20,
                  value = 5,
                  step= 0.1,
                  animate = TRUE),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/", 
             "https://srunal.github.io/")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución uniforme", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))
