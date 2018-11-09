library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "variable1",
                      choices=names(dt[!sapply(dt, is.factor)])) # Asegurar cuanti
    updateSelectInput(session, "variable2", 
                      choices=names(dt[sapply(dt, is.factor)])) # Asegurar cuali
  })
  
  output$summary <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt <- na.omit(dt)  # Para eliminar obs con NA
    dt
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt <- na.omit(dt)  # Para eliminar obs con NA
    x <- dt[, input$variable1]  # Variable de interes
    group <- dt[, input$variable2]  # Variable de clasificacion
    if (nlevels(group) != 2) group <- dt[, sapply(dt, is.factor)]
    xx <- split(x, group)  # Lista con variable interes
    resumen <- function(x) c(mean(x), var(x), length(x))
    res <- sapply(xx, resumen)
    rownames(res) <- c('Media', 'Varianza', 'n')
    t(res)
  },
  rownames = TRUE) # Para obtener tabla con rownames
  
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    # Aqui inicia la figura
    par(mfrow=c(1, 2), bg='gray98')
    dt <- na.omit(dt)  # Para eliminar obs con NA
    x <- dt[, input$variable1]
    group <- dt[, input$variable2]
    if (nlevels(group) != 2) group <- dt[, sapply(dt, is.factor)]
    # Para dibujar las densidades
    xx <- split(x, group)
    den <- lapply(xx, density)
    plot(den[[1]], lwd=4, col='deepskyblue3',
         main='Densidad', las=1,
         xlab=as.character(input$variable1),
         ylab='Densidad',
         xlim=range(range(den[[1]]$x), range(den[[2]]$x)),
         ylim=c(0, max(c(den[[1]]$y, den[[2]]$y))))
    lines(den[[2]], lwd=4, col='firebrick3')
    
    # Leyenda para distiguir las densidades
    legend('topright', bty='n',
           lwd=4, 
           col=c('deepskyblue3', 'firebrick3'),
           legend=unique(group))
    
    # Para dibujar los qqplot
    qq1 <- qqnorm(xx[[1]], plot.it=FALSE)
    qq2 <- qqnorm(xx[[2]], plot.it=FALSE)
    
    plot(qq1, las=1, main='QQplot',
         pch=19, col='deepskyblue3',
         xlim=range(c(qq1$x, qq2$x)),
         ylim=range(c(qq1$y, qq2$y)),
         xlab='Cuantiles teóricos N(0, 1)',
         ylab=as.character(input$variable1))
    points(qq2, pch=19, col='firebrick3')
    
    # Para construir los qqplot
    qqline(xx[[1]], col='deepskyblue3')
    qqline(xx[[2]], col='firebrick3')
    
    # Para incluir el valor P de Shapiro
    shapi <- lapply(xx, shapiro.test)
    leyenda <- c(paste('Valor P=', round(shapi[[1]]$p.value, 2)),
                 paste('Valor P=', round(shapi[[2]]$p.value, 2)))
    legend('topleft', bty='n',
           text.col=c('deepskyblue3', 'firebrick3'),
           legend=leyenda)
  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt <- na.omit(dt)  # Para eliminar obs con NA
    x <- dt[, input$variable1]
    group <- dt[, input$variable2]
    if (nlevels(group) != 2) group <- dt[, sapply(dt, is.factor)]
    xx <- split(x, group)
    ph <- t.test(x=xx[[1]], y=xx[[2]],
                 alternative=input$h0, 
                 mu=input$delta0, 
                 conf.level=input$alfa,
                 var.equal=input$var.equal)
    conclusion <- ifelse(ph$p.value < 0.05, 'se rechaza', 'no se rechaza')
    paste0('El estadístico de prueba es t0=', round(ph$statistic, 4),
           ' con un valor-P de ', round(ph$p.value, 4), ', 
           por lo tanto se concluye
           que, basados en la evidencia muestral, 
           la hipótesis nula ', conclusion,
           ' (nivel de significancia del 5%).')
  })
  
  
   output$resul2 <- renderText({
     inFile <- input$file1
     if(is.null(inFile)) 
       dt <- read.table('unequal_var_data.txt', header=T, sep='\t')
     else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
     dt <- na.omit(dt)  # Para eliminar obs con NA
     x <- dt[, input$variable1]
     group <- dt[, input$variable2]
     if (nlevels(group) != 2) group <- dt[, sapply(dt, is.factor)]
     xx <- split(x, group)
     ph <- t.test(x=xx[[1]], y=xx[[2]],
                  alternative=input$h0, 
                  mu=input$delta0, 
                  conf.level=input$alfa,
                  var.equal=input$var.equal)
    intervalo <- paste("(", round(ph$conf.int[1], digits=4),
                       ", ",
                       round(ph$conf.int[2], digits=4),
                       ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para la diferencia de medias poblacionales es ',
           intervalo)
  })
   
   output$miteoria <- renderUI({
     HTML(markdown::markdownToHTML(knit(input='teoria.md', quiet = TRUE)))
   })

  

})
