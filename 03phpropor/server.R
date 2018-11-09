library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header,
                        sep=input$sep)
    
    updateSelectInput(session, "variable", 
                      choices=names(dt[!sapply(dt, is.numeric)])) # Asegurar cuali

    updateSelectInput(session, "niveles", choices=dt[, 1])
  })
  
  output$inputData <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
    res <- table(dt[, input$variable])
    res
  }, align='c')
  



})
