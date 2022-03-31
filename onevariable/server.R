library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile<-input$file1
    #print(inFile)
    if(is.null(inFile)) return(NULL)
    dt = read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "response", choices = names(dt))
    #updateSelectInput(session, "product", choices = names(dt))
  })
  
  output$summary <- renderTable({
    inFile<-input$file1
    #print(inFile)
    if(is.null(inFile)) dt <- cars
    else dt = read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt[1:3, ]
  })
  
  output$distPlot <- renderPlot({
    inFile<-input$file1
    par(mfrow=c(2, 2))
    dt = read.csv(inFile$datapath, header=input$header, sep=input$sep)
    hist(dt[, input$product], col='deepskyblue3', freq=F, las=1,
         xlab=as.character(input$product), main='Histograma y densidad',
         ylab='Densidad')
    lines(density(dt[, input$product]), lwd=4, col='firebrick3')
    plot(ecdf(dt[, input$product]), las=1, xlab=as.character(input$product), 
         main='Funcion de distribucion acumulada')
    qqnorm(dt[, input$product], las=1, main='QQplot',
           ylab=as.character(input$product))
    qqline(dt[, input$product])
    boxplot(dt[, input$product], las=1, ylab=as.character(input$product),
            main='Boxplot')
  })
  

})
