library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Función de masa de probabilidad"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Ingrese la función de masa y los valores
           mínimo y máximo que X puede tomar. La variable X
           debe tomar valores de uno en uno, comenzando en
           el mínimo y terminando en el máximo."),
      br(),
      br(),
      textInput("pmf",
                "Ingrese la fórmula de la función de masa en forma apropiada
                usando los operadores +, -, * y /. Vea el ejemplo abajo. 
                No deje espacios en la fórmula de f(x).", 
                "f(x)=(2*x+1)/25"),
      numericInput(inputId = "min",
                   label = HTML("Ingrese el valor mínimo de X. Si el
                                valor mínimo es -Inf escriba -999"),
                   value = 0),
      numericInput(inputId = "max",
                   label = HTML("Ingrese el valor máximo de X. Si el
                                valor máximo es Inf escriba 999"),
                   value = 4),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot
    mainPanel(
      h3("Distribución de probabilidad para f(x)", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))