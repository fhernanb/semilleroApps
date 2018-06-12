library(shiny)
library(latex2exp)

#Funcion interceptos aleatorios

plotbo <-  function (mgrupos, nmuestras, beta0, beta1, sigma2, sigma2b0){
  
  set.seed(1234) 
  
  grupo.Total = factor(rep(1:mgrupos, each = nmuestras))
  n = length(grupo.Total) #( es lo mismo que n = mgrupos*nmuestras )
  
  intcept.Aleatorio = rnorm(mgrupos, sd = sqrt(sigma2b0)) # Este es bo intercepto aleatorio
  er = rnorm(n, mean = 0, sd = sqrt(sigma2))  #Este es el vector de errores
  x = runif(n, 0, 10)
  y = beta0 + beta1 * x + intcept.Aleatorio[grupo.Total] + er
  
  d = data.frame(x, y, grupo.Total)
  
  
  
  library(ggplot2)
  a = ggplot(d, aes(x, y, color = grupo.Total) ) + geom_point() + labs(colour = "Grupo / Cluster") # + ggtitle(TeX('\\textbf{$\\beta_{0}+\\beta_{1}X+\\sigma_{b_{0}}^2  x^\\alpha$}'))    #+labs(colour = "Legend Title") Para cambiar el nombre de grupo.Total a Grupo/Cluster en el título de la leyenda 
  
  
  return(a)
  
}





shinyServer(function(input, output) 
{
  
  output$grafico1 <- renderPlot({
    
    ph <- plotbo(input$mgrupos,input$nmuestras,input$beta0,input$beta1,input$sigma2,input$sigma2b0)
    
    return(ph)
    
    
    
  })
  
  
  
})

