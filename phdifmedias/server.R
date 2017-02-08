library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "variable1", choices = names(dt))
    updateSelectInput(session, "variable2", choices = names(dt))
  })
  
  output$summary <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    x <- na.omit(dt[, input$variable1])
    y <- na.omit(dt[, input$variable2])
    res <- data.frame(Media1=mean(x), Varianza1=var(x), n1=length(x),
                      Media2=mean(y), Varianza1=var(y), n2=length(y))
  })
  
  output$distPlot <- renderPlot({
    inFile <- input$file1
    par(mfrow=c(1, 2))
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    x <- na.omit(dt[, input$variable1])
    y <- na.omit(dt[, input$variable2])
    denx <- density(x)
    deny <- density(y)
    plot(denx, lwd=3, col='deepskyblue3',
         xlim=range(range(denx$x), range(deny$x)),
         ylim=c(0, max(   c(denx$y, deny$y))),
         xlab='Variable',
         ylab='Densidad',
         main='Densidades')
    lines(deny, lwd=3, col='firebrick3')
    qqnorm(y, las=1, main='QQplot',
           pch=19, col='deepskyblue3',
           ylab=as.character(input$variable1))
    qqline(y)
    shapi <- shapiro.test(y)
    legend('topleft', bty='n', col='red', text.col='firebrick3',
           legend=paste('Valor P=', round(shapi$p.value,2)))
  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable1])
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, conf.level=input$alfa)
    conclusion <- ifelse(ph$p.value < 0.05, 'se rechaza.', 'no se rechaza.')
    paste0('El estadístico de prueba fue to=', round(ph$statistic, 2),
           ' con un valor P de ', round(ph$p.value, 2), ', por lo tanto se concluye
           que basados en la evidencia muestral la hipótesis nula ', conclusion)
  })
  
  
   output$resul2 <- renderText({
    inFile <- input$file1
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable1])
    ph <- t.test(x=y, alternative=input$h0, mu=input$mu0, conf.level=input$alfa)
    intervalo <- paste("(", ph$conf.int[1], ", ", ph$conf.int[2], ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para la media poblacional es ', intervalo)
  })
   
   output$miteoria <- renderUI({
     HTML(markdown::markdownToHTML(knit(input='teoria.md', quiet = TRUE)))
   })

  

})
