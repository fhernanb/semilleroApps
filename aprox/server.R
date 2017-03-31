library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  f1 <- function(n,p){
    x <- 0:n
    Max <- 1.2 * max(dbinom(x=x, size=n, prob=p),
               dnorm(x=x, mean=n*p, sd=sqrt(n*p*(1-p))))
    plot(x=x,
         y=dbinom(x=x, size=n, prob=p), type='h', bty='n',
         ylim=c(0, Max), col="skyblue",
         las=1, lwd=5, ylab='Probabilidad', xlab='x', xaxt='n')
    
    axis(side=1, at=x, labels=x)
    
    lines(x=x, y=dnorm(x=x, mean=n*p, sd=sqrt(n*p*(1-p))), 
         col='red', lwd=3, type='b')
    
    position <- ifelse(p < 0.5, 'topright', 'topleft')
    legend(position,
           legend=c("Aproximación Normal","Distribución Binomial"),
           bty="n", lty=1, col=c("red","skyblue"), lwd=4)
  }
    
    f2 <- function(l){
      x <- 0:(2*l)
      Max <- 1.2 * max(dpois(x=x, lambda=l),
                       dnorm(x=x, mean=l, sd=sqrt(l)))
      plot(x=x,
           y=dpois(x=x, lambda=l), type='h',
           ylim=c(0, Max),
           las=1, lwd=5, ylab='Probabilidad', xlab='x',
           col="skyblue", bty='n', xaxt='n')
      
      axis(side=1, at=x, labels=x)
      
      lines(x=x, y=dnorm(x=x, mean=l, sd=sqrt(l)), 
           col='red', lwd=3, type='b')
    
    legend("topright",0,c("Aproximación Normal","Distribución Poisson"),bty="n",
           lty = 1,col = c("red","skyblue"),
           lwd = 4)
  }
  
    
    f3 <- function(n,p){
      x <- 0:n
      prob_binom <- dbinom(x=x, size=n, prob=p)
      prob_poiss <- dpois(x=x, lambda=n*p)
      Max <- max(c(prob_binom, prob_poiss))
      plot(x=x,
           y=prob_binom, type='h', col='skyblue',
           las=1, lwd=7, ylab='Probabilidad', xlab='x', xaxt='n',
           xlim=c(0, n), ylim=c(0, Max), frame.plot = FALSE)
      
      axis(side=1, at=x, labels=x)
      
      par(new=TRUE)
      plot(x=x,
           y=prob_poiss, type='h', col='red', 
           las=1, lwd=3, ylab='', xlab='x',
           xlim=c(0, n), ylim=c(0, Max),frame.plot = FALSE)
    
      position <- ifelse(p < 0.5, 'topright', 'topleft')
      legend(position, legend=c("Aproximación Poisson","Distribución Binomial"),
           bty="n", lty = 1, col = c("red","skyblue"),
           lwd = 3)
  }
    
    f4 <- function(m, n, k){
      x <- max(c(0, k-n)) : min(c(k, m))
      prob_hyper <- dhyper(x=x, m=m, n=n, k=k)
      prob_binom <- dbinom(x=x, size=k, prob=m/(n+m))
      Max <- max(c(prob_binom, prob_hyper))
      plot(x=x, y=prob_hyper, type='h', col='skyblue',
           ylim=c(0, Max),
           las=1, lwd=7, ylab='Probabilidad', xlab='x', xaxt='n')
      axis(side=1, at=x, labels=x)
      
      par(new=TRUE)
      plot(x=x, y=prob_binom, type='h', col='red',
           las=1, lwd=3, xaxt='n', yaxt='n',
           xlab='', ylab='',
           xlim=range(x), ylim=c(0, Max), frame.plot = FALSE)
      
      p <- m / (m + n)
      position <- ifelse(p < 0.5, 'topright', 'topleft')
      legend(position,
             legend=c("Distribución hipergeométrica", "Aproximación binomial"),
             bty="n",lty = 1,col = c("skyblue","red"),
             lwd = 3)
  }
  
  
  
  output$Grafica1 <- renderPlot({
    f1(input$n,input$p)
  })
  
  output$Grafica2 <- renderPlot({
    f2(input$l)
  })
  
  output$Grafica3 <- renderPlot({
    f3(input$n2,input$p2)
  })
  
  output$Grafica4 <- renderPlot({
    f4(input$m,input$n,input$k)
  })
  
})
