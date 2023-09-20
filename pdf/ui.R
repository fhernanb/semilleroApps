library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Función de densidad de probabilidad"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Ingrese la función de densidad f(x) y los valores
           mínimo y máximo que la v.a. X puede tomar."),
      br(),
      br(),
      textInput("pdf",
                "Ingrese la fórmula de la densidad en forma apropiada
                usando los operadores +, -, * y /. Vea el ejemplo abajo.", 
                "f(x)=(-2*x+3)/2"),
      numericInput(inputId = "min",
                   label = HTML("Ingrese el valor mínimo de X. Si el
                                valor mínimo es -&#8734, escriba un 
                                número negativo grande."),
                   value = 0, step=0.01),
      numericInput(inputId = "max",
                   label = HTML("Ingrese el valor máximo de X. Si el
                                valor máximo es &#8734, escriba un 
                                número positivo grande."),
                   value = 1, step=0.01),
      numericInput(inputId = "cuantil",
                   label = HTML("Ingrese el valor de x para el cual desea
                                calcular P(X &#8804; x)"),
                   value = 0.75, step=0.01),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot
    mainPanel(
      h3("", align = "center"),
      plotOutput("grafico1", width = "100%", height = "300px"),
      verbatimTextOutput('med_var'),
      verbatimTextOutput('prob_hasta_cuantil')
    )
  )
))