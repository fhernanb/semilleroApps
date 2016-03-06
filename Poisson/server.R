shinyServer(function(input, output) {
  
  output$grafico1 <- renderPlot({
    prob <- dpois(x=0:input$n, lambda=input$l)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$n,
            xlab="x", ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
})
