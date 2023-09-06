library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    # Revisando si la suma es igual a 1
    
    # input <- NULL
    # input$min <- 0
    # input$max <- 4
    # input$fdp <- "f(x)=(2*x+1)/25"
    
    a <- input$min
    b <- input$max
    fdp <- input$fdp
    fdp <- substr(fdp, start=6, stop=nchar(fdp))
    fun <- function(x) eval(parse(text=fdp))
    suma <- sum(fun(a:b))
    
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
      x <- a:b
      probs <- fun(a:b)
      plot(x=x, y=probs, las=1,
           xlab="X", ylab="Probabilidad",
           type="h", lwd=5, col="steelblue")
      grid()
    }
  })
  
  output$med_var <- renderText({
    a <- input$min
    b <- input$max
    fdp <- input$fdp
    fdp <- substr(fdp, start=6, stop=nchar(fdp))
    fun <- function(x) eval(parse(text=fdp))
    x <- a:b
    probs <- fun(a:b)
    esperanza <- sum(x * probs)
    f2 <- function(x) x^2 * fun(x)
    varianza <- sum(x^2 * probs) - esperanza^2
    
    suma <- sum(fun(a:b))
    
    if (input$min > input$max | suma > 1.02 | suma < 0.98) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste(c("Para la distribución ingresada se tiene que E(X) =",
              round(esperanza, 2),
              "con Var(X) =", round(varianza, 2)))
    }

    
  })
  
})