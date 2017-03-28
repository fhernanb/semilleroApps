library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  f1 <- function(n,p){
    x <- 0:n
    Max <- 1.2 * max(dbinom(x=x, size=n, prob=p),
               dnorm(x=x, mean=n*p, sd=sqrt(n*p*(1-p))))
    plot(x=x,
         y=dbinom(x=x, size=n, prob=p), type='h', bty='n',
         ylim=c(0, Max), main="Distribución binomial", col="skyblue",
         las=1, lwd=5, ylab='Probabilidad', xlab='x', xaxt='n')
    
    axis(side=1, at=x, labels=x)
    
    lines(x=x, y=dnorm(x=x, mean=n*p, sd=sqrt(n*p*(1-p))), 
         col='red', lwd=3, type='b')
    
    position <- ifelse(p < 0.5, 'topright', 'topleft')
    legend(position,
           legend=c("Aproximación Normal","Distribución Binomial"),
           bty="n", lty=1, col=c("red","skyblue"), lwd=4)
  }
    
    f3 <- function(l){
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
  
    
    f2 <- function(n,p){
      x <- 0:n
      prob_binom <- dbinom(x=x, size=n, prob=p)
      prob_poiss <- dpois(x=x, lambda=n*p)
      Max <- max(c(prob_binom, prob_poiss))
      plot(x=x,
           y=prob_binom, type='h', col='black',
           las=1, lwd=7, ylab='Probabilidad', xlab='x',
           xlim=c(0, n), ylim=c(0, Max),frame.plot = FALSE)
      par(new=TRUE)
      plot(x=x,
           y=prob_poiss, type='h', col='skyblue', 
           las=1, lwd=3, ylab='', xlab='x',
           xlim=c(0, n), ylim=c(0, Max),frame.plot = FALSE)
    
    legend("topright",0,c("Aproximación Poisson","Distribución Binomial"),bty="n",
           lty = 1,col = c("skyblue","black"),
           lwd = 4)
  }
    f4<-function(m,n,k){
      x <- max(c(0,k-n)):min(c(k,m))
      prob_hyper <- dhyper(x=x,m=m,k=k,n=n)
      prob_binom <- dbinom(x=x, size=k, prob=m/(n+m))
      Max <- max(c(prob_binom, prob_hyper))
      plot(x=x,
           y=prob_hyper, type='h', col='black', 
           las=1, lwd=7, ylab='', xlab='x',
           xlim=c(0,max(x)), ylim=c(0, Max),frame.plot = FALSE)
      par(new=TRUE)
      plot(x=x,
           y=prob_binom, type='h', col='skyblue',
           las=1, lwd=3, ylab='Probabilidad', xlab='x',
           xlim=c(0,max(x)), ylim=c(0, Max),frame.plot = FALSE)
    legend("topright",0,c("Distribución Hipergeométrica","Aproximación Binomial"),
           bty="n",lty = 1,col = c("black","skyblue"),
           lwd = 4)
  }
  
  
  
  output$Grafica <- renderPlot({
    f1(input$n,input$p)
  })
  
  output$Grafica1 <- renderPlot({
    f3(input$l)
  })
  
  output$Grafica2 <- renderPlot({
    f2(input$n2,input$p2)
  })
  output$Grafica3 <- renderPlot({
    f4(input$m,input$n,input$k)
  })
})
