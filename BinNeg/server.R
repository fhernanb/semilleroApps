library(shiny)

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    prob <- dnbinom(x=0:input$x.max, size=input$exitos, prob=input$p, log=F)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$x.max,
            xlab=paste("X: numero de fracasos hasta conseguir ", input$exitos, "exitos"), 
            ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
  output$github <- renderText({
    if (input$p==0) paste("No tiene sentido p=0")
    #paste('You selected', if (input$p == '') 'nothing' else input$p,
    #      'in the Github example.')
  })
})

