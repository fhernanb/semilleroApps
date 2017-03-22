library(shiny)
library(knitr)
library(png)
library(markdown)


shinyServer(function(input, output, session) {
  
  # Botones de Origen de las distribuciones donde aloja los nombres y las distribuciones a usar.
    

  output$TLC <- renderPlot({

    k <- 1000  # numero de muestras y es FIJO
    n <- input$n

    if(input$distri == "Normal") {
      muestras <- matrix(rnorm(k*n, input$media, input$desvi), nrow=k)
      media <- input$media
      varia <- input$desvi ^ 2
    }
    
    if(input$distri == "Uniforme") {
      muestras <- matrix(runif(k*n, input$min, input$max), nrow=k)
      media <- (input$min + input$max) / 2
      varia <- (input$max + input$min)^2 / 12
    }
    
    if(input$distri == "Gamma") {
      muestras <- matrix(rgamma(k*n, shape=input$shape, scale=input$scale), nrow=k)
      media <- input$shape * input$scale
      varia <- input$shape * input$scale^2
    }
    
    if(input$distri == "Beta") {
      muestras <- matrix(rbeta(k*n, input$shape1, input$shape2), nrow=k)
      a <- input$shape1
      b <- input$shape2
      media <- a / (a + b)
      varia <-  a * b / ((a + b)^2 * (a + b + 1))
    }
    
    medias <- rowMeans(muestras)
    s2n <- varia/n  # Varianza de la distribucion de medias
    
    par(mfrow=c(2, 1), bg='gray98')
    
    hist(medias, breaks=30, freq=FALSE,
         xlab=expression(bar(x)), las=1, ylab='Densidad',
         ylim=c(0, max(c(hist(medias, breaks=30, freq=FALSE, plot=F)$density,
                dnorm(media, media, sqrt(s2n))))),
         xlim=media + c(-4, 4) * sqrt(s2n),
         main='Distribucion de las 1000 medias muestrales')
    
    curve(dnorm(x, mean=media, sd=sqrt(varia/n)),
          add=T, lwd=3, col='dodgerblue3')
    nom <- paste('N(', round(media, 2), ', ', round(s2n, 2),')', sep='')
    legend('topright', legend=nom, lwd=3, col='dodgerblue3', bty='n')
    
    qqnorm(medias, las=1, main='QQplot para las 1000 medias muestrales',
           pch=1, col='dodgerblue3')
    qqline(medias)
    shapi <- shapiro.test(medias)
    legend('topleft', bty='n', col='red', text.col='dodgerblue3',
           legend=paste('Prueba Shapiro Valor P=', round(shapi$p.value, 4)))


  })
  
  ##################################################################
  
  
  # Generate an HTML table view of the data
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('Teoria.Rmd',quiet = TRUE)))
  })
})


