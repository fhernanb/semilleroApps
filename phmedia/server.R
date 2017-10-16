library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "variable", choices = names(dt))
  })
  
  output$summary <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    res <- data.frame(Mean=mean(y), Variance=var(y), n=length(y))
    res
  })
  
  output$distPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    par(mfrow=c(1, 2), bg='gray98')
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    hist(y, col='deepskyblue3', freq=F, las=1,
         xlab=as.character(input$variable),
         main='Histogram and density',
         ylab='Density')
    lines(density(y), lwd=4, col='firebrick3')
    qqnorm(y, las=1, main='QQplot',
           pch=19, col='deepskyblue3',
           ylab=as.character(input$variable))
    qqline(y)
    shapi <- shapiro.test(y)
    legend('topleft', bty='n', col='red', text.col='deepskyblue3',
           legend=paste('Valor P=', round(shapi$p.value,2)))
  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('means_data.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, conf.level=input$alfa)
    conclusion <- ifelse(ph$p.value < 0.05, 'it is rejected',
                         'it is not rejected')
    paste0('The statistic test was to=', round(ph$statistic, 2),
           ' with a p-value of', round(ph$statistic, 4), ', for this reason
            we can conclude that, given the sample information, the null 
            hypothesis ', conclusion, ' (with a signifance level 5%).')
  })
  
  
   output$resul2 <- renderText({
     inFile <- input$file1
     if(is.null(inFile)) 
       dt <- read.table('means_data.txt', header=T, sep='\t')
     else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, conf.level=input$alfa)
    intervalo <- paste("(", round(ph$conf.int[1], digits=4), ", ",
                       round(ph$conf.int[2], digits=4), ").", sep='')
    paste0('The confidence interval of ', 100*input$alfa,
           '% for the population mean is ', intervalo)
  })
   


  

})
