library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribucion Logistica"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parametros y observe lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "location",
                   label = HTML("Ingrese el valor de Location:"),
                   min = -Inf,
                   max = Inf,
                   value = 0.7,
                   step= 0.1),
      numericInput(inputId = "scale",
                   label = HTML("Ingrese el valor de Scale:"),
                   min = 0.1,
                   value = 0.3,
                   step= 0.1),
      numericInput(inputId = "distribuciones",
                   label = HTML("Ingrese el valor de Distribuciones:"),
                   min = 1,
                   value = 0.5,
                   step= 0.5),
      img(src="https://srunal.files.wordpress.com/2016/03/logotransparente1.png",
          height = 80, width = 150),
      br(),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribucion Logistica", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))