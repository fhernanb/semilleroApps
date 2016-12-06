library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Curva de log-verosimilitud", "Flowserve"),
  sidebarPanel(
    h5('Esta aplicacion sirve para dibujar la superficie de 
       log-verosimilitud dados los valores de una variable.'),
    br(),
    fileInput('file1', 'Use el boton siguiente para cargar la base de datos.',
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
                choices=c("Normal", "Weibull", "chi.cuadrada"),
                selected="Normal"),
    img(src="logo.png", height = 56, width = 136),
    br(),
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

    
  ),
  mainPanel(h4('A continuacion se presenta la superficie de log-verosimilitud'),
            plotlyOutput("distPlot"))
  
))