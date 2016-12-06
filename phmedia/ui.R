library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Prueba de hipotesis para la media", "Flowserve"),
  sidebarPanel(
    h5('Esta aplicacion sirve para realizar la prueba de hipotesis para la media de
       una variable cuantitativa. Ingrese la informacion solicitada abajo.'),
    br(),
    fileInput('file1', 'Use el boton siguiente para cargar su base de datos.',
              accept = c(
                'text/csv',
                'text/comma-separated-values',
                'text/tab-separated-values',
                'text/plain',
                '.csv',
                '.tsv'
              )
    ),
    checkboxInput('header', 'Tiene encabezado la base de datos?', TRUE),
    radioButtons('sep', 'Cual es la separacion de sus datos?',
                 c(Tab='\t', Comma=',', Semicolon=';' )
    ),
    tags$hr(),
    selectInput("product", "Seleccione la variable de interes de la base de datos",""),
    tags$hr(),
    
    numericInput(inputId='alfa', label='Elija el nivel de significancia', 
                 value=0.05, min=0.01, 
                 step=0.01, max=0.10),
    
    numericInput(inputId='mu0', label='Ingrese el ', 
                 value=0.05, min=0.01, 
                 step=0.01, max=0.10),
    
    selectInput("h0", label = h5("Elija la hipotesis alterna"), 
                choices = list("<" = 1, 
                               "diferente" = 2,
                               ">" = 3),
                selected = 2),
    
    img(src="logo.png", height = 60, width = 150),
    br(),
    
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

    
  ),
  mainPanel(h4('A continuacion se muestran las primeras 3 observaciones de la base.'), 
            tableOutput('contents'), 
            tableOutput('summary'),
            h4('A continuacion los graficos para la variable seleccionada por 
               el usuario'),
            plotOutput("distPlot"))
  
))