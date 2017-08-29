library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Logística"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe 
        lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "location",
                   label = p("Ingrese el valor de Location:"),
                   min = -Inf,
                   max = Inf,
                   value = 0.7,
                   step= 0.1),
      numericInput(inputId = "scale",
                   label = p("Ingrese el valor de Scale:"),
                   min = 0.1,
                   value = 0.3,
                   step= 0.1),
      numericInput(inputId = "distribuciones",
                   label = p("Ingrese el valor de desviaciones estándar
                             para modificar el rango horizontal:"),
                   min = 1,
                   value = 0.5,
                   step= 0.5),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Logística", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))