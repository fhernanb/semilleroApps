library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    varianza <- pi^2/(3*input$scale^2)
    desv <- sqrt(varianza)
    curve(dlogis(x, input$location, input$scale),
          from=-input$distribuciones*desv+input$location, to=input$location + input$distribuciones*desv, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$github <- renderText({
    esperanza <- input$location
    varianza <- pi^2/(3*input$scale^2)
    paste(c("Para esos parametros E(X)=", round(esperanza, 2),
            "con Var(X)=", round(varianza, 2)))
  })
  
})