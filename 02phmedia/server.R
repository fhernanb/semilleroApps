library(shiny)

shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header,
                        sep=input$sep)
    updateSelectInput(session, "variable", choices=names(dt))
  })
  
  output$inputData <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    res <- data.frame(Media=mean(y), Varianza=var(y), n=length(y))
    res
  })
  
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    
    par(mfrow=c(1, 2), bg='gray98')
    hist(y, col='deepskyblue3', freq=F, las=1,
         xlab=as.character(input$variable),
         main='Histograma y densidad', ylab='Densidad')
    lines(density(y), lwd=4, col='firebrick3')
    qqnorm(y, las=1, main='QQplot', xlab='Cuantiles teóricos N(0, 1)',
           pch=19, col='deepskyblue3',
           ylab=as.character(input$variable))
    qqline(y)
    shapi <- shapiro.test(x=y)
    legend('topleft', bty='n', col='red', text.col='deepskyblue3',
           legend=paste('Valor P=', round(shapi$p.value, 2)))
  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, 
                 conf.level=input$alfa)
    paste0('El estadístico de prueba es to=', round(ph$statistic, 2),
           ' con un valor-P de ', round(ph$p.value, 4), '.')
  })
  
   output$resul2 <- renderText({
     inFile <- input$file1
     if(is.null(inFile)) 
       dt <- read.table('means_data.txt', header=T, sep='\t')
     else dt <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, 
                 conf.level=input$alfa)
    intervalo <- paste("(", round(ph$conf.int[1], digits=4), ", ",
                       round(ph$conf.int[2], digits=4), ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para la media poblacional es ', intervalo)
  })
   

})
