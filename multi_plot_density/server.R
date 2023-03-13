source("auxiliar.R")

server <- function(input, output) {
  observeEvent(input$plot, {

    
    mu <- c(input$m1, input$m2)
    Sigma <- matrix(c(input$sd1^2, input$rho * input$sd1 * input$sd2,
                      input$rho * input$sd1 * input$sd2, input$sd2^2), ncol = 2)
    
    N <- 50
    x1 <- seq(from=input$m1-4*input$sd1, 
              to  =input$m1+4*input$sd1, 
              length.out=N)
    x2 <- seq(from=input$m2-4*input$sd2, 
              to  =input$m2+4*input$sd2, 
              length.out=N)
    
    densidad_curva <- function(x1, x2) dmvnorm(cbind(x1, x2), 
                                               mean=mu, 
                                               sigma=Sigma)  
    
    probX <- outer(x1, x2, FUN="densidad_curva")
    
    output$plot1 <- renderPlot({
      par(mar=c(0,0,0,0))
      persp(x1, x2, probX, theta=45, phi=20,
            xlab="X1",ylab="X2", zlab="", 
            ticktype="detailed", nticks=4, col="khaki1")
    })
    
    output$plot2 <- renderPlotly({
      require(plotly)
      fig <- plot_ly(x=x1, y=x2, z=probX, type="surface")
      #fig <- plot_ly(z = ~volcano)
      ggplotly(fig)
    })
    
    output$plot2 <- renderPlot({
      torus <- plot3d(x=x1, y=x2, z=probX, type = "l", col = "blue",
                      cex = .3, pch = 1, main = "Half Torus", pch = 20)
      rglwidget(elementId = "plot3drgl")
    })
    
    
  })
}
