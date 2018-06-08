library(shiny)


#Funcion interceptos y pendientes aleatorias (Correlación)

plotbob1 <-  function (mgrupos, nmuestras, beta0, beta1, sigma2b0, sigma2b1, sigma2, correlacion){
  
  #Para que mtx.Var.Cov sea definida positivamente debe cumplir: (si no, no funciona mvrnorm) 
  #det(mtx.Var.Cov)>0 es decir,  ((sigma2b0*sigma2b1)>(sigmab0b1)^2)
  
  
  # set.seed(1234)
  
  sigmab0b1 = correlacion * sqrt( sigma2b0 * sigma2b1 )
  
  grupo.Total = factor(rep(1:mgrupos, each=nmuestras))
  n = length(grupo.Total) #( es lo mismo que n = mgrupos*nmuestras )
  
  mtx.Var.Cov = matrix(c(sigma2b0, sigmab0b1, sigmab0b1, sigma2b1),2,2)
  mtx.Efectos.Aleatorios = MASS::mvrnorm(mgrupos, mu=c(0,0), Sigma=mtx.Var.Cov, empirical=TRUE)     # random effects
  
  er = rnorm(n, mean=0, sd= (sqrt(sigma2)))  #Este es el vector de errores
  x = runif(n, 0, 10)
  y = beta0 + mtx.Efectos.Aleatorios[grupo.Total,1] + (beta1 + mtx.Efectos.Aleatorios[grupo.Total,2]) * x  + er
  d = data.frame(x, y, grupo.Total)
  
  library(ggplot2)
  a = ggplot(d, aes(x, y, color = grupo.Total)) + geom_point() + labs(colour = "Grupo / Cluster")
  return(a)
  
}





shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    
    ph <- plotbob1(input$mgrupos,input$nmuestras,input$beta0,input$beta1,input$sigma2,input$sigma2b0,input$sigma2b1,input$correlacion)
    
    return(ph)
    
    
    
  })
  
  
  
})


