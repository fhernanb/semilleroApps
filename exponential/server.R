library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    curve(dexp(x, rate=input$rate),
          from=0, to=input$x_max, ylab="Density",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    esperanza <- 1/input$rate
    varianza <- 1/input$rate^2
    paste(c("For this configuration E(X) =", round(esperanza, 2),
            "and Var(X) =", round(varianza, 2)))
  })
  
})