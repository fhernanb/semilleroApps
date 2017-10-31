library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipótesis para el cociente de 
                         varianzas &sigma;<sup>2</sup><sub>1</sub> / 
                         &sigma;<sup>2</sup><sub>2</sub>"),
  windowTitle="PH coc varianzas"),
        
  sidebarPanel(
    h5('Esta aplicación sirve para realizar prueba de hipotesis 
        para el cociente de varianzas de variables cuantitativas.'),
    
    h6('La aplicación usa una base de datos de ejemplo pero el usuario
       puede cargar su propia base de datos.'),

    fileInput(inputId='file1',
              label='Use el botón siguiente para cargar su base de datos.',
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
    
    selectInput(inputId="variable1",
                label="Elija la variable cuantitativa para realizar
                la prueba de hipótesis.",
                choices=""),
    
    selectInput(inputId="variable2",
                label="Elija la variable cualitativa 
                de agrupacion, DEBE tener 2 niveles y ser un factor.",
                choices=""),

    selectInput(inputId="h0", 
                label=HTML("Elija el tipo de hipotesis alterna
                           < , &ne; o >"), 
                choices=list("Menor" = "less", 
                             "Diferente" = "two.sided",
                             "Mayor" = "greater"),
                selected = "two.sided"),
    
    sliderInput(inputId='alfa', 
                label=HTML("Opcional: elija un nivel de confianza para 
                           construir el intervalo de confianza para 
                           el cociente
                           &sigma;<sup>2</sup><sub>1</sub> / 
                         &sigma;<sup>2</sup><sub>2</sub>"),
                min=0.90, max=0.99,
                value=0.95, step=0.01),
                
    img(src="logo.png", height = 60, width = 120),
    img(src="udea.png", height = 25, width = 70),
    br(),
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
    
),
        
mainPanel(
  tabsetPanel(type = "pills",
              tabPanel(title="Resultados",
                       h5('A continuación el histograma, densidad, QQplot
                          y valor-P para la prueba de normalidad
                          Shapiro-Wilk de cada una de las
                          dos muestras.'),
                       plotOutput("appPlot",
                                  width='500px',
                                  height='300px'),
                       
                       h4("- Tabla de resumen con estadísticos muestrales:"),
                       tableOutput('statistic'),
                       
                       h4("- Resultados de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       
                       h4(HTML("- Intervalo de confianza para
                                el cociente
                               &sigma;<sup>2</sup><sub>1</sub> / 
                         &sigma;<sup>2</sup><sub>2</sub>")),
                       textOutput("resul2")),
              
              tabPanel("Datos", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('summary')),
              
              tabPanel("Teoría", includeHTML("include.html"))

  )
)

))
