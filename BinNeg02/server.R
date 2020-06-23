library(shiny)

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    prob <- dnbinom(x=0:input$x.max, 
                    size=input$k, 
                    mu=input$mu, log=F)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$x.max,
            xlab=paste("X"), 
            ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
  output$github <- renderText({
    if (input$mu %in% 0:1) paste("No tiene sentido mu = 0.")
  })
})

