library(shiny)

shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    # Revisando si la integral es igual a 1
    
    a <- input$min
    b <- input$max
    fdp <- input$fdp
    fdp <- substr(fdp, start=6, stop=nchar(fdp))
    fdp <- paste(fdp, ' * x^0')
    fun <- function(x) eval(parse(text=fdp))
    area <- integrate(fun, lower=a, upper=b)$value
    
    if (input$min > input$max | area > 1.1 | area < 0.9) {
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
      secuencia <- seq(input$min, input$max, length.out=1000)
      cord.x <- c(input$min, secuencia, input$max)
      cord.y <- c(0, fun(secuencia), 0)
      curve(fun, from=input$min, to=input$max, lwd=0, las=1,
            ylim=c(0, max(fun(secuencia))), ylab='f(x)')
      polygon(cord.x, cord.y, col='steelblue')
      curve(fun, from=input$min, to=input$max, lwd=6, col='darkblue',
            ylim=c(0, max(fun(secuencia))), add=TRUE)
      grid()
    }
  })
  
  output$med_var <- renderText({
    a <- input$min
    b <- input$max
    fdp <- input$fdp
    fdp <- substr(fdp, start=6, stop=nchar(fdp))
    fun <- function(x) eval(parse(text=fdp))
    f1 <- function(x) x * fun(x)
    esperanza <- integrate(f1, lower=a, upper=b)$value
    f2 <- function(x) x^2 * fun(x)
    varianza <- integrate(f2, lower=a, upper=b)$value
    varianza <- varianza - esperanza^2
    
    area <- integrate(fun, lower=a, upper=b)$value
    
    if (input$min > input$max | area > 1.02 | area < 0.98) {
      paste(c("Hay algo errado!!!"))
    }
    else {
      paste(c("Para la distribución ingresada se tiene que E(X) =",
              round(esperanza, 2),
              "con Var(X) =", round(varianza, 3)))
    }

    
  })
  
})