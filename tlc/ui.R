library(shiny)
library(knitr)
library(markdown)

#  interfaz del usuario para montaje de comandos y ventanas, bases si se requiere
fluidPage(
  
  # Titulo de la aplicacion
  titlePanel("Teorema del Límite Central (TLC)"),
  

  ### ubicacion de botones y ventanas en la aplicacion
  sidebarLayout(
     sidebarPanel(
       h6('Esta aplicación sirve para ilustrar el Teorema del Límite Central.
           La aplicación simula 1000 muestras de cualquiera de las distribuciones
           disponibles y el usuario elije el tamaño de cada muestra para verificar
           que la distribución de las medias muestrales se aproxima a una normal.'),
       br(),
  ### relaciona las distribuciones a usar y por defecto selecciona la distribucion normal.    
       selectInput(inputId = "distri",
                   label = "Elija la distribución:",
                   choices = c("Normal",
                               "Uniforme",
                               "Gamma",
                               "Beta"),
                   selected = "Gamma"),
  
      br(),

  # Distribucion normal
  conditionalPanel(condition="input.distri == 'Normal'",
                   numericInput(inputId="media",
                                label=HTML("Ingrese la media &mu;."),
                                value="10",
                                step=0.1),
                   
                   numericInput(inputId="desvi",
                                label=HTML("Ingrese la desviación &sigma;."),
                                min=0.1,
                                value="3",
                                step=0.1) ),
  
  # Distribucion Uniforme
  conditionalPanel(condition="input.distri == 'Uniforme'",
                   numericInput(inputId="min",
                                label=HTML("Ingrese el valor minimo."),
                                value="0",
                                step=0.1),
                   
                   numericInput(inputId="max",
                                label=HTML("Ingrese el valor maximo."),
                                min=0,
                                value="1",
                                step=0.1) ),
  
  # Distribucion Gamma
    conditionalPanel(condition="input.distri == 'Gamma'",
                   numericInput(inputId="shape",
                                label=HTML("Ingrese el parámetro de forma."),
                                min=0.01,
                                value="1",
                                step=0.1),
                   
                   numericInput(inputId="scale",
                                label=HTML("Ingrese el parámetro de escala."),
                                min=0.01,
                                value="1",
                                step=0.1) ),
  
  # Distribucion beta
    conditionalPanel(condition="input.distri == 'Beta'",
                   numericInput(inputId="shape1",
                                label=HTML("Ingrese el parámetro a."),
                                min=0.01,
                                value="1.5",
                                step=0.1),
                   
                   numericInput(inputId="shape2",
                                label=HTML("Ingrese el parámetro b."),
                                min=0.01,
                                value="0.9",
                                step=0.1) ),

  
  sliderInput(inputId="n", 
                  "Seleccione el tamaño de muestra n:", 
                  value=1,
                  min=1, 
                  max=1000, step=NULL, animate=T),
  

  p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
  img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
      height = 56, width = 140),
  tags$a(href="https://srunal.github.io", "https://srunal.github.io")
  ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("TLC",
                           plotOutput("TLC", width="550px", height="550px")),
                  tabPanel("Teoría", includeHTML("include.html"))
                  
      )
    )
  )
)

