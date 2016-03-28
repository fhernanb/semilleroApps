library(shiny)
shinyUI(pageWithSidebar(
  headerPanel( "Graficos de resumen", "Flowserve"),
  sidebarPanel(
    h5('Esta aplicacion sirve para dibujar el histograma, la densidad, el qqplot y 
       boxplot para una de las variables de la base de datos ingresada por el 
       usuario, siga los pasos mostrados abajo.'),
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
    selectInput("product", "Seleccione la variable de la base de datos",""),
    
    img(src="https://srunal.files.wordpress.com/2016/03/logotransparente1.png",
        height = 80, width = 150)

    
  ),
  mainPanel(h4('A continuacion se muestran las primeras 3 observaciones de la base.'), 
            tableOutput('contents'), 
            tableOutput('summary'),
            h4('A continuacion los graficos para la variable seleccionada por 
               el usuario'),
            plotOutput("distPlot"))
  
))