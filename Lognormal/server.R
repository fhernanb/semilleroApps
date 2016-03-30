library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    esperanza <-exp(input$mu+((input$sigma)^2)/2)
    varianza <-(exp(input$sigma^2)-1)*exp(2*input$mu+((input$sigma)^2))
    curve(dlnorm(x, input$mu, input$sigma),
          from=0, to=esperanza+3*sqrt(varianza), ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$github <- renderText({
    esperanza <-exp(input$mu+((input$sigma)^2)/2)
    varianza <-(exp(input$sigma^2)-1)*exp(2*input$mu+((input$sigma)^2))
    paste(c("Para esos parametros E(X)=", round(esperanza, 2),
            "y Var(X)=", round(varianza,2)))
  })
  
})
