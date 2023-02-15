shinyServer(function(input, output) {
  
  output$k <- renderUI({
    sliderInput(inputId = "k", 
                label = HTML("Number of units sampled from the population:"), 
                min=1,
                max=input$m+input$n, 
                value=1,
                step= 1)
  })
  
  output$grafico1 <- renderPlot({
    min_x <- max(c(0, input$k-input$n))
    max_x <- min(c(input$k, input$m))
    prob <- dhyper(x=min_x:max_x, m=input$m, n=input$n, k=input$k)
    barplot(prob, ylim=c(0, 1), names.arg=min_x:max_x,
            xlab="X: number of successes observed in the sample", 
            ylab=expression(P(X==x)), 
            col="deepskyblue3", las=1)
    grid()
  })
  
  output$med_var <- renderText({
    p <- input$m / (input$m + input$n)
    esperanza <- input$k * p
    varianza <- input$k * p * (1-p) * (input$m+input$n-input$k) / (input$m+input$n-1)
    paste(c("For this configuration E(X) =", round(esperanza, 2),
            "and Var(X) =", round(varianza, 2)))
  })
  
})
