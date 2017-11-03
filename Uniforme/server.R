shinyServer(function(input, output) {
  
  output$grafico1 <- renderPlot({
    n <- input$max - input$min + 1
    x <- seq(from=input$min, to=input$max)
    prob <- rep(1/n, n)
    barplot(prob, ylim=c(0, 1), names.arg=x,
            xlab="x", ylab=expression(P(X==x)), 
            col="deepskyblue3", las=1)
    grid()
  })
})
