library(shiny)
library(plotly)


shinyServer(function(input,output,session){
  
  observe({
    inFile<-input$file1
    if(is.null(inFile)) return(NULL)
    dt = read.csv(inFile$datapath, header=input$header, sep=input$sep)
    updateSelectInput(session, "product", choices = names(dt))
  })
  
  output$distPlot <- renderPlotly({
    inFile<-input$file1
    
    Dist <- ifelse(input$Distribucion == 'Normal', 'norm',
                   ifelse(input$Distribucion == 'Weibull', 'weibull', 'gamma'))
    
    n.points <- 30
    sigmas <- 3
    dt = read.csv(inFile$datapath, header=input$header, sep=input$sep)
    x <- as.vector(dt[, input$product])
    
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
    fit
    
    par1 <- seq(from=fit$estimate[1]-sigmas*fit$sd[1], 
                to=fit$estimate[1]+sigmas*fit$sd[1], 
                length.out=n.points)
    par2 <- seq(from=fit$estimate[2]-sigmas*fit$sd[2], 
                to=fit$estimate[2]+sigmas*fit$sd[2], 
                length.out=n.points)
    
    loglik <- outer(par1, par2, loglik_function)
    
    require(plotly)
    p <- plot_ly(z = loglik, x=par1, y=par2, type = "surface") %>%
      layout(title = "Log-likelihood curve",
             scene = list(
               xaxis = list(title = "Parameter 1"), 
               yaxis = list(title = "Parameter 2"), 
               zaxis = list(title = "Log-lik")))
    
    ggplotly(p)
  })
  
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('teoria.Rmd', quiet = TRUE)))
  })
  
  
})