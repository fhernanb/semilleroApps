library(shiny)
library(mvtnorm)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Bivariate Normal Density"),
  sidebarLayout(
    sidebarPanel(
      numericInput("mu1", "Mean 1:", value = 0),
      numericInput("mu2", "Mean 2:", value = 0),
      numericInput("sd1", "SD 1:", value = 1),
      numericInput("sd2", "SD 2:", value = 1),
      numericInput("rho", "Correlation (rho):", 
                   min=-1, max=1,
                   value = 0),
      actionButton("plot", "Plot")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$plot, {
    x <- seq(-4, 4, length.out = 100)
    y <- seq(-4, 4, length.out = 100)
    z <- matrix(nrow = length(x), ncol = length(y))
    for (i in 1:length(x)) {
      for (j in 1:length(y)) {
        z[i, j] <- dmvnorm(c(x[i], y[j]), mean = c(input$mu1, input$mu2), 
                           sigma = matrix(c(input$sd1^2, input$rho * input$sd1 * input$sd2,
                                            input$rho * input$sd1 * input$sd2, input$sd2^2), ncol = 2))
      }
    }
    z <- as.data.frame(cbind(exp(z), expand.grid(x, y)))
    colnames(z) <- c("density", "x", "y")
    output$plot <- renderPlot({
      ggplot(z, aes(x = x, y = y, fill = density)) +
        geom_tile() +
        labs(title = "Bivariate Normal Density",
             x = "X1", y = "X2") +
        theme_minimal()
    })
  })
}

shinyApp(ui, server)