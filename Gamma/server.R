library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    require(gamlss)
    curve(dgamma(x, input$alpha, input$lambda),
          from=0, to=input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$github <- renderText({
    esperanza <- ( input$alpha) * (1/input$lambda)
    varianza <- ( input$alpha) * (1/(input$lambda^2))
    escala <- (1/input$lambda)
    paste(c("Para una escala=",escala,"E(X)=", esperanza,
            "con Var(X)=", varianza))
  })
  
})