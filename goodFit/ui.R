library(shiny)
library(knitr)

shinyUI(pageWithSidebar(
  headerPanel( "Explorando la distribución que mejor se ajusta a una variable"),
  sidebarPanel(
h6("Esta aplicación sirve para identificar
    las cuatro distribuciones 
    que mejor se ajustan a una variable de 
    una base de datos ingresada por el usuario."),
h6('Como ejemplo se muestran los resultados obtenidos para 
   la variable speed de la base de datos cars de R.'),
h4('Para usar la aplicación haga lo siguiente:'),
h6('1. Suba su base,'),
h6('2. Indique el tipo de separación de su base,'),
h6('3. Seleccione la variable de interés.'),
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
selectInput("response", label="Seleccione la variable 
            de la base de datos", choices=""),
selectInput("familia", "Seleccione la familia a la cual pertenece 
            la variable de interés:", 
            choice=list("Reales Positivos" = "realplus",
                        "Reales" = "realAll",
                        "Reales entre 0 y 1" = "real0to1",
                        "Conteos" = "counts",
                        "Binomiales" = "binom")),
sliderInput("k", "Ingrese una penalización K por el exceso de parámetros 
            para calcular el GAIC=-2 l + k df.",
            min=1,
            max=20,
            value=4,
            step=1,
            animate=TRUE),
br(),
p("This app was created by Semillero de R at Universidad Nacional 
      de Colombia:"),
img(src="https://fhbunal.files.wordpress.com/2017/08/logo.png",
    height = 56, width = 136),
tags$a(href="https://srunal.wordpress.com/", 
           "https://srunal.wordpress.com/")),
mainPanel(
  tabsetPanel(type ="pills",
tabPanel("Ajuste", h4('A continuación el ajuste para 
                      la variable seleccionada por el usuario'),
         plotOutput("distPlot", width="700px", height="600px")
         #downloadButton(outputId="descarga1", 'Descargar en png la gráfica.')
         ),
tabPanel("Teoría", includeHTML("include.html"))
    )
  )
 )
)
 

