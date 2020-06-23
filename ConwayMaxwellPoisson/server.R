library(shiny)
source('con_max_pois.R')

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    prob <- dcmp(x=0:input$x.max, 
                 lambda=input$lambda, 
                 nu=input$nu, log=F)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$x.max,
            xlab=paste("X"), 
            ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
})

