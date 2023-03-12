library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Dibujo de una función de densidad"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Ingrese la función de densidad y los valores
           mínimo y máximo que ella puede tomar."),
      br(),
      br(),
      textInput("fdp",
                "Ingrese la fórmula de la densidad en forma apropiada
                usando los operadores +, -, * y /. Vea el ejemplo abajo.", 
                "f(x)=3*x^2"),
      numericInput(inputId = "min",
                   label = HTML("Ingrese el valor mínimo de X. Si el
                                valor mínimo es -Inf escriba -999"),
                   value = 0),
      numericInput(inputId = "max",
                   label = HTML("Ingrese el valor máximo de X. Si el
                                valor máximo es Inf escriba 999"),
                   value = 1),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot
    mainPanel(
      h3("Densidad para la distribución ingresada", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))