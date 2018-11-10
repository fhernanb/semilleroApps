library(shiny)
shinyServer(function(input,output,session){
  
  dt <- reactive({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header,
                        sep=input$sep)
  })
  
  observe({
    updateSelectInput(session, "variable", choices=names(dt())) 
  })
  
  observeEvent(input$variable, {
    column_levels <- as.character(sort(unique(dt()[[input$variable]])))
    updateSelectInput(session, "niveles1", choices = column_levels)
  })
  
  observeEvent(input$variable, {
    column_levels <- as.character(sort(unique(dt()[[input$variable]])))
    updateSelectInput(session, "niveles2", choices = column_levels)
  })
  
  output$inputData <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    Niveles <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    
    tabla <- table(Niveles)
    ptabla <- prop.table(tabla)
    xx <- barplot(ptabla, las=1, col='deepskyblue3',
                  ylab='Frecuencia relativa', 
                  xlab='Niveles', ylim=c(0, max(ptabla)+0.1))
    
    text(x=xx, y=ptabla, pos=3, cex=0.8, col="black",
         label=round(ptabla, 4))

  })
  
  output$resul1 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt <- na.omit(dt)  # Para eliminar obs con NA
    
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    tabla <- table(y)
    x1 <- tabla[input$niveles1]
    x2 <- tabla[input$niveles2]
    n <- rep(sum(tabla), 2)
    ph <- prop.test(x=c(x1, x2), n=n, alternative=input$h0, 
                    conf.level=input$alfa,
                    correct=input$correct)
    
    paste0('El estadístico de prueba es z0=', round(ph$statistic, 4),
           ' con un valor-P de ', round(ph$p.value, 2), '.')
})
  
  output$resul2 <- renderText({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt <- na.omit(dt)  # Para eliminar obs con NA
    
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    tabla <- table(y)
    x1 <- tabla[input$niveles1]
    x2 <- tabla[input$niveles2]
    n <- rep(sum(tabla), 2)
    ph <- prop.test(x=c(x1, x2), n=n, alternative=input$h0, 
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
