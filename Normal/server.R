library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    curve(dnorm(x, mean=input$media, sd=input$desvi),
          from=input$media - 3 * input$desvi,
          to=input$media + 3 * input$desvi,
          ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    a <- input$media
    b <- input$desvi
    esperanza <- a
    varianza <- b^2
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 2)))
  })
  
})