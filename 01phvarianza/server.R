library(shiny)
source('var.test.R')

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
    res <- data.frame(Min=min(y), Var=var(y), 
                      Max=max(y), n=length(y))
    colnames(res) <- c('Mínimo', 'Varianza', 'Máximo', 'Número obs')
    res
  }, align='c', bordered=TRUE)
  
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
    ph <- var.test(x=y, alternative=input$h0, 
                     null.value=input$sigma20, 
                     conf.level=input$alfa)
    paste0('El estadístico de prueba es ', round(ph$statistic, 2),
           ' con un valor-P de ', round(ph$p.value, 4), '.')
  })
  
  output$resul2 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('var_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    ph <- var.test(x=y, alternative=input$h0,
                     null.value=input$sigma20, 
                     conf.level=input$alfa)
    intervalo <- paste("(", round(ph$conf.int[1], digits=4), ", ",
                       round(ph$conf.int[2], digits=4), ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para la varianza poblacional es ', intervalo)
  })
        
  output$miteoria <- renderUI({
    HTML(markdown::markdownToHTML(knit(input='include.md', quiet=TRUE)))
  })

})

