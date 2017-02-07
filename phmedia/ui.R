library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(HTML("Prueba de hipotesis para la media &mu;"),
              windowTitle="PH media"),
  sidebarPanel(
    h5('Esta aplicacion sirve para realizar prueba de hipotesis 
        para la media de una variable cuantitativa. Ingrese la 
       informacion solicitada abajo.'),
    
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
    checkboxInput(inputId='header',
                  label='Tiene encabezado la base de datos?', 
                  value=TRUE),
    
    selectInput("sep", label = "Cual es la separacion interna de los
                 datos en la su base de datos?", 
                choices = list(Tab='\t', Comma=',', Semicolon=';'),
                selected = ','),
    
    selectInput("variable", "Seleccione la variable de interes de la base 
                de datos",""),
    
    numericInput(inputId='mu0', 
                 label=HTML("Ingrese el valor de referencia 
                            &mu;<sub>0</sub> para la probar
                            H<sub>0</sub>: &mu; = &mu;<sub>0</sub>"), 
                 value=0),
    
    selectInput("h0", 
                label = HTML("Elija el tipo de hipotesis alterna
                          < , &ne; o >"), 
                choices = list("Menor" = "less", 
                               "Diferente" = "two.sided",
                               "Mayor" = "greater"),
                selected = "two.sided"),
    
    sliderInput(inputId='alfa', 
                label='Opcional: elija el nivel de significancia
                reportar el intervalo de confianza',
                min=0.90, max=0.99,
                value=0.95, step=0.01),
    
    img(src="logo.png", height = 60, width = 150),
    br(),
    
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

),

mainPanel(
  tabsetPanel(type = "pills",
              
              tabPanel("Resultados",
                       h4('A continuacion se presenta el histograma, la densidad, qqplot 
                y valor P de la prueba de normalidad Shapiro para analizar
                el cumplimiento del supuesto de normalidad para la variable de
                interes.'),
                       plotOutput("distPlot"),
                       h4("Tabla con las estadisticas de resumen:"),
                       tableOutput('statistic'),
                       h4("- Resultado de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       h4(HTML("- Intervalo de confianza para la media &mu;")),
                       textOutput("resul2")),
              
              tabPanel("Base de datos", 
                       "A continuacion la base de datos ingresada por el usuario.",
                       uiOutput('summary')),
              
              tabPanel("Teoria 1", includeMarkdown("include.md")),
              tabPanel("Teoria 2", uiOutput('miteoria'))
              
  )
)
  
))




