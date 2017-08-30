library(shiny)
library(plotly)


shinyServer(function(input,output,session){
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) dt <- read.table('datos.txt', header=T, sep='\t')
    else
    dt <-  read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "product", choices = names(dt))
  })
  
  output$distPlot <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) dt <- read.table('datos.txt', header=T, sep='\t')
    else
      dt <-  read.csv(inFile$datapath, header=input$header, sep=input$sep)
    x <- as.vector(dt[, input$product])

    Dist <- ifelse(input$Distribucion == 'Normal', 'norm',
                   ifelse(input$Distribucion == 'Weibull', 'weibull', 'gamma'))
    
    n.points <- 30
    sigmas <- 3
    
    ####
    loglik_function <- function(par1, par2) {
      eval(parse(text=paste('sum(d', Dist, '(x=x, par1, par2, log=T))', sep='')))
    }
    
    loglik_function <- Vectorize(loglik_function)
    
    require(MASS)
    if (Dist == 'norm')
      fit <- fitdistr(x, densfun='normal')
    if (Dist == 'weibull')
      fit <- fitdistr(x, densfun='weibull')
    if (Dist == 'gamma')
      fit <- fitdistr(x, densfun='gamma')

    par1 <- seq(from=fit$estimate[1]-sigmas*fit$sd[1], 
                to=fit$estimate[1]+sigmas*fit$sd[1], 
                length.out=n.points)
    par2 <- seq(from=fit$estimate[2]-sigmas*fit$sd[2], 
                to=fit$estimate[2]+sigmas*fit$sd[2], 
                length.out=n.points)
    
    loglik <- outer(par1, par2, loglik_function)
    
    # To create the colors
    # ---------------
    jet.colors <- colorRampPalette( c("blue", "green") )
    nbcol <- 100
    color <- jet.colors(nbcol)
    ncz <- ncol(loglik)
    nrz <- nrow(loglik)
    zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
    facetcol <- cut(zfacet, nbcol)
    # ---------------
    myplot <- persp(par1, par2, loglik, theta=30, phi=30, 
                    col=color[facetcol], ticktype = "detailed", nticks=4)
    
    mypoints <- trans3d(fit$estimate[1], fit$estimate[2], fit$loglik, pmat=myplot)
    points(mypoints, pch=19, col="red", cex=2)
    
    lines(trans3d(x=fit$estimate[1], y=par2[1:(n.points/2)],
                  z=min(loglik), pmat=myplot), col=2, lty=2)
    lines(trans3d(x=par1[-(1:(n.points/2))], y=fit$estimate[2],
                  z=min(loglik), pmat=myplot), col=2, lty=2)
    
    lines(trans3d(x=fit$estimate[1], y=fit$estimate[2],
                  z=sort(loglik), pmat=myplot), col=2, lty=2)
    

  })
  
  
  output$lateoria <- renderUI({
    HTML(markdown::markdownToHTML(knit('lateoria.txt', quiet = TRUE)))
  })
  
  
})
