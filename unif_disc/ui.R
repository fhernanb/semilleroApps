library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribución uniforme"),

  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe
        lo que sucede en el diagrama"),
      br(),
      sliderInput(inputId = "min",
                  label = "Valor mínimo",
                  min = -20,
                  max = 20,
                  value = 2,
                  step= 1,
                  animate = TRUE),
      sliderInput(inputId = "max",
                  label = "Valor máximo",
                  min = -20,
                  max = 20,
                  value = 5,
                  step= 1,
                  animate = TRUE),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/", 
             "https://srunal.github.io/")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1")
    )
  )
))
