library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel(HTML("Exponential distribution (&lambda;)")),
  
  sidebarLayout(
    sidebarPanel(
      HTML("Modify the parameter value and observe what happens with the density plot"),
      br(),
      br(),
      sliderInput(inputId = "rate",
                  label = HTML("Enter the value of the rate parameter &lambda;: "),
                  min = 0.1,
                  max = 50,
                  value = 1.7,
                  step= 0.1,
                  animate = TRUE),
      numericInput(inputId = "x_max",
                  label = "Enter the maximum value of x to display on the graph:",
                  min = 1,
                  max = 300,
                  value = 9,
                  step = 1),
      br(),
      p("App created by Semillero de R at Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io", "https://srunal.github.io")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Density plot", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))