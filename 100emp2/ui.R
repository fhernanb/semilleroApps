library(shiny)
source("auxiliar.R")

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Indicadores financieros - Sector comercio al por menor"),
  
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
      checkboxGroupInput(inputId="covariables",
                         label="Por defecto la app tiene 3 variables seleccionadas,
                         usted puede marcar las casillas para agregar o quitar
                         variables y así iniciar el proceso de selección.",
                         choices=c('activos', 'pasivos', 'patrimonio'))
    ),
    
    # Show the results
    mainPanel(
      tabsetPanel(type = "pills",
                  tabPanel("Figuras", 
                           plotOutput("plot1", width='500px'),
                           plotOutput("plot2", width='500px')),
                  tabPanel("Resultados",
                           h4("Tabla de resumen del modelo:"),
                           h5("La aplicación ajustó un modelo de regresión y
                              seleccionó las variables que más aportan para
                              explicar los ingresos."),
                           verbatimTextOutput("regresion")),
                  tabPanel("Ecuación",
                           h4("Los ingresos estimados para una empresa
                              están dados por la siguiente ecuación:"),
                           uiOutput("ecuacion1")),
                  tabPanel("Datos", "A continuación los datos que está usando 
                        la aplicación.",
                           uiOutput('inputData'))

    )
  )
  
  )
))
