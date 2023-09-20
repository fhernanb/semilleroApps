library(shiny)

source("auxiliar.R")

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({

    res <- pdf(a=input$min, 
               b=input$max, 
               cuantil=input$cuantil, 
               pdf=input$pdf)
    
    area <- res$area
    fun <- res$fun
    
    if (input$min > input$max | area > 1.01 | area < 0.99) {
      plot(c(-5, 5), c(0, 1), xlab="", ylab="", type='n',
           xaxt='n', yaxt='n', bty='n')
      text(x=0, y=0.7, col='red', cex=2,
           label='Revise los valores que ingresó.')
      text(x=0, y=0.5, col='orange', cex=1.5,
           label=paste('El área bajo la curva es', area))
      text(x=0, y=0.3, col='purple', cex=1,
           label='El mínimo no puede ser mayor que el máximo.')
    }
    else {
      
      par(mfrow=c(1, 2))
      
      # Para dibujar f(x)
      secuencia <- seq(input$min, input$max, length.out=1000)
      cord.x <- c(input$min, secuencia, input$max)
      cord.y <- c(0, fun(secuencia), 0)
      curve(fun, from=input$min, to=input$max, lwd=6, las=1,
            col="steelblue",
            ylim=c(0, max(fun(secuencia))),
            xlab="X", ylab="f(x)",
            main="Función de densidad")
      grid()
      
      # Para dibujar F(x)
      Fun <- function(x) 
        integrate(fun, lower=input$min, upper=x)$value
      Fun <- Vectorize(Fun)
      curve(Fun, from=input$min, to=input$max, lwd=6, las=1,
            col="steelblue",
            #ylim=c(0, max(fun(secuencia))), 
            xlab="X", ylab="F(x)",
            main="Función acumulada")
      grid()
      
    }
  })
  
  output$med_var <- renderText({

    res <- pdf(a=input$min, 
               b=input$max, 
               cuantil=input$cuantil, 
               pdf=input$pdf)
    
    area <- res$area
    fun <- res$fun
    
    f1 <- function(x) x * fun(x)
    esperanza <- integrate(f1, lower=input$min, upper=input$max)$value
    f2 <- function(x) x^2 * fun(x)
    varianza <- integrate(f2, lower=input$min, upper=input$max)$value
    varianza <- varianza - esperanza^2
    
    if (input$min > input$max | area > 1.01 | area < 0.99) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste0(c("La v.a. X tiene E(X)=",
               round(esperanza, 4),
               " y Var(X)=", 
               round(varianza, 4)
               ),
             collapse=""
            )
    }
  })
  
  output$prob_hasta_cuantil <- renderText({
    
    res <- pdf(a=input$min, 
               b=input$max, 
               cuantil=input$cuantil, 
               pdf=input$pdf)
    
    area <- res$area
    fun <- res$fun
    
    # Acumul
    Fun <- function(x) 
      integrate(fun, lower=input$min, upper=x)$value
    
    result_prob <- ifelse(input$cuantil <= input$min, 
                          0,
                          ifelse(input$cuantil > input$max, 
                                 1, 
                                 Fun(input$cuantil)))
    
    if (input$min > input$max | area > 1.01 | area < 0.99) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste0(c("P(X<=", input$cuantil, ")=",
               result_prob
      ),
      collapse=""
      )
    }
  })
  
})