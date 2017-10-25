library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipótesis para la media &mu;"),
              windowTitle="Test_for_mu"),
  sidebarPanel(
    h5('Esta aplicación realiza la prueba de hipótesis para la 
       media de una variable cuantitativa.'),
    
    h6('La aplicación usa una base de datos de ejemplo pero el usuario
       puede cargar su propia base de datos.'),
    
    fileInput(inputId='file1',
              label='Use el siguiente botón para cargar su base de datos.',
              accept = c(
                'text/csv',
                'text/comma-separated-values',
                'text/tab-separated-values',
                'text/plain',
                '.csv',
                '.tsv'
              )),
    
    checkboxInput(inputId='header',
                  label='¿Tiene encabezado la base de datos?', 
                  value=TRUE),
    
    selectInput(inputId="sep",
                label = "¿Cuál es la sepación de los datos?", 
                choices = list(Tab='\t', Comma=',',
                               Semicolon=';', 'space'=' '),
                selected = ';'),
    
    selectInput(inputId="variable",
                label="Elija la variable cuantitativa para realizar
                la prueba de hipótesis.",
                choices=""),
    
    numericInput(inputId='mu0', 
                 label=HTML("Ingrese el valor de referencia
                            &mu;<sub>0</sub> para probar
                            H<sub>0</sub>: &mu; = &mu;<sub>0</sub>"), 
                 value=0),
    
    selectInput(inputId="h0", 
                label=HTML("Elija la hipótesis alternativa
                          < , &ne; o >"), 
                choices=list("Menor" = "less", 
                             "Differente" = "two.sided",
                             "Mayor" = "greater"),
                selected = "two.sided"),
    
    sliderInput(inputId='alfa',
                label=HTML("Opcional: elija un nivel de confianza para 
                construir el intervalo de confianza para la media &mu;"),
                min=0.90, max=0.99,
                value=0.95, step=0.01),
    
    img(src="logo.png", height = 60, width = 120),
    img(src="udea.png", height = 25, width = 70),
    br(),
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

),

mainPanel(
  tabsetPanel(type = "pills",
              
              tabPanel("Resultados",
                       h5('A continuación el histograma, densidad, QQplot
                          y valor-P para la prueba de normalidad
                          Shapiro-Wilk.'),
                       
                       plotOutput("appPlot",
                                  width='500px',
                                  height='300px'),
                       
                       h4("- Tabla de resumen con estadísticos muestrales:"),
                       tableOutput('statistic'),
                       
                       h4("- Resultados de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       
                       h4(HTML("- Intervalo de confianza para la media &mu;")),
                       textOutput("resul2")),
              
              tabPanel("Datos", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('inputData')),
              
              tabPanel("Teoría", includeHTML("include.html"))
              
  )
)
  
))




