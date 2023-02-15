library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Hypergeometric distribution"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      p("Modify the parameter values and observe what happens in the barplot"),
      br(),
      br(),
      sliderInput(inputId = "m",
                  label = HTML("Number of successes in the population:"),
                  min = 1,
                  max = 50,
                  value = 6,
                  step= 1,
                  animate = TRUE),
      sliderInput(inputId = "n",
                  label = HTML("Number of failures in the population:"),
                  min = 1,
                  max = 50,
                  value = 4,
                  step= 1,
                  animate = TRUE),
      uiOutput("k"),
      br(),
      p("App created by Semillero de R at Universidad Nacional de Colombia:"),
      tags$a(href="https://srunal.github.io/", "https://srunal.github.io/")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Probability distribution", align = "center"),
      plotOutput("grafico1"),
      verbatimTextOutput('med_var')
    )
  )
))
