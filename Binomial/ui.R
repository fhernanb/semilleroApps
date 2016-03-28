library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Distribucion binomial"),

  sidebarLayout(
    sidebarPanel(
     p("Modifique los valores de los parametros y observe lo que sucede en el grafico."),
     br(),
      sliderInput(inputId = "p",
                  label = "Probabilidad de exito p:",
                  min = 0,
                  max = 1,
                  value = 0.4,
                  step= 0.1),
      sliderInput(inputId = "n",
                  label = "Tamano de la muestra n:",
                  min = 1,
                  max = 30,
                  value = 9,
                  step = 1),

     img(src="https://srunal.files.wordpress.com/2016/03/logotransparente1.png",
         height = 80, width = 150),
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
