library(shiny)
library(knitr)

shinyUI(pageWithSidebar(
  headerPanel("Exploring the distribution that fits better for a variable"),
  
# Here the sidebarpanel
  sidebarPanel(
    h6("This app can be used to identify the best four
        distributions that fit better for a variable. The user
        can provide the dataset using the buttons below."),
    h6("As an example the app uses the speed variable from
        the dataset cars."),
    h4("To use the app follow the next steps:"),
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
                 choices=list('tab'='\t', ','=',', ';'=';', 'space'=' '),
                 selected=';'),
    selectInput("response", label="Seleccione la variable 
                de la base de datos", choices=""),
    selectInput("familia", "Seleccione la familia a la cual pertenece 
                la variable de interés:", 
                choice=list("Reales positivos" = "realplus",
                            "Reales" = "realAll",
                            "Reales entre 0 y 1" = "real0to1",
                            "Conteos" = "counts",
                            "Binomiales" = "binom")),
    sliderInput("k", 'Ingrese una penalización \\( k \\) para 
                     penalizar el exceso de parámetros 
                     en el calculo del \\(GAIC=-2 \\times logLik + k \\times df\\)
                     donde \\( df \\) es número de parametros 
                     del modelo.',
                min=2,
                max=20,
                value=2,
                step=1,
                animate=TRUE),
    radioButtons(inputId = "type_plot", 
                 label = "Select the file type to download the plot", 
                 choices = list("pdf", "png")),
    br(),
    p("This app was created by Semillero de R at Universidad Nacional 
          de Colombia:"),
    img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
        height = 56, width = 140),
    tags$a(href="https://srunal.github.io", "https://srunal.github.io")
),

# Here the panels
mainPanel(
  tabsetPanel(type ="pills",
              tabPanel("Selected distributions I",
                       h4('A continuación se presenta el histograma para 
                          la variable de interés
                          con la curva de densidad para cada distribución.'),
                       plotOutput("distPlot1", width="700px", height="600px"),
                       downloadButton(outputId = "downplot1", label = "Download the plot")
              ),
              tabPanel("Selected distributions II",
                       h4('A continuación se presenta el histograma para 
                          la variable de interés
                          con la curva de densidad para cada distribución y
                          el qqplot asociado.'),
                       plotOutput("distPlot2", width="700px", height="800px"),
                       downloadButton(outputId = "downplot2", label = "Download the plot")
              ),
              tabPanel('Data', uiOutput('data_table')),
              tabPanel("Goodness of fit test"),
              tabPanel("Theory", includeHTML("include.html"))
    )
  )
 )
)
 

