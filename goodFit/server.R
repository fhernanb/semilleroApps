library(shiny)
require(gamlss)

shinyServer(function(input,output,session){
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "product",
                      choices = names(dt))
    updateSelectInput(session, "familia")
  })
  require(gamlss)
  f1<-function(k,f,p){
    m <- fitDist(dt[,p], type=f, k=k)
    par(mfrow=c(2, 2))
    for(i in 1:4){
      denst <- density(dt[,p])
      res <- histDist(dt[,p], family=names(m$fits)[i],
                      main=names(m$fits)[i],
                      xlab=p,
                      line.wd=3,
                      line.ty=1,
                      line.col='dodgerblue2',
                      ylim=c(0, (1.3 * max(denst$y))))
      param <- c('mu', 'sigma', 'nu', 'tau') 
      np <- length(res$parameters)
      fun1 <- function(x) eval(parse(text=x))
      hat.param <- sapply(as.list(paste('res$',
                                        param[1:np], 
                                        sep='')),fun1)
      hat.param <- round(hat.param, digits=2)
      txt <- paste('hat(', param[1:np], ')==', hat.param, sep='')
      txt <- paste(txt, collapse=', ')
      legend('topright', bty='n',
             legend=eval(parse(text=paste('expression(', txt, ')'))))
    }
  }
  output$distPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile))
      dt <- read.table('datos.txt', header=T, sep='\t')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)

    f1 <- function(k, f, p){
      m <- fitDist(dt[, p], type=f, k=k)
      par(mfrow=c(2, 2), bg='gray98')
      for(i in 1:4){
        denst <- density(dt[, p])
        res <- histDist(dt[, p], family=names(m$fits)[i],
                        main=names(m$fits)[i], ylab='Densidad',
                        xlab=p, las=1,
                        line.wd=3,
                        line.ty=1,
                        line.col='dodgerblue2',
                        ylim=c(0, (3 * max(denst$y))))
        param <- c('mu', 'sigma', 'nu', 'tau') 
        np <- length(res$parameters)
        fun1 <- function(x) eval(parse(text=x))
        hat.param <- sapply(as.list(paste('res$',
                                          param[1:np], 
                                          sep='')),fun1)
        hat.param <- round(hat.param, digits=2)
        txt <- paste('hat(', param[1:np], ')==', hat.param, sep='')
        txt <- paste(txt, collapse=', ')
        legend('topright', bty='n',
               legend=eval(parse(text=paste('expression(', txt, ')'))))
      }
    }
    f1(input$k,input$familia,input$product)
  })
  
  output$descarga1<-downloadHandler(
    filename=function(){
      paste("grafica", "png",sep=".")}, content=function(file){
        png(file)
        print(f1(input$k,input$familia,input$product))
        dev.off()
      }
  )
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('Teoria.Rmd', quiet = TRUE)))
  })
})