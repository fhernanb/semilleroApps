library(shiny)

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    prob <- dnbinom(x=0:input$x.max, size=input$exitos, prob=input$p, log=F)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$x.max,
            xlab=paste("X: número de fracasos hasta conseguir ", input$exitos, "exitos"), 
            ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
  output$github <- renderText({
    if (input$p %in% 0:1) paste("No tiene sentido ese valor de p")
  })
})

