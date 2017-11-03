library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    curve(df(x, df1=input$df1, df2=input$df2),
          from=0, to=input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$med_var <- renderText({
    x <- rf(n=1000000, input$df1, input$df2)
    esperanza <- mean(x)
    varianza <- var(x)
    paste(c("Para esta configuración E(X) =", round(esperanza, 2),
            "con Var(X) =", round(varianza, 2)))
  })
  
})