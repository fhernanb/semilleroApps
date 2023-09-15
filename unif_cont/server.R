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
      curve(dunif(x, min=input$min, max=input$max),
            from=input$min, to=input$max, ylab="Densidad",
            las=1, lwd=3, col="deepskyblue3")
      grid()
    }
  })
  
  output$med_var <- renderText({
    esperanza <- (input$min + input$max) / 2
    varianza <- (input$max - input$min)^2 / 12
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 2)))
  })
  
})
