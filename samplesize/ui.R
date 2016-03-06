shinyUI(fluidPage(
  titlePanel(h1("Tamanos de muestra",align="center", style="color:steelblue")),
  h4(p("Esta aplicacion entrega los tamanos de muestra para
        diferentes niveles de confianza cuando el interes es
        estimar una proporcion o una media."), align="center"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="tipo",
                  label="Elija el tipo de problema para el cual quiere calcular n:",
                  choices=c("Proporcion", "Media"),
                  selected="Media"),

#------- proporcion
      
      conditionalPanel(condition="input.tipo=='Proporcion'",
                       
                       selectInput(inputId="Ncp",
                                    label="Conoce usted el tamano N de la poblacion?",
                                    choices=c('Si', 'No'),
                                    selected="No"),
                       
                       conditionalPanel("input.Ncp=='Si'",
                       
                         numericInput(inputId="Nprop",
                                     label="Ingrese el tamaño de la poblacion",
                                     min=5,
                                     value=500,
                                     step=1) ),
                       
                       sliderInput(inputId="p",
                                    label="Ingrese una estimacion preliminar para p, 
                                    caso no tenga idea use 0.5.",
                                    min=0.01,
                                    max=0.99,
                                    value=0.8,
                                    step=0.01),

                       sliderInput(inputId="eprop",
                                    label=HTML("Ingrese el error admisible &epsilon;:"),
                                    min=0.01,
                                    max=0.99,
                                    value=0.06,
                                    step=0.01)),
#------- media

      conditionalPanel(condition="input.tipo=='Media'",
                       
                       selectInput(inputId="Ncm",
                                   label="Conoce usted el tamano N de la poblacion?",
                                   choices=c('Si', 'No'),
                                   selected="No"),
                       
                       conditionalPanel("input.Ncm=='Si'",
                                        
                         numericInput(inputId="Nmean",
                                      label="Ingrese el tamano de la poblacion N",
                                      min=2,
                                      value=30,
                                      step=1) ),
                       
                       numericInput(inputId="sigma",
                                    label=HTML("Ingrese una estimacion de &sigma;:"),
                                    min=0.01,
                                    max=1000,
                                    value=12,
                                    step=0.1),
                       
                       numericInput(inputId="emean",
                                    label=HTML("Ingrese el error admisible &epsilon;:"),
                                    min=0.01,
                                    value=5,
                                    step=0.1)),

img(src="logo.png", height = 56, width = 136),
img(src="udea.png", height = 72, width = 64)

    ),


    mainPanel(  plotOutput("grafica")  )
  )))
