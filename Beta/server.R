library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    curve(dbeta(x, shape1=input$shape1, shape2=input$shape2),
          from=0, to=1, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    a <- input$shape1
    b <- input$shape2
    esperanza <- a/(a+b)
    varianza <- (a*b) / ((a+b)^2 * (a+b+1))
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 4)))
  })
  
})