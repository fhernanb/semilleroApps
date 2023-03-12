library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Prueba de hipótesis sobre &mu; Normal multivariada"),
              windowTitle="PH media"),
  sidebarPanel(
    h5('Esta aplicación permite realizar una prueba de hipótesis sobre 
       el vector de medias poblacionales de una distribución normal 
       multivariada.'),
    
    h6('La aplicación por defecto usa los datos del ejemplo 5.2 página 214 
        de Jhonson & Wichern (2007) Applied Multivariate Statistical
        Analysis, sin embargo, el usuario
        puede subir su propia base de datos para usar la app.'),
    
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
                label = "¿Cuál es la separación de los datos?", 
                choices = list(Tab='\t', Comma=',',
                               Semicolon=';', 'space'=' '),
                selected = ';'),
    
    checkboxGroupInput(inputId="names", 
                       label = " Elija la variables cuantitativa para realizar la prueba de hipótesis.", 
                       choices = c("x1","x2","x3")),
                       
   p(strong(HTML("Ingrese el valor de referencia
                            &mu;<sub>0</sub> para probar
                H<sub>0</sub>: &mu; = &mu;<sub>0</sub>. Escriba los valores del vector separados por un espacio, así como se muestra a continuación:"))),
    tags$textarea(id="vectorIng", cols=20, rows=2, "4 50 10"),#cambiar para que sea varias filas
    br(),
    tags$a(href="https://srunal.github.io", "https://srunal.github.io"),
    br(),
   tags$a(href="https://satorozu.github.io", "Santiago Toro Z."),
   br(),
   tags$a(href="https://fhernanb.github.io/", "Freddy Hernández B."),
   h6("")
   
    
    ),
  
  mainPanel(
    tabsetPanel(type = "pills",
                tabPanel("Verificación de Supuestos",
                         h5("QQ plot para las distancias de Mahalanobis"),
                         plotOutput("qqplot", width='500px'),
                         
                         h5(" Tabla de resumen prueba Royston"),
                         verbatimTextOutput("royston"),
                         h5(" Tabla de resumen prueba Mardia"),
                         verbatimTextOutput("mardia")),
                         
                         
                tabPanel("Resultados",
                         
                         h4("Valor-P de la prueba"),
                         textOutput("titleValorp"),
                         plotOutput("grafico1", width='500px'),
                         
                         h4("Vector de medias muestral"),
                         verbatimTextOutput('med_muestra'),
                         h4("Matriz de covarianzas muestral"),
                         verbatimTextOutput('S_muestra'),
                         h4("Vector de medias de referencia"),
                         verbatimTextOutput('med_ho'),
                         h4("- Resultados de la prueba de hipótesis:"),
                         textOutput("resul1"),
                         br(),
                         h5(HTML("Sí Valor-P < &alpha;, entonces se rechaza H<sub>0</sub>: &mu; = &mu;<sub>0</sub>."))),
  
                
                tabPanel("Datos", 
                         "A continuación los datos que está usando 
                         la aplicación.", uiOutput('inputData')),
                
                tabPanel("Teoría", 
                         includeHTML("Include.html"))
                
                )
                )
  
    ))