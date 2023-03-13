library(shiny)
library(plotly)
library(rgl)

ui <- fluidPage(
  titlePanel("Bivariate Normal Density"),
  sidebarLayout(
    sidebarPanel(
      p("This app plots the density surface for a
        bivariate normal distribution given the 
        mean vector and the covariance matrix."),
      br(),
      numericInput("m1", "Mean 1:", value = 1.3),
      numericInput("m2", "Mean 2:", value = 2.5),
      numericInput("sd1", "Standar deviation 1:", 
                   value = 1.2, min=0.01),
      numericInput("sd2", "Standar deviation 2:", 
                   value = 0.5, min=0.01),
      numericInput("rho", "Correlation (rho):", 
                   min=-1, max=1, step=0.01,
                   value = -0.36),
      p("Click on the Plot button to obtain the plot."),
      actionButton("plot", "Plot")
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Static density", 
                           plotOutput("plot1", 
                                      width="550px", height="550px")),
                  tabPanel("Interactive density", 
                           plotOutput("plot3"))
                  
      )
    )
  )
)