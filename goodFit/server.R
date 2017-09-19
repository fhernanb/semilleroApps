library(shiny)
require(gamlss)

shinyServer(function(input, output, session){
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.table('datos.txt', header=T, sep='\t')
      #dt <- Cars93
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "response",
                      choices = names(dt))
    updateSelectInput(session, "familia")
  })
  


  output$distPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile))
      dt <- read.table('datos.txt', header=T, sep='\t')
      #dt <- Cars93
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)

    f1 <- function(k, f, p){
      mod <- fitDist(dt[, p], type=f, k=k)
      gaic <- round(mod$aic, 2)
      par(mfrow=c(2, 2), bg='gray98')
      for(i in 1:4){
        denst <- density(dt[, p])
        res <- histDist(dt[, p], family=names(mod$fits)[i],
                        main=paste(names(mod$fits)[i], 'with GAIC =', gaic), 
                        ylab='Densidad',
                        xlab=p, las=1,
                        line.wd=3,
                        line.ty=1,
                        line.col='dodgerblue2',
                        ylim=c(0, (3 * max(denst$y))))
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
    
    f1(input$k, input$familia, input$response)
  })
  
  output$descarga1<-downloadHandler(
    filename=function(){
      paste("grafica", "png",sep=".")}, content=function(file){
        png(file)
        print(f1(input$k,input$familia,input$response))
        dev.off()
      }
  )
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('Teoria.Rmd', quiet = TRUE)))
  })
})