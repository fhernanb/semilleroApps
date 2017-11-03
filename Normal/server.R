library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    require(gamlss)
    curve(dweibull(x, shape=input$shape, scale=input$scale),
          from=0, to=input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    a <- input$shape
    b <- input$scale
    esperanza <- b * gamma(1+1/a)
    varianza <- b^2 * (gamma(1 + 2/a) - (gamma(1 + 1/a))^2)
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 2)))
  })
  
})