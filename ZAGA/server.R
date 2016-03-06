library(shiny)

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    require(gamlss)
    curve(dZAGA(x, input$mu, input$sigma, input$nu),
          from=0, to=input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$github <- renderText({
    esperanza <- (1 - input$nu) * input$mu
    varianza <- (1 - input$nu) * input$mu^2 * (input$nu + input$sigma^2)
    paste(c("Para esos parametros E(X)=", esperanza,
            "con Var(X)=", varianza))
  })
  
})

