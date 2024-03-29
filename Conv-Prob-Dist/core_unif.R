# Funcion auxiliar para crear muestras uniformes

muestras <- function(ene, gamma1){
  if (gamma1 >= 1 & gamma1 <= 10){
  val.uniformes <- runif(n = ene,
                         min = 0,
                         max = gamma1)
  maximo <- max(val.uniformes)} else if (gamma1 < 1) {
    val.uniformes <- runif(n = ene,
                           min = 0,
                           max = 1)
    maximo <- max(val.uniformes)} else {
    val.uniformes <- runif(n = ene,
                           min = 0,
                           max = 10)
    maximo <- max(val.uniformes)}
  return(maximo)
}

par(mar=c(8.5, 5, 4.5, 5))

if(input$n > 200){
  cdf <- ecdf(replicate(n = 10000, muestras(200, input$gamma1)))
}else if(input$n < 2){
  cdf <- ecdf(replicate(n = 10000, muestras(2, input$gamma1)))
}else{
  if(is.integer(input$n) == FALSE){
  cdf <- ecdf(replicate(n = 10000, muestras(round(input$n), input$gamma1)))
  }else{
  cdf <- ecdf(replicate(n = 10000, muestras(input$n, input$gamma1)))   
  }
}

#cdf <- ecdf(replicate(n = 10000, muestras(input$n, input$gamma1)))

if (input$gamma1 >= 1 & input$gamma1 <= 10){
  if (input$epsilon1 >= 0.05 & input$epsilon1 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(n)]),
       ylab = bquote("Empirical" ~ F[X[(n)]](t)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(0, input$gamma1*1.2),
       las = 1)
  lines(cdf,
        xlab = expression(x[(n)]),
        ylab = bquote("Empirical" ~ F[X[(n)]](t)),
        xlim = c(0, input$gamma1*1.2),
        main = "",
        pch = '.',
        col = "steelblue2",
        lwd = 2.5)
  points(x = rep(input$gamma1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
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
  #        legend = c(expression(F[X[(n)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend("bottom",
         inset = c(0, -0.4),
         #par('usr')[2], par('usr')[4], 
         bty='n', xpd=NA, horiz = TRUE,
         legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                           bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  #legend(x = "topright", inset = c(-0.35,0), bty='n', xpd=TRUE,
  #       legend = c(expression(F[X[(n)]](x)), bquote("Degenerated\ndistribution" ~ F(t))),
  #       col = c(colorRampPalette(c('blue', 'white'))(25)[16], "gray48"),
  #       lty = c(1,4),
  #       lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  
  segments(input$gamma1, 1, input$gamma1, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, input$gamma1, 0, lwd = 2.5, col = "red")
  segments(input$gamma1, 1, input$gamma1+3, 1, lwd = 2.5, col = "red")
  
  # Para gamma1-epsilon
  segments(input$gamma1 - input$epsilon1, cdf(input$gamma1 -input$epsilon1), 
           input$gamma1 - input$epsilon1, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(input$gamma1 - input$epsilon1), input$gamma1 - input$epsilon1,
           cdf(input$gamma1 - input$epsilon1), lwd = 2.5, 
           col = "gray0", 
           lty = 3)
  # Para gamma1-epsilon, donde epsilon=0.3 colorRampPalette(c('blue', 'white'))(25)[10]
  #segments(input$gamma1 - 0.3, cdf(input$gamma1 - 0.3), input$gamma1 - 0.3, 0, 
   #        lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(input$gamma1 - 0.3), input$gamma1 - 0.3,
  #         cdf(input$gamma1 - 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
   #        lty = 3)
  # Para gamma1-epsilon, donde epsilon=0.5
  #segments(input$gamma1 - 0.5, cdf(input$gamma1 - 0.5), input$gamma1 - 0.5, 0, 
   #        lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(input$gamma1 - 0.5), input$gamma1 - 0.5,
  #         cdf(input$gamma1 - 0.5), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon1 < 0.05){
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, input$gamma1*1.2),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, input$gamma1*1.2),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(input$gamma1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
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
    # 
    # legend("topleft", bty="n",
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom", 
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma1, 1, input$gamma1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, input$gamma1, 0, lwd = 2.5, col = "red")
    segments(input$gamma1, 1, input$gamma1+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde epsilon = 0.05
    segments(input$gamma1 - 0.05, cdf(input$gamma1 - 0.05), 
             input$gamma1 - 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(input$gamma1 - 0.05), input$gamma1 - 0.05,
             cdf(input$gamma1 - 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, input$gamma1*1.2),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, input$gamma1*1.2),
          main = "",
          pch = '.',
          col = "steelblue2",
          lwd = 2.5)
    points(x = rep(input$gamma1, 2), y = c(0, 1), pch = c(1, 19), cex = 1.5, 
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
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom", 
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(input$gamma1, 1, input$gamma1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, input$gamma1, 0, lwd = 2.5, col = "red")
    segments(input$gamma1, 1, input$gamma1+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde epsilon = 0.55
    segments(input$gamma1 - 0.55, cdf(input$gamma1 - 0.55), 
             input$gamma1 - 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(input$gamma1 - 0.55), input$gamma1 - 0.55,
             cdf(input$gamma1 - 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
} else if (input$gamma1 < 1){
  if (input$epsilon1 >= 0.05 & input$epsilon1 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(n)]),
       ylab = bquote("Empirical" ~ F[X[(n)]](t)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(0, 1.2),
       las = 1)
  lines(cdf,
        xlab = expression(x[(n)]),
        ylab = bquote("Empirical" ~ F[X[(n)]](t)),
        xlim = c(0, 1.2),
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
  #        legend = c(expression(F[X[(n)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend("bottom",
         inset = c(0, -0.4),
         #par('usr')[2], par('usr')[4], 
         bty='n', xpd=NA, horiz = TRUE,
         legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                           bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
  segments(1, 1, 1+3.5, 1, lwd = 2.5, col = "red")
  # Para gamma1-epsilon, donde gamma1=1
  segments(1 - input$epsilon1, cdf(1 - input$epsilon1), 1 - input$epsilon1, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(1 - input$epsilon1), 1 - input$epsilon1,
           cdf(1 - input$epsilon1), lwd = 2.5, 
           col = "gray0", 
           lty = 3)
  # Para gamma1-epsilon, donde gamma1=1 y epsilon=0.3
  #segments(1 - 0.3, cdf(1 - 0.3), 1 - 0.3, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(1 - 0.3), 1 - 0.3,
  #         cdf(1 - 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
  #         lty = 3)
  # Para gamma1-epsilon, donde gamma1=1 y epsilon=0.5
  #segments(1 - 0.5, cdf(1 - 0.5), 1 - 0.5, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(1 - 0.5), 1 - 0.5,
  #         cdf(1 - 0.5), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon1 < 0.05) {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, 1.2),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, 1.2),
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
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom",
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
    segments(1, 1, 1+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde gamma1=1 y epsilon=0.05
    segments(1 - 0.05, cdf(1 - 0.05), 1 - 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(1 - 0.05), 1 - 0.05,
             cdf(1 - 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, 1.2),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, 1.2),
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
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom",
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(1, 1, 1, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 1, 0, lwd = 2.5, col = "red")
    segments(1, 1, 1+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde gamma1=1 y epsilon=0.55
    segments(1 - 0.55, cdf(1 - 0.55), 1 - 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(1 - 0.55), 1 - 0.55,
             cdf(1 - 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
} else {
  if (input$epsilon1 >= 0.05 & input$epsilon1 <= 0.55){
  plot(x=c(-5, 5), y=c(0, 1),
       xlab = expression(x[(n)]),
       ylab = bquote("Empirical" ~ F[X[(n)]](t)),
       cex.lab=1.3,
       type='n', 
       ylim=c(0, 1),
       xlim = c(0, 12),
       las = 1)
  lines(cdf,
        xlab = expression(x[(n)]),
        ylab = bquote("Empirical" ~ F[X[(n)]](t)),
        xlim = c(0, 12),
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
  #        legend = c(expression(F[X[(n)]](x)), 
  #                   bquote("Degenerated distribution" ~ F(t))),
  #        col = c("royalblue1", "gray48"),
  #        lty = c(1,3),
  #        lwd = 3)
  
  legend("bottom",
         inset = c(0, -0.4),
         #par('usr')[2], par('usr')[4], 
         bty='n', xpd=NA, horiz = TRUE,
         legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                           bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
         col = c("steelblue2", "red"),
         lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
  # Para la distribución degenerada 
  segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
  segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
  segments(10, 1, 10+3.5, 1, lwd = 2.5, col = "red")
  # Para gamma1-epsilon, donde gamma1=50
  segments(10 - input$epsilon1, cdf(10 - input$epsilon1), 10 - input$epsilon1, 0, 
           lwd = 2.5, col = "gray0", lty = 3)
  segments(-20, cdf(10 - input$epsilon1), 10 - input$epsilon1,
           cdf(10 - input$epsilon1), lwd = 2.5, 
           col = "gray0", 
           lty = 3)
  # Para gamma1-epsilon, donde gamma1=50 y epsilon=0.3
  #segments(10 - 0.3, cdf(10 - 0.3), 10 - 0.3, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[5], lty = 3)
  #segments(-20, cdf(10 - 0.3), 10 - 0.3,
  #         cdf(10 - 0.3), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[5],
  #         lty = 3)
  # Para gamma1-epsilon, donde gamma1=50 y epsilon=0.5
  #segments(10 - 0.5, cdf(10 - 0.5), 10 - 0.5, 0, 
  #         lwd = 2, col = colorRampPalette(c('blue', 'white'))(25)[1], lty = 3)
  #segments(-20, cdf(10 - 0.5), 10 - 0.5,
  #         cdf(10 - 0.5), lwd = 2, 
  #         col = colorRampPalette(c('blue', 'white'))(25)[1], 
  #         lty = 3)
  } else if (input$epsilon1 < 0.05){
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, 12),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, 12),
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
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom",
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
    segments(10, 1, 10+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde gamma1=50 y epsilon=0.05
    segments(10 - 0.05, cdf(10 - 0.05), 10 - 0.05, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(10 - 0.05), 10 - 0.05,
             cdf(10 - 0.05), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  } else {
    plot(x=c(-5, 5), y=c(0, 1),
         xlab = expression(x[(n)]),
         ylab = bquote("Empirical" ~ F[X[(n)]](t)),
         cex.lab=1.3,
         type='n', 
         ylim=c(0, 1),
         xlim = c(0, 12),
         las = 1)
    lines(cdf,
          xlab = expression(x[(n)]),
          ylab = bquote("Empirical" ~ F[X[(n)]](t)),
          xlim = c(0, 12),
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
    #        legend = c(expression(F[X[(n)]](x)), 
    #                   bquote("Degenerated distribution" ~ F(t))),
    #        col = c("royalblue1", "gray48"),
    #        lty = c(1,3),
    #        lwd = 3)
    
    legend("bottom",
           inset = c(0, -0.4),
           #par('usr')[2], par('usr')[4], 
           bty='n', xpd=NA, horiz = TRUE,
           legend = sapply(c(bquote("Empirical" ~ F[X[(n)]](t)), 
                             bquote("Degenerated\ndistribution" ~ F(t))), as.expression),
           col = c("steelblue2", "red"),
           lty = 1, lwd = 2.5, cex = 1.3, y.intersp = 2.5)
    # Para la distribución degenerada 
    segments(10, 1, 10, 0, lwd = 1.5, col = "red", lty = 3)
    segments(-20, 0, 10, 0, lwd = 2.5, col = "red")
    segments(10, 1, 10+3.5, 1, lwd = 2.5, col = "red")
    # Para gamma1-epsilon, donde gamma1=50 y epsilon=0.55
    segments(10 - 0.55, cdf(10 - 0.55), 10 - 0.55, 0, 
             lwd = 2.5, col = "gray0", lty = 3)
    segments(-20, cdf(10 - 0.55), 10 - 0.55,
             cdf(10 - 0.55), lwd = 2.5, 
             col = "gray0", 
             lty = 3)
  }
  }

