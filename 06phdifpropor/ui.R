library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipótesis para la diferencia 
                         de proporciones P<sub>1</sub> - P<sub>2</sub>"),
              windowTitle="PH proporción"),
  sidebarPanel(
    h5(HTML('Esta aplicación realiza la prueba de hipótesis para la 
       diferencia de proporciones. La hipótesis nula considerada
            es H<sub>0</sub>: P<sub>1</sub> - P<sub>2</sub>=0')),
    
    h6('La aplicación usa dos bases de datos de ejemplo pero el usuario
       puede cargar su propia información. Las bases de datos
       que ingrese deben tener los mismos nombres de variables.'),
    
    fileInput(inputId='file1',
              label='Use el siguiente botón para cargar 
                     su base de datos # 1.',
              accept = c(
                'text/csv',
                'text/comma-separated-values',
                'text/tab-separated-values',
                'text/plain',
                '.csv',
                '.tsv'
              )),
    
    fileInput(inputId='file2',
              label='Use el siguiente botón para cargar 
                     su base de datos # 2.',
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
    
    hr(),
    
    selectInput(inputId="variable", 
                label=p("Elija una variable",
                        span("cualitativa", style = "color:red"),
                        "de las bases para realizar la prueba 
                        de hipótesis."),
                choices="placeholder1"),
    
    selectInput(inputId="niveles", 
                label=p("Elija un",
                        span("nivel", style = "color:blue"),
                        "de la variable cualitativa anterior para
                        realizar la prueba."), 
                choices="placeholder2"),
    
    selectInput(inputId="h0", 
                label=HTML("Elija la hipótesis alternativa
                          < , &ne; o >"), 
                choices=list("Menor" = "less", 
                             "Diferente" = "two.sided",
                             "Mayor" = "greater"),
                selected = "two.sided"),
    
    checkboxInput(inputId="correct", 
                  label="Marque si desea usar factor de correción", 
                  value=TRUE, width=NULL),
    
    sliderInput(inputId='alfa',
                label=HTML("Opcional: elija un nivel de confianza para 
                construir el intervalo de confianza para la proporción P;"),
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
              
              tabPanel("Resultados",
                       h4('- Diagrama de barras para la variable
                          seleccionada.'),
                       plotOutput("appPlot"),
                       
                       h4("- Tabla resumen de las bases:"),
                       tableOutput("consolidado"),
                       
                       h4("- Resultados de la prueba de hipótesis:"),
                       textOutput("resul1"),
                       
                       h4(HTML("- Intervalo de confianza para la proporción P:")),
                       textOutput("resul2")),
              
              tabPanel("Base datos # 1", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('inputData1')),
              
              tabPanel("Base datos # 2", 
                       "A continuación los datos que está usando 
                       la aplicación.",
                       uiOutput('inputData2')),
              
              tabPanel("Teoría", includeHTML("include.html"))
              
  )
)
  
))




