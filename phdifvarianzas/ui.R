library(shiny)
library(markdown)
source("funciones.R")

shinyUI(pageWithSidebar(
        headerPanel(title=HTML("Prueba de hipotesis para igualdad de dos Varianzas 
                               &sigma;<sub>1</sub> / &sigma;<sub>2</sub>"),
                    windowTitle="PH dif medias"),
        
        sidebarPanel(
                h5('Esta aplicacion sirve para realizar una prueba de hipotesis 
                   para comprobar si la varianza de dos poblaciones son iguales. Ingrese la 
                   informacion solicitada abajo. Por defecto se carga una base de ejemplo
                   pero usted puede ingresar la suya'),
                
                fileInput(inputId='file1',
                          label='Use el boton siguiente para cargar su base de datos.',
                          accept = c(
                                  'text/csv',
                                  'text/comma-separated-values',
                                  'text/tab-separated-values',
                                  'text/plain',
                                  '.csv',
                                  '.tsv'
                          )),
                
                checkboxInput(inputId='header',
                              label='Tiene encabezado la base de datos?', 
                              value=TRUE),
                
                selectInput(inputId="sep",
                            label = "Cual es la separacion interna de los
                            datos en la su base de datos?", 
                            choices = list(Tab='\t', Comma=',', Semicolon=';'),
                            selected = ';'),
                
                selectInput(inputId="variable1",
                            label="Seleccione la variable 
                            de interes de la base de datos",
                            choices=""),
                
                selectInput(inputId="variable2",
                            label="Seleccione la variable cualitativa 
                            de agrupacion, DEBE tener 2 niveles y ser un factor.",
                            choices=""),
                
                #numericInput(inputId='delta0', 
                #            label=HTML("Ingrese el valor de referencia 
                #                      &Delta;<sub>0</sub> para la probar
                #                     H<sub>0</sub>: &mu;<sub>1</sub> 
                #                    - &mu;<sub>2</sub> = &Delta;<sub>0</sub>"), 
                #        value=0),
                
                selectInput(inputId="h0", 
                            label=HTML("Elija el tipo de hipotesis alterna
                                       < , &ne; o >"), 
                            choices=list("Menor" = "less", 
                                         "Diferente" = "two.sided",
                                         "Mayor" = "greater"),
                            selected = "two.sided"),
                
                # checkboxInput(inputId='var.equal',
                #              label='Las varianzas poblacionales son iguales', 
                #             value=TRUE),
                
                sliderInput(inputId='alfa', 
                            label='Opcional: elija el nivel de significancia
                            para construir el intervalo de confianza',
                            min=0.90, max=0.99,
                            value=0.95, step=0.01),
                
                img(src="logo.png", height = 60, width = 150),
                br(),
                
                tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
                
                ),
        
        mainPanel(
                tabsetPanel(type = "pills",
                            
                            tabPanel(title="Resultados",
                                     h5('A continuacion se presentan las densidades, 
                                        qqplot y valor P de la prueba de normalidad Shapiro 
                                        para analizar el cumplimiento del supuesto de 
                                        normalidad para la variable de interes.'),
                                     plotOutput("distPlot",
                                                width='70%', height='300px'),
                                     h5("Tabla con las estadisticas de resumen:"),
                                     tableOutput('statistic'),
                                     
                                     h5("En la siguiente tabla se muestran los principales elementos de la prueba de hipotesis:
                                        varianza muestral del numerador y del denominador, estadistico de prueba,
                                        grados de libertad del numerador y del denominador, valor P, valores de la region critica de rechazo y 
                                        conclusion de la prueba"),
                                     tableOutput("analisis_ph")
                                     
                                     #h5("- Resultado de la prueba de hipotesis:"),
                                     #textOutput("resul1"),
                                     
                                     #h5(HTML("- Intervalo de confianza para la 
                                     #       diferencia de medias 
                                     #      &mu;<sub>1</sub> - &mu;<sub>2</sub>")),
                                     #textOutput("resul2")
                                     ),
                            
                            tabPanel("Base de datos", 
                                     "A continuacion la base de datos ingresada por el usuario.",
                                     uiOutput('summary')),
                            
                            tabPanel("Teoria", includeMarkdown("include.md"))
                            
                                     )
                )
        
        ))