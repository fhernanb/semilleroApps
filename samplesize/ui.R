shinyUI(fluidPage(
  titlePanel("Tamaños de muestra"),
  h4(p("Esta aplicación entrega los tamaños de muestra para
        diferentes niveles de confianza cuando el interés es
        estimar una proporción o una media."), align="left"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="tipo",
                  label="Elija el tipo de problema para el cual quiere calcular n:",
                  choices=c("Proporcion", "Media"),
                  selected="Media"),

#------- proporcion
      
      conditionalPanel(condition="input.tipo=='Proporcion'",
                       
                       selectInput(inputId="Ncp",
                                    label="Conoce usted el tamaño N de la población?",
                                    choices=c('Si', 'No'),
                                    selected="No"),
                       
                       conditionalPanel("input.Ncp=='Si'",
                       
                         numericInput(inputId="Nprop",
                                     label="Ingrese el tamaño de la población",
                                     min=5,
                                     value=500,
                                     step=1) ),
                       
                       sliderInput(inputId="p",
                                    label="Ingrese una estimación preliminar para p, 
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
                                   label="Conoce usted el tamaño N de la población?",
                                   choices=c('Si', 'No'),
                                   selected="No"),
                       
                       conditionalPanel("input.Ncm=='Si'",
                                        
                         numericInput(inputId="Nmean",
                                      label="Ingrese el tamaño de la población N",
                                      min=2,
                                      value=30,
                                      step=1) ),
                       
                       numericInput(inputId="sigma",
                                    label=HTML("Ingrese una estimación de &sigma;:"),
                                    min=0.01,
                                    max=1000,
                                    value=12,
                                    step=0.1),
                       
                       numericInput(inputId="emean",
                                    label=HTML("Ingrese el error admisible &epsilon;:"),
                                    min=0.01,
                                    value=5,
                                    step=0.1)),

      p("App creada por el Semillero de R de la Universidad Nacional de Colombia."),
      img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
          height = 56, width = 140),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")

    ),


    mainPanel(  plotOutput("grafica")  )
  )))
