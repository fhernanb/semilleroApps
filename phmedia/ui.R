library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(HTML("Prueba de hipotesis para la media &mu;"),
              windowTitle="PH media"),
  sidebarPanel(
    h5('Esta aplicacion sirve para realizar prueba de hipotesis 
        para la media de una variable cuantitativa. Ingrese la 
       informacion solicitada abajo.'),
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
    selectInput("sep", label = h5("Cual es la separacion interna de los
                 datos en la su base de datos?"), 
                choices = list(Tab='\t', Comma=',', Semicolon=';'),
                selected = ','),
    
    selectInput("variable", "Seleccione la variable de interes de la base 
                de datos",""),
    tags$hr(),
    
    numericInput(inputId='mu0', 
                 label=HTML("Ingrese el valor de referencia 
                            &mu;<sub>0</sub> para la prueba:"), 
                 value=0),
    
    selectInput("h0", label = "Elija la hipotesis alterna", 
                choices = list("<" = 1, 
                               "diferente" = 2,
                               ">" = 3),
                selected = 2),
    
    sliderInput(inputId='alfa', 
                label=h5('Opcional: elija el nivel de significancia
                          para reportar el intervalo de confianza'),
                min=0.90, max=0.99,
                value=0.95, step=0.01),
    
    img(src="logo.png", height = 60, width = 150),
    br(),
    
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

),
  mainPanel(

    fluidRow(
      
      column(6,
             h4('A continuacion se muestran las primeras 2 observaciones de 
                la base ingresada.'), 
             tableOutput('summary'),
             h4('A continuacion se presenta el histograma, densidad y qqplot 
                para la variable seleccionada.'),
             plotOutput("distPlot")
             ),
      
      column(6,
             h4("A continuacion la tabla con las estadisticas de resumen:"),
             tableOutput('statistic'),
             "Hola, esto es una prueba. El valor de referencia de la prueba es ",
             "Mensaje despedida"
             )
      
  
             )
    
    )
  
))




