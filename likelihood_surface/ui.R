
library(shiny)
library(plotly)
library(knitr)


# Define UI for random distribution application 
fluidPage(
  
  # Application title
  titlePanel("Superficie de log-verosimilitud"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      h5('Esta aplicacion sirve para dibujar la superficie de 
         log-verosimilitud asociada a una distribucion de 2 parametros
         dados los valores de una variable ingresados por el usuario.'),
      br(),
      fileInput('file1', 'Use el siguiente boton para cargar la base de datos.',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      checkboxInput('header', 'Tiene su base de datos ENCABEZADO (header)?', TRUE),
      radioButtons('sep', 'Cual es la separacion de sus datos?',
                   c(Tab='\t', Comma=',', Semicolon=';' )
      ),
      tags$hr(),
      selectInput("product", "Seleccione la variable para la cual quiere
                  dibujar la superficie de log-verosimilitud",""),
      selectInput(inputId="Distribucion",
                  label="Elija una distribucion de dos parametros:",
                  choices=c("Normal", "Weibull", "Gamma"),
                  selected="Normal"),
      img(src="logo.png", height = 56, width = 136),
      br(),
      tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
      ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "pills", 
                  tabPanel("Superficie", plotlyOutput("distPlot",
                                                      width="800px",
                                                      height="600px")), 
                  tabPanel("Teoria", uiOutput('markdown')), 
                  tabPanel("Preguntas", tableOutput("table"))
      )
    )
  )
)