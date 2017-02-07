library(shiny)
shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "variable", choices = names(dt))
  })
  
  output$summary <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) return(NULL)
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    dt[1:2, ]
  })
  
  output$statistic <- renderTable({
    inFile <- input$file1
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    y <- dt[, input$variable]
    res <- data.frame(Media=mean(y), Varianza=var(y), n=length(y))
  })
  
  output$distPlot <- renderPlot({
    inFile <- input$file1
    par(mfrow=c(1, 2))
    dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    hist(dt[, input$variable], col='deepskyblue3', freq=F, las=1,
         xlab=as.character(input$variable), main='Histograma y densidad',
         ylab='Densidad')
    lines(density(dt[, input$variable]), lwd=4, col='firebrick3')
    qqnorm(dt[, input$variable], las=1, main='QQplot',
           pch=19, col='deepskyblue3',
           ylab=as.character(input$variable))
    qqline(dt[, input$variable])
  })
  

})
