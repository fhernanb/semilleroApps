library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Prueba de hipótesis para la media", "Flowserve"),
  sidebarPanel(
    h5('Esta aplicacion sirve para realizar la prueba de hipótesis para la media de
       una variable cuantitativa. Ingrese la información solicitada abajo.'),
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
    checkboxInput('header', 'Tiene encabezado la base de datos?', TRUE),
    radioButtons('sep', 'Cual es la separacion de sus datos?',
                 c(Tab='\t', Comma=',', Semicolon=';' )
    ),
    tags$hr(),
    selectInput("product", "Seleccione la variable de interés de la base de datos",""),
    tags$hr(),
    
    numericInput(inputId='alfa', label='Elija el nivel de significancia', 
                 value=0.05, min=0.01, 
                 step=0.01, max=0.10),
    
    numericInput(inputId='mu0', label='Ingrese el ', 
                 value=0.05, min=0.01, 
                 step=0.01, max=0.10),
    
    selectInput("h0", label = h5("Elija la hipótesis alterna"), 
                choices = list("Choice 1" = 1, 
                               "Choice 2" = 2,
                               "Choice 3" = 3),
                selected = 1),
    
    img(src="udea.png", height = 72, width = 64),
    img(src="logo.png", height = 56, width = 136),
    
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

    
  ),
  mainPanel(h4('A continuacion se muestran las primeras 3 observaciones de la base.'), 
            tableOutput('contents'), 
            tableOutput('summary'),
            h4('A continuacion los graficos para la variable seleccionada por 
               el usuario'),
            plotOutput("distPlot"))
  
))