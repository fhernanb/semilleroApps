library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("App para seleccionar un subconjunto de los datos."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="tipo", label="Choose type", 
                  choices=unique(dt$Sector))

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
