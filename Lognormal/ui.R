library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución log-normal"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modifique los valores de los parámetros y observe 
        lo que sucede con la densidad."),
      br(),
      numericInput(inputId = "mu",
                   label = HTML("Ingrese el valor de &mu; (meanlog):"),
                   min = 0,
                   value = 0.7,
                   step= 0.1),
      numericInput(inputId = "sigma",
                   label = HTML("Ingrese el valor de &sigma; (sdlog): "),
                   min = 0.1,
                   value = 0.3,
                   step= 0.1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución log-normal", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('github')
    )
  )
))