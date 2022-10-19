library(shiny)
source("auxiliar.R")
source("model_select.R")

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Indicadores financieros"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      img(src="emp.png", height = 120, width = 220,  align = "middle"),
      h5('Esta aplicación crea un modelo de regresión para
         explicar los ingresos de las empresas en función de las variables
         que usted seleccione. El procedimiento usa como
         criterio el BIC (Bayesian Information Criterion) para penalizar
         el exceso de covariables en el modelo.'),
      br(),
      selectInput(inputId="sector", label="Seleccione el Sector.", 
                  choices=sectores),
      br(),
      checkboxGroupInput(inputId="covariables", label=""),
      br(),
      selectInput(inputId="dist", 
                  label="Seleccione una posible distribución para Y", 
                  choices=c("NO","GA","WEI","EXP"),
                  selected="GA"),
      p("Olga Cecilia Usuga Manco     - UdeA"),
      p("Gloria Lucía Ramírez Córdoba - UdeA"),
      p("Freddy Hernández Barajas     - UNAL")
    ),
    
    # Show the results
    mainPanel(
      tabsetPanel(type = "pills",
                  tabPanel("Análisis exploratorio", 
                           plotOutput("plot1", width='500px'),
                           plotOutput("plot2", width='500px')),
                  tabPanel("Regresión lineal",
                           h4("Tabla de resumen del modelo:"),
                           h5("La aplicación ajustó un modelo de regresión y
                              seleccionó las variables que más aportan para
                              explicar los ingresos."),
                           verbatimTextOutput("regresion")),
                  tabPanel("Modelo estimado",
                           h4("Los ingresos estimados para una empresa
                              están dados por la siguiente ecuación:"),
                           uiOutput("ecuacion1")),
                  tabPanel("Árbol distribucional",
                           plotOutput("tree", width='500px')),
                  tabPanel("Datos", 
                           h4("A continuación los datos que está usando 
                              la aplicación."),
                           uiOutput('inputData'))

    )
  )
  
  )
))
