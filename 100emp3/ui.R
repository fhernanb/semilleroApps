
library(shiny)
library(shinythemes)
require(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("journal"),
  titlePanel(title="Las 100 empresas más grandes de Colombia"),
  sidebarLayout(
    sidebarPanel(
      img(src="emp.png", height = 60, width = 220,  align = "middle"),
      selectInput(inputId="regiones", label="Selecciona la región:",
                  choices=c("Antioquia","Bogotá","Centro",
                             "Costa","Eje","Occidente","Oriente"),
                  selected="Antioquia"
                )
    ),
    
    mainPanel(
        tabsetPanel(
          tabPanel(title="Utilidad",
            plotOutput(outputId="hist1"),
            plotOutput(outputId="disp_puesto_util_neta"),
            plotOutput(outputId="disp_puesto_util_oper")
          ),
          tabPanel(title="EBITDA",
            plotOutput(outputId="boxplotEBITDA"),
            plotOutput(outputId="disp_puesto_marebitda"),
            plotOutput(outputId="disp_puesto_ebitda")
        ),
          tabPanel(title="Endeudamiento",
            plotOutput(outputId="boxplotEndeu"),
            plotOutput(outputId="disp_puesto_nivende")
        ),
          tabPanel(title="Rentabilidad",
            plotlyOutput(outputId="disp_puesto_rentact"),
            plotlyOutput(outputId="disp_puesto_rentpat")
        )
      )
    )
)))
