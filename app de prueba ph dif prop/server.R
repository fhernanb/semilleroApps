library(shiny)
shinyServer(function(input,output,session){
  
  dt1 <- reactive({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header,
                        sep=input$sep)
  })
  
  dt2 <- reactive({
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header,
                         sep=input$sep)
  })
  
  observe({
    updateSelectInput(session, "variable", choices=names(dt1())) 
  })
  
  observe({
    updateSelectInput(session, "variable", choices=names(dt2())) 
  })
  
  observeEvent(input$variable, {
    column_levels <- as.character(sort(unique(dt1()[[input$variable]])))
    updateSelectInput(session, "niveles", choices = column_levels)
  })
  
  observeEvent(input$variable, {
    column_levels <- as.character(sort(unique(dt2()[[input$variable]])))
    updateSelectInput(session, "niveles", choices = column_levels)
  })
  
  output$inputData1 <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt1
  })
  
  output$inputData2 <- renderTable({
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    dt2
  })
  
  output$consolidado <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    y1 <- na.omit(dt1[, input$variable])  # Para sacar los NA de la variable
    y2 <- na.omit(dt2[, input$variable])
    
    tabla1 <- table(y1)
    tabla2 <- table(y2)
    
    x1 <- tabla1[input$niveles]
    x2 <- tabla2[input$niveles]
    
    n1 <- sum(tabla1)
    n2 <- sum(tabla2)
    
    res <- cbind(c(x1, x2), c(n1, n2), c(x1, x2)/c(n1, n2))
    colnames(res) <- c('Número de éxitos', 
                       'Número de casos', 
                       'Proporción observada')
    rownames(res) <- c('Base de datos # 1', 'Base de datos # 2')
    res
  }, align='c', rownames=TRUE, bordered=TRUE, digits=4)
  
  
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    # Creando la particion
    par(mfrow=c(1, 2))
    
    # Primer barplot
    Niveles <- na.omit(dt1[, input$variable])  # Para sacar los NA de la variable
    tabla <- table(Niveles)
    ptabla <- prop.table(tabla)
    xx <- barplot(ptabla, las=1, col='deepskyblue3',
                  ylab='Frecuencia relativa', 
                  xlab='Niveles', ylim=c(0, max(ptabla)+0.1),
                  main='Base de datos # 1')
    
    text(x=xx, y=ptabla, pos=3, cex=0.8, col="black",
         label=round(ptabla, 4))
    
    # Segundo barplot
    Niveles <- na.omit(dt2[, input$variable])  # Para sacar los NA de la variable
    tabla <- table(Niveles)
    ptabla <- prop.table(tabla)
    xx <- barplot(ptabla, las=1, col='deepskyblue3',
                  ylab='Frecuencia relativa', 
                  xlab='Niveles', ylim=c(0, max(ptabla)+0.1),
                  main='Base de datos # 2')
    
    text(x=xx, y=ptabla, pos=3, cex=0.8, col="black",
         label=round(ptabla, 4))

  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    y1 <- na.omit(dt1[, input$variable])  # Para sacar los NA de la variable
    y2 <- na.omit(dt2[, input$variable])
    
    tabla1 <- table(y1)
    tabla2 <- table(y2)
    
    x1 <- tabla1[input$niveles]
    x2 <- tabla2[input$niveles]
    
    n1 <- sum(tabla1)
    n2 <- sum(tabla2)
    
    ph <- prop.test(x=c(x1, x2), n=c(n1, n2),
                    alternative=input$h0, 
                    conf.level=input$alfa,
                    correct=input$correct)
    
    ph$statistic <- sign(ph$estimate[1] - ph$estimate[2]) * sqrt(ph$statistic)
    paste0('El estadístico de prueba es z0=', round(ph$statistic, 4),
           ' con un valor-P de ', round(ph$p.value, 2), '.')
})
  
  output$resul2 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt1 <- read.table('datos1.txt', header=T, sep='\t')
    else dt1 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    inFile <- input$file2
    if(is.null(inFile)) 
      dt2 <- read.table('datos2.txt', header=T, sep='\t')
    else dt2 <- read.csv(inFile$datapath, header=input$header, 
                         sep=input$sep)
    
    y1 <- na.omit(dt1[, input$variable])  # Para sacar los NA de la variable
    y2 <- na.omit(dt2[, input$variable])
    
    tabla1 <- table(y1)
    tabla2 <- table(y2)
    
    x1 <- tabla1[input$niveles]
    x2 <- tabla2[input$niveles]
    
    n1 <- sum(tabla1)
    n2 <- sum(tabla2)
    
    ph <- prop.test(x=c(x1, x2), n=c(n1, n2),
                    alternative=input$h0, 
                    conf.level=input$alfa,
                    correct=input$correct)
    
    intervalo <- paste("(", round(ph$conf.int[1], digits=4),
                       ", ",
                       round(ph$conf.int[2], digits=4),
                       ").", sep='')
    paste0('El intervalo de confianza del ', 100*input$alfa,
           '% para proporción poblacional es ',
           intervalo)
  })

})
