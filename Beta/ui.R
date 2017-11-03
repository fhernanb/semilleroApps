library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución Beta"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Modifique los valores de los parámetros y 
            observe lo que sucede con la densidad."),
      br(),
      br(),
      numericInput(inputId = "shape1",
                   label = HTML("Ingrese el valor del parámetro shape1:"),
                   min = 0.001,
                   value = 1.7,
                   step= 0.1),
      numericInput(inputId = "shape2",
                   label = HTML("Ingrese el valor del parámetro shape2:"),
                   min = 0.001,
                   value = 1.5,
                   step= 0.1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución Beta", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))