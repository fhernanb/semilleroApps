  library(shiny)
  shinyUI(fluidPage(
  # Application title
  titlePanel("Distribucion ZIP"),

  sidebarLayout(
  sidebarPanel(
    p("Modifique los valores de los parametros y observe lo que sucede en el grafico."),
    br(),
  sliderInput("mu", HTML("Media de la Poisson, &lambda;:"),
              min = 0,
              max = 15,
              step= 1,
              value = 5),
sliderInput("Prop",
            "Porcentaje de la distribucion concentrada en cero:",
            min = 0.0001,
            max = .9999,
            step=0.1,
            value = 0.5),
tags$br(),
tags$br(),
tags$hr(),
numericInput("xmax",
            "Ingrese el maximo valor de x para el cual desea ver las probabilidades:",
            min = 5,
            max = 50,
            step= 1,
            value = 15),

img(src="logo.png", height = 60, width = 150),
br(),
br(),
p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
 ),
 # Show a plot of the generated distribution
 mainPanel(
 plotOutput("distPlot")
 )
 )
))
