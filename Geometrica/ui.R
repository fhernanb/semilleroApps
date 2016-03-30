library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribucion geometrica"),

  sidebarLayout(
    sidebarPanel(
      p("Modifique el valor del parametro y observe lo que sucede en el grafico."),
      br(),
      sliderInput(inputId = "p",
                  label = "Probabilidad de exito p:",
                  min = 0,
                  max = 1,
                  value = 0.4,
                  step= 0.1),
      tags$br(),
      tags$br(),
      tags$hr(),
      numericInput(inputId = "x",
                  label = "Ingrese el maximo valor de x para el cual desea ver las probabilidades:",
                  min = 1,
                  max = 30,
                  value = 20,
                  step = 1),
      img(src="logo.png", height = 60, width = 150),
      br(),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Diagrama de barras para las probabilidades", align = "center"),
      plotOutput("grafico1")
    )
  )
))
