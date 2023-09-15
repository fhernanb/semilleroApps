library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    # Revisando si la suma es igual a 1
    
    # input <- NULL
    # input$min <- 0
    # input$max <- 4
    # input$pmf <- "f(x)=(2*x+1)/25"
    
    a <- input$min
    b <- input$max
    pmf <- input$pmf
    pmf <- gsub(" ", "", pmf)
    pmf <- substr(pmf, start=6, stop=nchar(pmf))
    funcion <- function(x) eval(parse(text=pmf))
    
    x_vals <- a:b
    n <- length(x_vals)
    probs <- numeric(n)
    for (i in 1:n) 
      probs[i] <- funcion(x_vals[i])
    suma <- sum(probs)
    
    if (input$min > input$max | suma > 1.02 | suma < 0.98) {
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
      plot(x=x_vals, y=probs, las=1,
           xlab="X", ylab="Probabilidad",
           type="h", lwd=5, col="steelblue")
      grid()
    }
  })
  
  output$med_var <- renderText({
    a <- input$min
    b <- input$max
    pmf <- input$pmf
    pmf <- gsub(" ", "", pmf)
    pmf <- substr(pmf, start=6, stop=nchar(pmf))
    funcion <- function(x) eval(parse(text=pmf))
    
    x_vals <- a:b
    n <- length(x_vals)
    probs <- numeric(n)
    for (i in 1:n) 
      probs[i] <- funcion(x_vals[i])
    
    esperanza <- sum(x_vals * probs)
    varianza <- sum((x_vals - esperanza)^2 * probs)
    
    suma <- sum(probs)
    
    if (input$min > input$max | suma > 1.02 | suma < 0.98) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste(c("Para la función ingresada se tiene que E(X) =",
              round(esperanza, 2),
              "con Var(X) =", round(varianza, 2)))
    }

    
  })
  
})