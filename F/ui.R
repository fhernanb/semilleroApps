library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distribución F"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Modifique los valores de los parámetros y 
            observe lo que sucede con la densidad."),
      br(),
      br(),
      sliderInput(inputId = "df1",
                  label = HTML("Ingrese el valor del parámetro shape:"),
                  min = 1,
                  max = 30,
                  value = 5,
                  step= 1,
                  animate = TRUE),
      sliderInput(inputId = "df2",
                  label = HTML("Ingrese el valor del parámetro scale:"),
                  min = 1,
                  max = 30,
                  value = 3,
                  step= 1,
                  animate = TRUE),
      sliderInput(inputId = "x.max",
                  label = "Ingrese el máximo valor de x para
                  mostrar en el gráfico:",
                  min = 1,
                  max = 30,
                  value = 9,
                  step = 1),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/",
             "https://srunal.github.io/")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Densidad para la distribución F", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))