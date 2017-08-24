library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribución binomial"),

  sidebarLayout(
    sidebarPanel(
     p("Modifique los valores de los parámetros y observe lo 
       que sucede en el gráfico."),
     br(),
      sliderInput(inputId = "p",
                  label = "Probabilidad de éxito p:",
                  min = 0,
                  max = 1,
                  value = 0.4,
                  step= 0.1,
                  animate = TRUE),
      sliderInput(inputId = "n",
                  label = "Tamaño de la muestra n:",
                  min = 1,
                  max = 30,
                  value = 9,
                  step = 1,
                  animate = TRUE),
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
