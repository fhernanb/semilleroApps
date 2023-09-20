library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Función de masa de probabilidad"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Ingrese la función de masa f(x) y los valores
           mínimo y máximo que la v.a. X puede tomar. Los valores de X
           deben ser de uno en uno, comenzando en
           el mínimo y terminando en el máximo."),
      br(),
      br(),
      textInput("pmf",
                "Ingrese la fórmula de la función de masa en forma apropiada
                usando los operadores +, -, * y /. Vea el ejemplo abajo.", 
                "f(x)=(2*x+1)/25"),
      numericInput(inputId = "min",
                   label = HTML("Ingrese el valor mínimo de X. Si el
                                valor mínimo es -&#8734, escriba un 
                                número negativo grande."),
                   value = 0),
      numericInput(inputId = "max",
                   label = HTML("Ingrese el valor máximo de X. Si el
                                valor máximo es &#8734, escriba un 
                                número positivo grande."),
                   value = 4),
      br(),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot
    mainPanel(
      h3("", align = "center"),
      plotOutput("grafico1", width = "100%", height = "300px"),
      verbatimTextOutput("med_var"),
      h5("Tabla con f(x) y F(x) para la v.a."),
      tableOutput("tabla_probs")
    )
  )
))