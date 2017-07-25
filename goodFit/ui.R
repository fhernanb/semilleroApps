library(shiny)
library(knitr)

shinyUI(pageWithSidebar(
  headerPanel( "Explorando la distribución que mejor se ajusta a una variable"),
  sidebarPanel(h3("Objetivo:"),
h5('Esta aplicación sirve para mostrar
las mejores cuatro distribuciones 
que se ajustan a una variable elegida de 
una base de datos. Se muestra una gráfica 
con una base predeterminada inicialmente 
(Siendo el mejor ajuste BCPEo, seguido por 
la Exp y asi respectivamente). A continuación 
suba su base de interes e indique con exactitud el tipo de separación de su base.'),
br(),
fileInput(inputId='file1', label='Use el botón siguiente para
          cargar la base de datos.',
          accept = c(
            'text/csv',
            'text/comma-separated-values',
            'text/tab-separated-values',
            'text/plain',
            '.csv',
            '.tsv'
            )),

checkboxInput('header', label='¿Tiene encabezado la base
              de datos?', value=TRUE),

selectInput(inputId="sep", label="¿Cual es la separación de sus datos?",
             choices=list(Tabulacion='\t', Coma=',', PuntoyComa=';'),
             selected=';'),

tags$hr(),

selectInput("product",label="Seleccione la variable 
            de la base de datos", choices=""),

selectInput("familia", "Seleccione la familia de distribuciones 
            a analizar",choice=list("Reales"="realAll",
                            "Reales Lineales"="realline",
                            "Reales Positivas"="realplus",
                            "Reales de 0 a 1"="real0to1",
                            "Conteos"="counts",
                            "Binomiales"="binom")),

sliderInput("k","Ingrese una penalización K por cantidad de parámetros",
            min=1,
            max=10,
            value=4,
            step=1,
            animate=TRUE),
img(src="medellin.png", height = 80, width = 200),
br(),
br(),
p("App creada por el Semillero de R de la Universidad Nacional 
      de Colombia:"),
tags$a(href="https://srunal.wordpress.com/", 
           "https://srunal.wordpress.com/")),
mainPanel(
  tabsetPanel(type ="pills",
tabPanel("Ajuste",h4('A continuación el ajuste para 
la variable seleccionada por el usuario'),
         plotOutput("distPlot", width="600px", height="600px"),
         downloadButton(outputId="descarga1",
                        'Descargar en png la gráfica.')),
tabPanel("Teoría",uiOutput('markdown'))
    )
  )
 )
)
 
