library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipotesis para diferencia de medias 
                         &mu;<sub>1</sub> - &mu;<sub>2</sub>"),
              windowTitle="PH dif medias"),
  
  sidebarPanel(
    h5('Esta aplicación sirve para realizar prueba de hipotesis 
        para la diferencia de medias de variables cuantitativas.'),
    
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
    
    numericInput(inputId='delta0', 
                 label=HTML("Ingrese el valor de referencia 
                            &Delta;<sub>0</sub> para la probar
                            H<sub>0</sub>: &mu;<sub>1</sub> 
                            - &mu;<sub>2</sub> = &Delta;<sub>0</sub>"), 
                 value=0),
    
    selectInput(inputId="h0", 
                label=HTML("Elija el tipo de hipotesis alterna
                          < , &ne; o >"), 
                choices=list("Menor" = "less", 
                             "Diferente" = "two.sided",
                             "Mayor" = "greater"),
                selected = "two.sided"),
    
    checkboxInput(inputId='var.equal',
                  label='Las varianzas poblacionales son iguales', 
                  value=TRUE),
    
    sliderInput(inputId='alfa', 
                label=HTML("Opcional: elija un nivel de confianza para 
                construir el intervalo de confianza para la diferencia
                &mu;<sub>1</sub> - &mu;<sub>2</sub>"),
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
                       h5('A continuación se presentan las densidades, 
                       QQplot y valor P de la prueba de normalidad 
                       Shapiero
                       para analizar el cumplimiento del supuesto de 
                       normalidad de la variable de interés.'),
                       plotOutput("appPlot",
                                  width='500px',
                                  height='300px'),
                       
                       h4("- Tabla de resumen con estadísticos muestrales:"),
                       tableOutput('statistic'),
                       
                       h4("- Resultados de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       
                       h4(HTML("- Intervalo de confianza para la 
                               diferencia de medias 
                               &mu;<sub>1</sub> - &mu;<sub>2</sub>")),
                       textOutput("resul2")),
              
              tabPanel("Datos", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('summary')),
              
              tabPanel("Teoría", includeHTML("include.html"))
              
  )
)
  
))




