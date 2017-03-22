library(markdown)
library(shiny)
library(knitr)
library(png)

#  interfaz del usuario para montaje de comandos y ventanas, bases si se requiere
fluidPage(
  
  # Titulo de la aplicacion
  titlePanel("Teorema del limite Central (TLC)"),
  

  ### ubicacion de botones y ventanas en la aplicacion
  sidebarLayout(
     sidebarPanel(
       h6('Esta aplicacion sirve para ilustrar el Teorema del Limite Central.
           El objetivo es simular 1000 de cualquiera de las distribuciones
           disponibles y ver que cuando n crece la distribucion 
           de las medias muestrales se aproxima a una normal.'),
       br(),
  ### relaciona las distribuciones a usar y por defecto selecciona la distribucion normal.    
       selectInput(inputId = "distri",
                   label = "Elija Distribucion:",
                   choices = c("Normal",
                               "Uniforme",
                               "Gamma",
                               "Beta"),
                   selected = "Gamma"),
  
      br(),

  
  conditionalPanel(condition="input.distri == 'Normal'",
                   numericInput(inputId="media",
                                label=HTML("Ingrese la media &mu;."),
                                value="10",
                                step=0.1),
                   
                   numericInput(inputId="desvi",
                                label=HTML("Ingrese la desviacion &sigma;."),
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
                                label=HTML("Ingrese parametro de forma."),
                                min=0.01,
                                value="1",
                                step=0.1),
                   
                   numericInput(inputId="scale",
                                label=HTML("Ingrese parametro de escala."),
                                min=0.01,
                                value="1",
                                step=0.1) ),
  
  # Distribucion beta
  
  conditionalPanel(condition="input.distri == 'Beta'",
                   numericInput(inputId="shape1",
                                label=HTML("Ingrese el parametro a."),
                                min=0.01,
                                value="1.5",
                                step=0.1),
                   
                   numericInput(inputId="shape2",
                                label=HTML("Ingrese el parametro b."),
                                min=0.01,
                                value="0.9",
                                step=0.1) ),

  
  sliderInput(inputId="n", 
                  "Seleccione tamano de muestra n:", 
                  value=1,
                  min=1, 
                  max=100, step=1, animate=T),
  

  img(src="medellin.png", height = 80, width = 200),
  br(),
  p("App creada por el Semillero de R de la Universidad Nacional de Colombia:"),
  tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")
  ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("TLC",
                           plotOutput("TLC", width='90%', height='600px')),
                  tabPanel("Teoria", includeHTML("include.html"))
                  
      )
    )
  )
)

