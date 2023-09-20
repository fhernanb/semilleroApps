library(shiny)

source("auxiliar.R")

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    
    res <- pmf(a=input$min, 
               b=input$max, 
               pmf=input$pmf)
    
    x_vals      <- res$x_vals
    probs       <- res$probs
    cumul_probs <- res$cumul_probs
    suma        <- res$suma
    
    if (input$min > input$max | suma > 1.01 | suma < 0.99) {
      
      plot(c(-5, 5), c(0, 1), xlab="", ylab="", type='n',
           xaxt='n', yaxt='n', bty='n')
      text(x=0, y=0.7, col='red', cex=2,
           label='Revise los valores que ingresó.')
      text(x=0, y=0.5, col='orange', cex=1.5,
           label=paste('La suma de las probabilidades es', suma))
      text(x=0, y=0.3, col='purple', cex=1,
           label='El mínimo no puede ser mayor que el máximo.')
    }
    else {
      par(mfrow=c(1, 2))
      
      # Para dibujar f(x)
      plot(x=x_vals, y=probs, las=1,
           xlab="X", ylab="f(x)",
           main="Función de masa",
           type="h", lwd=3, col="steelblue")
      grid()
      
      # Para dibujar F(x)
      F <- stepfun(x=x_vals, y=c(0, cumul_probs), right=TRUE)
      plot(F, verticals=FALSE,
           lwd=3, col="steelblue", las=1,
           xlab="X", ylab="F(x)",
           main="Función acumulada")
      grid()
    }
  })
  
  output$med_var <- renderText({
    
    res <- pmf(a=input$min, 
               b=input$max, 
               pmf=input$pmf)
    
    x_vals      <- res$x_vals
    probs       <- res$probs
    cumul_probs <- res$cumul_probs
    suma        <- res$suma
    
    esperanza <- sum(x_vals * probs)
    varianza <- sum((x_vals - esperanza)^2 * probs)
    
    if (input$min > input$max | suma > 1.01 | suma < 0.99) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste0(c("La v.a. X tiene E(X)=",
              round(esperanza, 4),
              "y Var(X)=", round(varianza, 4)))
    }
  })
  
  output$tabla_probs <- renderTable({

    res <- pmf(a=input$min, 
               b=input$max, 
               pmf=input$pmf)
    
    x_vals      <- res$x_vals
    probs       <- res$probs
    cumul_probs <- res$cumul_probs
    suma        <- res$suma
    
    if (input$min > input$max | suma > 1.01 | suma < 0.99) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      data.frame("X"=x_vals,
                 "f(x)"=probs,
                 "F(x)"=cumul_probs,
                 check.names = FALSE)
    }
  }, digits=6, bordered = TRUE, align = "c")
  
})