#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

muestras <- function(ene, theta){
  val.uniformes <- runif(n=ene,
                         min = 0,
                         max = theta)
  maximo <- max(val.uniformes)
  return(maximo)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    par(mar = c(5.1, 7, 4.1, 2.1))
    plot(ecdf(replicate(n = 5000, muestras(input$n, input$theta))),
         xlab = expression(X[(n)]),
         ylab = expression(F[X[(n)]](x)),
         xlim = c(1, input$theta+0.6),
         main = "",
         pch = '.', 
         las = 1,
         col = "royalblue1",
         lwd = 3)
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = "royalblue1")
    legend("topleft",
           legend = c(expression(F[X[(n)]](x)), "Distribución degenerada"),
           col = c("royalblue1", "gray48"),
           lty = c(1,3),
           lwd = 3)
    abline(v = input$theta, lty = 3)
    
    
    
  })
})
