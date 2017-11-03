library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    require(gamlss)
    curve(dgamma(x, shape=input$shape, scale=input$scale),
          from=0, to=input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    esperanza <- (input$shape) * input$scale
    varianza <- (input$shape) * input$scale^2
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 2)))
  })
  
})