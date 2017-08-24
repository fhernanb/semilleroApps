library(shiny)

shinyServer(function(input, output) 
  {
  
  output$grafico1 <- renderPlot({
    curve(dcauchy(x, input$mu, input$sigma),
          from=input$mu-input$x.max, to=input$mu+input$x.max, ylab="Densidad",
          las=1, lwd=3, col="deepskyblue3")
    grid()
  })
  
  output$github <- renderText({
    mediana <- input$mu
    entropia <- log(4*pi*input$sigma)
    paste(c("Para esta configuración Mediana =", mediana,
            "con Entropia =", entropia))
  })
  
})