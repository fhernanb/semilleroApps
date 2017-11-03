library(shiny)

shinyServer(function(input, output, session){

  output$grafica <- renderPlot({
    
    if(input$tipo == "Proporcion"){
      N <- input$Nprop
      if (is.null(N)) N <- 500000000
      e <- input$eprop
      p <- input$p
      nc <- seq(from=0.90, to=0.99, by=0.01)
      z <- qnorm((1-nc)/2, lower.tail=F) 
      if (input$Ncp=='No') n <- z^2 * p * (1-p) / e^2
      if (input$Ncp=='Si') n <- N * z^2 * p * (1-p) / ((N-1) * e^2 + z^2 * p * (1-p))
      n <- ceiling(n)
      nc <- 100 * nc
      plot(x=nc, y=n, axes=F,
           cex=2, pch=19, col='deepskyblue3',
           xlab='Nivel de confianza (NC)',
           ylab='Tamaño de muestra',
           main=expression(Tamaño~de~muestra~para~estimar~P))
      Axis(side=1, at=nc)
      Axis(side=2, at=n, las=1)
      segments(x0=nc, y0=min(n), x1=nc, y1=n, lty='dotted', col=gray(0.5))
      segments(x0=min(nc), y0=n, x1=nc, y1=n, lty='dotted', col=gray(0.5))

    }
    
    if(input$tipo == "Media"){
      N <- input$Nmean
      e <- input$emean
      sigma <- input$sigma
      nc <- seq(from=0.90, to=0.99, by=0.01)
      z <- qnorm((1-nc)/2, lower.tail=F)
      if (input$Ncm=='No') n <- z^2 * sigma^2 / e^2
      if (input$Ncm=='Si') n <- N * z^2 * sigma^2 / ((N-1) * e^2 + z^2 * sigma^2)
      n <- ceiling(n)
      nc <- 100 * nc
      plot(x=nc, y=n, axes=F,
           cex=2, pch=19, col='deepskyblue3',
           xlab='Nivel de confianza (NC)',
           ylab='Tamaño de muestra',
           main=expression(Tamaño~de~muestra~para~estimar~mu))
      Axis(side=1, at=nc)
      Axis(side=2, at=n, las=1)
      segments(x0=nc, y0=min(n), x1=nc, y1=n, lty='dotted', col=gray(0.5))
      segments(x0=min(nc), y0=n, x1=nc, y1=n, lty='dotted', col=gray(0.5))
      
    }

  })


})
