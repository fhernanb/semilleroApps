library(shiny)

shinyServer(function(input, output) {
  
  output$grafico1 <- renderPlot({
    prob <- dbinom(x=0:input$n, size=input$n, prob=input$p)
    barplot(prob, ylim=c(0, 1), names.arg=0:input$n,
            xlab="x", ylab=expression(P(X==x)), col="deepskyblue3", las=1)
    grid()
  })
})
