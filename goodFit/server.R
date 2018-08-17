library(shiny)
require(gamlss)

shinyServer(function(input, output, session){
  
  # Function to plot the four histograms
  four.hist <- function(k, f, p) {
    par(cex.main=0.95)
    inFile <- input$file1
    if(is.null(inFile))
      dt <- cars
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    mod <- fitDist(dt[, p], type=f, k=k)
    par(mfrow=c(2, 2), bg='gray98')
    for(i in 1:4){
      denst <- density(dt[, p])
      res <- histDist(dt[, p], family=names(mod$fits)[i],
                      main='', 
                      ylab='Density',
                      xlab=p, las=1,
                      line.wd=3,
                      line.ty=1,
                      line.col='dodgerblue2',
                      ylim=c(0, (2 * max(denst$y))))
      gaic <- round(-2 * logLik(res) + k * length(res$parameters), 2)
      title(main=paste(i, ')', names(mod$fits)[i], 
                       'distribution with GAIC=', gaic),
            col.main='blue4')
      param <- c('mu', 'sigma', 'nu', 'tau') 
      np <- length(res$parameters)
      fun1 <- function(x) eval(parse(text=x))
      hat.param <- sapply(as.list(paste('res$', param[1:np], sep='')), fun1)
      hat.param <- round(hat.param, digits=2)
      txt <- paste('hat(', param[1:np], ')==', hat.param, sep='')
      txt <- paste(txt, collapse=', ')
      legend('topright', bty='n',
             legend=eval(parse(text=paste('expression(', txt, ')'))))
    }
  }
  
  four.hist.qqplot <- function(k, f, p) {
    par(cex.main=0.95)
    inFile <- input$file1
    if(is.null(inFile))
      dt <- cars
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    mod <- fitDist(dt[, p], type=f, k=k)
    par(mfrow=c(4, 2), bg='gray98')
    for(i in 1:4){
      denst <- density(dt[, p])
      res <- histDist(dt[, p], family=names(mod$fits)[i],
                      main='', 
                      ylab='Density',
                      xlab=p, las=1,
                      line.wd=3,
                      line.ty=1,
                      line.col='dodgerblue2',
                      ylim=c(0, (2 * max(denst$y))))
      gaic <- round(-2 * logLik(res) + k * length(res$parameters), 2)
      title(main=paste(i, ')', names(mod$fits)[i], 
                       'distribution with GAIC=', gaic),
            col.main='blue4')
      param <- c('mu', 'sigma', 'nu', 'tau') 
      np <- length(res$parameters)
      fun1 <- function(x) eval(parse(text=x))
      hat.param <- sapply(as.list(paste('res$', param[1:np], sep='')), fun1)
      hat.param <- round(hat.param, digits=2)
      txt <- paste('hat(', param[1:np], ')==', hat.param, sep='')
      txt <- paste(txt, collapse=', ')
      legend('topright', bty='n',
             legend=eval(parse(text=paste('expression(', txt, ')'))))
      #qqnorm(runif(10))
      n <- dim(dt)[1]
      a <- paste('q', names(mod$fits)[i], sep='')
      a <- paste(a, '(ppoints(n),', sep='')
      a <- paste(a, paste(hat.param, collapse=', '),  ')')
      par(bty='n', col.axis='blue4', col.lab='blue4')
      qqplot(y=dt[, p], x=eval(parse(text=a)),
             xlab=a, ylab=p, col='blue4')
      axis(side=1, col='blue4')
      axis(side=2, col='blue4')
    }
  }
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- cars
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "response",
                      choices = names(dt))
    updateSelectInput(session, "familia")
  })
  
  output$data_table <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- cars
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  output$distPlot1 <- renderPlot({
    four.hist(input$k, input$familia, input$response)
  })
  
  output$distPlot2 <- renderPlot({
    four.hist.qqplot(input$k, input$familia, input$response)
  })
  
  output$downplot1 <- downloadHandler(
    filename =  function() {
      paste("four_dist", input$type_plot, sep=".")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      if(input$type_plot == "png")
        png(file) # open the png device
      else
        pdf(file) # open the pdf device
      four.hist(input$k, input$familia, input$response) # draw the plot
      dev.off()  # turn the device off
      
    } 
  )
  
  output$downplot2 <- downloadHandler(
    filename =  function() {
      paste("four_dist", input$type_plot, sep=".")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      if(input$type_plot == "png")
        png(file) # open the png device
      else
        pdf(file) # open the pdf device
      four.hist.qqplot(input$k, input$familia, input$response) # draw the plot
      dev.off()  # turn the device off
      
    } 
  )
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('Teoria.Rmd', quiet = TRUE)))
  })
})