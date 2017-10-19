library(shiny)
shinyServer(function(input,output,session){
        
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
    else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    prueba_hip_varianza(variable = y, varianza_h_n = input$sigma20, 
                        nivel_significancia = input$alfa,
                        tipo_de_prueba = input$h0)
    })
        
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('geardata.txt', 
                       col.names=c("diameter", "batch_number"))
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "variable", choices=names(dt))
  })
        
  output$summary <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('geardata.txt', 
                       col.names=c("diameter", "batch_number"))
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
        
  output$appPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
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
    shapi <- shapiro.test(y)
    legend('topleft', bty='n', col='red', text.col='deepskyblue3',
    legend=paste('Valor P=', round(shapi$p.value,2)))
  })
        
  output$miteoria <- renderUI({
    HTML(markdown::markdownToHTML(knit(input='incluede.md', quiet = TRUE)))
  })

})

