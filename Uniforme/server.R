shinyServer(function(input, output) {
  
  output$grafico1 <- renderPlot({
    if (input$min > input$max) {
      plot(c(-5, 5), c(0, 1), xlab="", ylab="", type='n',
           xaxt='n', yaxt='n', bty='n')
      text(x=0, y=0.5, col='red', cex=2,
           label='Revise los valores que ingresó.')
      text(x=0, y=0.4, col='purple', cex=2,
           label='El mínimo no puede ser mayor que el máximo.')
    }
    else {
      n <- input$max - input$min + 1
      x <- seq(from=input$min, to=input$max)
      prob <- rep(1/n, n)
      barplot(prob, ylim=c(0, 1), names.arg=x,
              xlab="x", ylab=expression(P(X==x)), 
              col="deepskyblue3", las=1)
      grid()
    }
  })
})
