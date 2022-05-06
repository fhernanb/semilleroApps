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

par(mar=c(4.5, 5, 4.5, 13))
par(mar=c(15, 5, 4.5, 2))    # Esto se lo agrego Freddy

if(input$n > 200){
  cdf <- ecdf(replicate(n = 10000, muestras(200, input$gamma2)))
} else if (input$n < 2){
  cdf <- ecdf(replicate(n = 10000, muestras(2, input$gamma2)))
} else{
  if(is.integer(input$n) == FALSE){
    cdf <- ecdf(replicate(n = 10000, muestras(round(input$n), input$gamma2)))
  }else{
    cdf <- ecdf(replicate(n = 10000, muestras(input$n, input$gamma2)))
  }
}
#cdf <- ecdf(replicate(n = 10000, muestras(input$n, input$gamma2)))
if (input$gamma2 >= 1 & input$gamma2 <=10){
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = bquote("Empirical" ~ F[X[(1)]](x)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(input$gamma2-0.6, input$gamma2+3),
       las = 1)
  lines(cdf,
        xlim =  c(input$gamma2-0.6, input$gamma2+3),
        main = "",
        pch = '.',
        col = "steelblue2",
        lwd = 2.5)
  points(x = rep(input$gamma2, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
         col = "red", lwd = 2.5)
  if(input$n > 200){
    title(main = bquote(n == 200),
          cex.main = 2,
          col.main = "steelblue2")
  }else if(input$n < 2){
    title(main = bquote(n == 2),
          cex.main = 2,
          col.main = "steelblue2")
  }else{
    if(is.integer(input$n) == FALSE){
      title(main = bquote(n == .(round(input$n))),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      title(main = bquote(n == .(input$n)),
            cex.main = 2,
            col.main = "steelblue2")
    }
  }
  # title(main = bquote(n == .(input$n)),
  #       cex.main = 2,
  #       col.main = "steelblue2")
  
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(x = "bottom",
         inset = c(0, -0.80),
         par('usr')[2], par('usr')[4], 
         bty='n', xpd=NA,
         legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                           bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1,
         lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  segments(input$gamma2, 1, input$gamma2, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "red")
  segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "red")
  # Para gamma2+epsilon
  segments(input$gamma2 + input$epsilon2, cdf(input$gamma2 + input$epsilon2), 
           input$gamma2 + input$epsilon2, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(input$gamma2 + input$epsilon2), input$gamma2 + input$epsilon2,
           cdf(input$gamma2 + input$epsilon2), lwd = 2.5, 
           col = "gray0", 
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
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(input$gamma2-0.6, input$gamma2+3),
         las = 1)
    lines(cdf,
          xlim =  c(input$gamma2-0.6, input$gamma2+3),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(input$gamma2, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
     
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma2, 1, input$gamma2, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "red")
    segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde epsilon=0.05
    segments(input$gamma2 + 0.05, cdf(input$gamma2 + 0.05), 
             input$gamma2 + 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(input$gamma2 + 0.05), input$gamma2 + 0.05,
             cdf(input$gamma2 + 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(input$gamma2-0.6, input$gamma2+3),
         las = 1)
    lines(cdf,
          xlim =  c(input$gamma2-0.6, input$gamma2+3),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(input$gamma2, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
     
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma2, 1, input$gamma2, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, input$gamma2, 0, lwd = 2.5, col = "red")
    segments(input$gamma2, 1, input$gamma2+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde epsilon=0.55
    segments(input$gamma2 + 0.55, cdf(input$gamma2 + 0.55), 
             input$gamma2 + 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(input$gamma2 + 0.55), input$gamma2 + 0.55,
             cdf(input$gamma2 + 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
} else if (input$gamma2 < 1) {
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = bquote("Empirical" ~ F[X[(1)]](x)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(0.4, 4),
       las = 1)
  lines(cdf,
        xlim =  c(0.4, 4),
        main = "",
        pch = '.',
        col = "steelblue2",
        lwd = 2.5)
  points(x = rep(1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
         col = "red", lwd = 2.5)
  if(input$n > 200){
    title(main = bquote(n == 200),
          cex.main = 2,
          col.main = "steelblue2")
  }else if(input$n < 2){
    title(main = bquote(n == 2),
          cex.main = 2,
          col.main = "steelblue2")
  }else{
    if(is.integer(input$n) == FALSE){
      title(main = bquote(n == .(round(input$n))),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      title(main = bquote(n == .(input$n)),
            cex.main = 2,
            col.main = "steelblue2")
    }
  }
  # title(main = bquote(n == .(input$n)),
  #       cex.main = 2,
  #       col.main = "steelblue2")
   
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
         legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                           bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1,
         lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
  segments(1, 1, 1+40, 1, lwd = 2.5, col = "red")
  # Para gamma2+epsilon, donde gamma2=1
  segments(1 + input$epsilon2, cdf(1 + input$epsilon2), 1 + input$epsilon2, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(1 + input$epsilon2), 1 + input$epsilon2,
           cdf(1 + input$epsilon2), lwd = 2.5, 
           col = "gray0", 
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
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0.4, 4),
         las = 1)
    lines(cdf,
          xlim =  c(0.4, 4),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
    segments(1, 1, 1+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde gamma2=1 y epsilon=0.05
    segments(1 + 0.05, cdf(1 + 0.05), 1 + 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(1 + 0.05), 1 + 0.05,
             cdf(1 + 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0.4, 4),
         las = 1)
    lines(cdf,
          xlim =  c(0.4, 4),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
    segments(1, 1, 1+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde gamma2=1 y epsilon=0.55
    segments(1 + 0.55, cdf(1 + 0.55), 1 + 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(1 + 0.55), 1 + 0.55,
             cdf(1 + 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
} else {
  if (input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(1)]),
       ylab = bquote("Empirical" ~ F[X[(1)]](x)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(9.4, 13),
       las = 1)
  lines(cdf,
        xlim =  c(9.4, 13),
        main = "",
        pch = '.', 
        col = "steelblue2",
        lwd = 2.5)
  points(x = rep(10, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
         col = "red", lwd = 2.5)
  if(input$n > 200){
    title(main = bquote(n == 200),
          cex.main = 2,
          col.main = "steelblue2")
  }else if(input$n < 2){
    title(main = bquote(n == 2),
          cex.main = 2,
          col.main = "steelblue2")
  }else{
    if(is.integer(input$n) == FALSE){
      title(main = bquote(n == .(round(input$n))),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      title(main = bquote(n == .(input$n)),
            cex.main = 2,
            col.main = "steelblue2")
    }
  }
  # title(main = bquote(n == .(input$n)),
  #       cex.main = 2,
  #       col.main = "steelblue2")
  
  # legend("topleft", bty="n",
  #        legend = c(expression(F[X[(1)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
         legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                           bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1,
         lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
  segments(10, 1, 10+40, 1, lwd = 2.5, col = "red")
  # Para gamma2+epsilon, donde gamma2=10
  segments(10 + input$epsilon2, cdf(10 + input$epsilon2),
           10 + input$epsilon2, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(10 + input$epsilon2), 10 + input$epsilon2,
           cdf(10 + input$epsilon2), lwd = 2.5, 
           col = "gray0", 
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
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(9.4, 13),
         las = 1)
    lines(cdf,
          xlim =  c(9.4, 13),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(10, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
    segments(10, 1, 10+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde gamma2=10 y epsilon=0.05
    segments(10 + 0.05, cdf(10 + 0.05),
             10 + 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(10 + 0.05), 10 + 0.05,
             cdf(10 + 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(1)]),
         ylab = bquote("Empirical" ~ F[X[(1)]](x)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(9.4, 13),
         las = 1)
    lines(cdf,
          xlim =  c(9.4, 13),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(10, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
           col = "red", lwd = 2.5)
    if(input$n > 200){
      title(main = bquote(n == 200),
            cex.main = 2,
            col.main = "steelblue2")
    }else if(input$n < 2){
      title(main = bquote(n == 2),
            cex.main = 2,
            col.main = "steelblue2")
    }else{
      if(is.integer(input$n) == FALSE){
        title(main = bquote(n == .(round(input$n))),
              cex.main = 2,
              col.main = "steelblue2")
      }else{
        title(main = bquote(n == .(input$n)),
              cex.main = 2,
              col.main = "steelblue2")
      }
    }
    # title(main = bquote(n == .(input$n)),
    #       cex.main = 2,
    #       col.main = "steelblue2")
    
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(1)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,
           legend = sapply(c(bquote("Empirical" ~ F[X[(1)]](x)), 
                             bquote("Degenerated\ndistribution" ~ F(q))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1,
           lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
    segments(10, 1, 10+40, 1, lwd = 2.5, col = "red")
    # Para gamma2+epsilon, donde gamma2=10 y epsilon=0.55
    segments(10 + 0.55, cdf(10 + 0.55),
             10 + 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(10 + 0.55), 10 + 0.55,
             cdf(10 + 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
}


