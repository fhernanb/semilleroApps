#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Convergencia en probabilidad"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p(HTML('Se quiere mostrar por medio de esta aplicación la convergencia en probabilidad, ilustrando
        como el n-ésimo estadístico de orden converge en distribución al máximo poblacional, implicando
        convergencia en probabilidad. La aplicación simula 5000 muestras de una distribución uniforme y el
        usuario elije el tamaño de muestra <b>n</b> y el máximo poblacional <b>&#952;</b>.')),
      br(),
      p(HTML("Si se da click en el triángulo pequeño de color azul se podrá obtener una animación de la curva 
        de la distribución acumulada <b> F <sub> X <sub> (n) </sub> </sub> (x) </b>.")),
       sliderInput("n",
                   "Tamaño de muestra n",
                   min = 1,
                   max = 800,
                   value = 2,
                   step = 1,
                   animate = TRUE),
      numericInput("theta",
                   label = HTML("Máximo poblacional &#952;"), 10,
                   min = 10, max = 50),
      br(),
      p("Esta app fue creada por el profesor Freddy Hernández y el estudiante Mateo Ochoa 
        de la Universidad Nacional de Colombia:"),
      br(),
      img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
          height = 56, width = 140)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(type = "tabs",
                   tabPanel("Convergencia",
                            includeHTML("Definicion.html"),
                            plotOutput("distPlot")),
                   tabPanel("Demostración", 
                            includeHTML("Demostracion.html")))
    )
  )
))
