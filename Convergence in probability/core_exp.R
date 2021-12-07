# Funcion auxiliar para crear muestras exponencial

muestras <- function(ene, gamma2, lambda=1){
  if (gamma2 >= 1 & gamma2 <= 10){
    val.exp <- rexp(n=ene, rate = lambda) + gamma2
    minimo <- min(val.exp)} else if (gamma2 < 1){
    val.exp <- rexp(n=ene, rate = lambda) + 1
    minimo <- min(val.exp)} else {
      val.exp <- rexp(n=ene, rate = lambda) + 10
      minimo <- min(val.exp)
    }
  return(minimo)
}

#updateNumericInput(session, "gamma2", value = input$gamma2)

par(oma=c(0, 0, 0, 10))
cdf <- ecdf(replicate(n = 10000, muestras(input$n, input$gamma2)))
if (input$gamma2 >= 1 & input$gamma2 <=10){
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = expression(F[X[(1)]](x)),
       cex.lab=0.8,
       type='n', 
       ylim=c(0, 1),
       xlim = c(input$gamma2-0.1, input$gamma2+3))
  lines(cdf,
        xlim =  c(input$gamma2-0.1, input$gamma2+3),
        main = "",
        pch = '.', 
        las = 1,
        col = colorRampPalette(c('blue', 'white'))(25)[16],
        lwd = 2.5)
  
  title(main = bquote(n == .(input$n)),
        cex.main = 2,
        col.main = colorRampPalette(c('blue', 'white'))(25)[16])
  
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
         legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
         col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
         lty = c(1,4),
         lwd = 2.5)
  # Para la distribución degenerada 
  segments(input$gamma2, 1, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "gray38", lty = 4)
  # Para gamma2+epsilon
  segments(input$gamma2 + input$epsilon2, cdf(input$gamma2 + input$epsilon2), 
           input$gamma2 + input$epsilon2, 0, 
           lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
  segments(-20, cdf(input$gamma2 + input$epsilon2), input$gamma2 + input$epsilon2,
           cdf(input$gamma2 + input$epsilon2), lwd = 2, 
           col = colorRampPalette(c('blue', 'white'))(25)[10], 
           lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.3
  #segments(input$gamma2 + 0.3, cdf(input$gamma2 + 0.3), input$gamma2 + 0.3, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(input$gamma2 + 0.3), input$gamma2 + 0.3,
   #        cdf(input$gamma2 + 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
  #         lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.5
  #segments(input$gamma2 + 0.5, cdf(input$gamma2 + 0.5), input$gamma2 + 0.5, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(input$gamma2 + 0.5), input$gamma2 + 0.5,
  #         cdf(input$gamma2 + 0.5), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon2 < 0.05){
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(input$gamma2-0.1, input$gamma2+3))
    lines(cdf,
          xlim =  c(input$gamma2-0.1, input$gamma2+3),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma2, 1, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde epsilon=0.05
    segments(input$gamma2 + 0.05, cdf(input$gamma2 + 0.05), 
             input$gamma2 + 0.05, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(input$gamma2 + 0.05), input$gamma2 + 0.05,
             cdf(input$gamma2 + 0.05), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(input$gamma2-0.1, input$gamma2+3))
    lines(cdf,
          xlim =  c(input$gamma2-0.1, input$gamma2+3),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma2, 1, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde epsilon=0.55
    segments(input$gamma2 + 0.55, cdf(input$gamma2 + 0.55), 
             input$gamma2 + 0.55, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(input$gamma2 + 0.55), input$gamma2 + 0.55,
             cdf(input$gamma2 + 0.55), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  }
} else if (input$gamma2 < 1) {
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = expression(F[X[(1)]](x)),
       cex.lab=0.8,
       type='n', 
       ylim=c(0, 1),
       xlim = c(0.9, 4))
  lines(cdf,
        xlim =  c(0.9, 4),
        main = "",
        pch = '.', 
        las = 1,
        col = colorRampPalette(c('blue', 'white'))(25)[16],
        lwd = 2.5)
  
  title(main = bquote(n == .(input$n)),
        cex.main = 2,
        col.main = colorRampPalette(c('blue', 'white'))(25)[16])
  
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
         legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
         col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
         lty = c(1,4),
         lwd = 2.5)
  # Para la distribución degenerada 
  segments(1, 1, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(-20, 0, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(1, 1, 1+40, 1, lwd = 2.5, col = "gray38", lty = 4)
  # Para gamma2+epsilon, donde gamma2=1
  segments(1 + input$epsilon2, cdf(1 + input$epsilon2), 1 + input$epsilon2, 0, 
           lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
  segments(-20, cdf(1 + input$epsilon2), 1 + input$epsilon2,
           cdf(1 + input$epsilon2), lwd = 2, 
           col = colorRampPalette(c('blue', 'white'))(25)[10], 
           lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.3
  #segments(1 + 0.3, cdf(1 + 0.3), 1 + 0.3, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(1 + 0.3), 1 + 0.3,
  #         cdf(1 + 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
  #         lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.5
  #segments(1 + 0.5, cdf(1 + 0.5), 1 + 0.5, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(1 + 0.5), 1 + 0.5,
  #         cdf(1 + 0.5), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon2 < 0.05){
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0.9, 4))
    lines(cdf,
          xlim =  c(0.9, 4),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(1, 1, 1+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde gamma2=1 y epsilon=0.05
    segments(1 + 0.05, cdf(1 + 0.05), 1 + 0.05, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(1 + 0.05), 1 + 0.05,
             cdf(1 + 0.05), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0.9, 4))
    lines(cdf,
          xlim =  c(0.9, 4),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(1, 1, 1+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde gamma2=1 y epsilon=0.55
    segments(1 + 0.55, cdf(1 + 0.55), 1 + 0.55, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(1 + 0.55), 1 + 0.55,
             cdf(1 + 0.55), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  }
} else {
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = expression(F[X[(1)]](x)),
       cex.lab=0.8,
       type='n', 
       ylim=c(0, 1),
       xlim = c(9.9, 13))
  lines(cdf,
        xlim =  c(9.9, 13),
        main = "",
        pch = '.', 
        las = 1,
        col = colorRampPalette(c('blue', 'white'))(25)[16],
        lwd = 2.5)
  
  title(main = bquote(n == .(input$n)),
        cex.main = 2,
        col.main = colorRampPalette(c('blue', 'white'))(25)[16])
  
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
         legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
         col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
         lty = c(1,4),
         lwd = 2.5)
  # Para la distribución degenerada 
  segments(10, 1, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(-20, 0, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
  segments(10, 1, 10+40, 1, lwd = 2.5, col = "gray38", lty = 4)
  # Para gamma2+epsilon, donde gamma2=10
  segments(10 + input$epsilon2, cdf(10 + input$epsilon2),
           10 + input$epsilon2, 0, 
           lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
  segments(-20, cdf(10 + input$epsilon2), 10 + input$epsilon2,
           cdf(10 + input$epsilon2), lwd = 2, 
           col = colorRampPalette(c('blue', 'white'))(25)[10], 
           lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.3
  #segments(10 + 0.3, cdf(10 + 0.3), 10 + 0.3, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(10 + 0.3), 10 + 0.3,
  #         cdf(10 + 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
  #         lty = 3)
  # Para gamma2+epsilon, donde epsilon=0.5
  #segments(10 + 0.5, cdf(10 + 0.5), 10 + 0.5, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(10 + 0.5), 10 + 0.5,
  #         cdf(10 + 0.5), lwd = 2, 
  #        col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon2 < 0.05){
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(9.9, 13))
    lines(cdf,
          xlim =  c(9.9, 13),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(10, 1, 10+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde gamma2=10 y epsilon=0.05
    segments(10 + 0.05, cdf(10 + 0.05),
             10 + 0.05, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(10 + 0.05), 10 + 0.05,
             cdf(10 + 0.05), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = expression(F[X[(1)]](x)),
         cex.lab=0.8,
         type='n', 
         ylim=c(0, 1),
         xlim = c(9.9, 13))
    lines(cdf,
          xlim =  c(9.9, 13),
          main = "",
          pch = '.', 
          las = 1,
          col = colorRampPalette(c('blue', 'white'))(25)[16],
          lwd = 2.5)
    
    title(main = bquote(n == .(input$n)),
          cex.main = 2,
          col.main = colorRampPalette(c('blue', 'white'))(25)[16])
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = c(expression(F[X[(1)]](x)), bquote("Degenerated dist." ~ F(q))),
           col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray38"),
           lty = c(1,4),
           lwd = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "gray38", lty = 4)
    segments(10, 1, 10+40, 1, lwd = 2.5, col = "gray38", lty = 4)
    # Para gamma2+epsilon, donde gamma2=10 y epsilon=0.55
    segments(10 + 0.55, cdf(10 + 0.55),
             10 + 0.55, 0, 
             lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[10], lty = 3)
    segments(-20, cdf(10 + 0.55), 10 + 0.55,
             cdf(10 + 0.55), lwd = 2, 
             col = colorRampPalette(c('blue', 'white'))(25)[10], 
             lty = 3)
  }
}


