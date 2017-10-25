library(shiny)
shinyServer(function(input,output,session){
        
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "variable", choices=names(dt))
  })
        
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    res <- data.frame(Min=min(y), Varianza=var(y), Max=max(y), 
                      n=length(y))
    res
  })
  
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    par(mfrow=c(1, 2), bg='gray98')
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    hist(y, col='deepskyblue3', freq=F, las=1,
         xlab=as.character(input$variable), 
         main='Histograma y densidad', ylab='Densidad')
    lines(density(y), lwd=4, col='firebrick3')
    qqnorm(y, las=1, main='QQplot',
           pch=19, col='deepskyblue3',
           ylab=as.character(input$variable))
    qqline(y)
    ks <- ks.test(x=y, y=pnorm)
    legend('topleft', bty='n', col='red', text.col='deepskyblue3',
    legend=paste('Valor P=', round(ks$p.value,2)))
  })
  
  output$inputData <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    require(usefultools)
    ph <- Var.test(x=y, alternative=input$h0, null.value=input$sigma20, 
                 conf.level=input$alfa)
    conclusion <- ifelse(ph$p.value < 0.05, 'es rechazada',
                         'no es rechazada')
    paste0('El estadístico de prueba es ', round(ph$statistic, 2),
           ' con un valor-P de ', round(ph$p.value, 4), ', por esta razón
            se puede concluir que, dada la información de la muestra, 
            la hipótesis nula ', conclusion, 
           ' (a un nivel de significancia del 5%).')
  })
  
  output$resul2 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    require(usefultools)
    ph <- Var.test(x=y, alternative=input$h0, null.value=input$sigma20, 
                   conf.level=input$alfa)
    intervalo <- paste("(", round(ph$conf.int[1], digits=4), ", ",
                       round(ph$conf.int[2], digits=4), ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para la varianza poblacional es ', intervalo)
  })
        
  output$miteoria <- renderUI({
    HTML(markdown::markdownToHTML(knit(input='incluede.md', quiet = TRUE)))
  })

})

