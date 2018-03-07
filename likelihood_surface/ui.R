library(shiny)
library(plotly)
library(knitr)


# Define UI for random distribution application 
fluidPage(
  
  # Application title
  titlePanel("Superficie de log-verosimilitud"),
  
  sidebarLayout(
    sidebarPanel(
      h5('Esta aplicación sirve para dibujar la superficie de 
         log-verosimilitud asociada a una distribución de 2 parámetros
         dados los valores de una variable ingresados por el usuario.'),
      br(),
      fileInput('file1', 'Use el siguiente botón para ingresar su base de datos.',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      checkboxInput('header', 'Marque la casilla si su base de datos tiene
                    ENCABEZADO (header)', TRUE),
      radioButtons('sep', '¿Cuál es símbolo de separación dentro de su base datos?',
                   c(Tab='\t', Comma=',', Semicolon=';' )
      ),
      tags$hr(),
      selectInput("product", "Seleccione la variable para la cual quiere
                  dibujar la superficie de log-verosimilitud",""),
      selectInput(inputId="Distribucion",
                  label="Elija una distribución de dos parámetros:",
                  choices=c("Normal", "Weibull", "Gamma"),
                  selected="Normal"),
      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      img(src="https://fhernanb.github.io/docs/logo.png", height = 56, width = 136),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "pills", 
                  tabPanel("Superficie", plotlyOutput("distPlot",
                                                      width="800px",
                                                      height="600px")), 
                  tabPanel("Teoría", uiOutput('lateoria'))
      )
    )
  )
)