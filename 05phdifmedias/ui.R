library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipótesis para la diferencia de medias 
                         &mu;<sub>1</sub> - &mu;<sub>2</sub>"),
              windowTitle="PH dif medias"),
  
  sidebarPanel(
    h5('Esta aplicación realiza la prueba de hipótesis 
        para la diferencia de medias de variables cuantitativas
        que tengan distribución normal.'),
    
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
                label = "¿Cuál es la separación de los datos?", 
                choices = list(Tab='\t', Comma=',',
                               Semicolon=';', 'Space'=' '),
                selected = ';'),
    
    selectInput(inputId="variable1",
                label=p("Elija la variable",
                        span("cualitativa", style = "color:red"),
                        "para realizar la prueba de hipótesis."),
                choices=""),
    
    selectInput(inputId="variable2",
                label=p("Elija la variable",
                        span("cualitativa", style = "color:blue"),
                        "de agrupacion, DEBE tener 2 niveles y ser un factor."),
                choices=""),

        numericInput(inputId='delta0', 
                 label=HTML("Ingrese el valor de referencia 
                            &delta;<sub>0</sub> para la probar
                            H<sub>0</sub>: &mu;<sub>1</sub> 
                            - &mu;<sub>2</sub> = &delta;<sub>0</sub>"), 
                 value=0),
    
    selectInput(inputId="h0", 
                label=HTML("Elija el tipo de hipotesis alterna
                          < , &ne; o >"), 
                choices=list("Menor" = "less", 
                             "Diferente" = "two.sided",
                             "Mayor" = "greater"),
                selected = "two.sided"),
    
    checkboxInput(inputId='var.equal',
                  label='Marque la casilla si las varianzas 
                  poblacionales son iguales', 
                  value=FALSE),
    
    sliderInput(inputId='alfa', 
                label=HTML("Opcional: elija un nivel de confianza para 
                construir el intervalo de confianza para la diferencia
                &mu;<sub>1</sub> - &mu;<sub>2</sub>"),
                min=0.90, max=0.99,
                value=0.95, step=0.01),
    
    img(src="logo.png", height = 60, width = 120),
    img(src="udea.png", height = 25, width = 70),
    img(src="cua.png", height = 40, width = 110),
    br(),
    tags$a(href="https://srunal.github.io", "https://srunal.github.io")

),

mainPanel(
  tabsetPanel(type = "pills",
              tabPanel(title="Resultados",
                       h5('A continuación el histograma, la densidad, 
                          el QQplot
                          y valor-P para la prueba de normalidad
                          Shapiro-Wilk para cada una de las
                          dos muestras.'),
                       plotOutput("appPlot",
                                  width='500px',
                                  height='300px'),
                       
                       h4("- Tabla de resumen con los estadísticos muestrales:"),
                       tableOutput('statistic'),
                       
                       h4("- Resultados de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       
                       h4(HTML("- Intervalo de confianza para la 
                               diferencia de medias 
                               &mu;<sub>1</sub> - &mu;<sub>2</sub>:")),
                       textOutput("resul2")),
              
              tabPanel("Datos", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('summary')),
              
              tabPanel("Teoría", includeHTML("include.html"))
              
  )
)
  
))




