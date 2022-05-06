#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  input_received <- reactive ({
    if(input$n > 2000){
      max
    }else if (input$n < 1){
      min
    }else{
      ifelse(is.integer(input$n) == FALSE, round(input$n), input$n)
    }
  })
  textnoten <- reactive({
    if(input$n >= 1 & input$n <= 2000){
      ifelse(is.integer(input$n) == FALSE, paste("<font color=\"#FF0000\">",
                                                 "&#x26A0; n must be an integer.", "</font>"), 
             paste(""))
    }else{
      paste0("<font color=\"#FF0000\">", "&#x26A0; n must be an integer between 1 and 2000 inclusive.",
             "</font>")
    }
  })
  output$noten <- renderText({
    HTML(textnoten())
  })
  
    output$MLE <- renderPlot({
        
        k <- 10000
        n <- input$n
        lambda <- input$l
        p.exito <- input$p 
        theta <- input$t
        delta <- input$delta
        
        if(input$distri == "Geometric"){
            set.seed(p.exito)
          
          if(n > 2000){
            muestras <- matrix(rgeom(k*2000, p.exito), nrow=k)
          }else if(n < 1){
            muestras <- matrix(rgeom(k*1, p.exito), nrow=k)
          }else{
            if(is.integer(n) == FALSE){
              muestras <- matrix(rgeom(k*round(n), p.exito), nrow=k)
            }else{
              muestras <- matrix(rgeom(k*n, p.exito), nrow=k)
            }
          }
            #muestras <- matrix(rgeom(k*n, p.exito), nrow=k)
            
            estimador <- function(x) 1/(mean(x)+1)
            estim <- apply(muestras, 1, estimador)
            
            dentro <- which(estim>p.exito-delta & estim<p.exito+delta)
            long.dentro <- length(dentro)
            prob1 <- long.dentro/k
            
            fuera <- which(estim<=p.exito-delta | estim>=p.exito+delta)
            long.fuera <- length(fuera)
            prob2 <- long.fuera/k
            
            if (long.fuera == 0){
                par(mfrow = c(3,1))
              ps <- seq(p.exito-delta-0.05, p.exito+delta+0.2, 0.001)
              if(n > 2000){
                verosimilitud1 <- function(ps) 2000*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
              }else if(n < 1){
                verosimilitud1 <- function(ps) 1*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
              }else{
                if(is.integer(n) == FALSE){
                  verosimilitud1 <- function(ps) round(n)*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }else{
                  verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }
              }
                #verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud1(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05, 
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud1(ps)), 
                               (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                               (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                               (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                               max(verosimilitud1(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(ps)), 
                           (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                           (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                           (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                           max(verosimilitud1(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(ps)), 
                                      (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                                      (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                                      (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                                      max(verosimilitud1(ps))),3))
                polygon(rbind(c(p.exito-delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,max(verosimilitud1(ps))+1000000),
                              c(p.exito-delta,max(verosimilitud1(ps))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito-delta,verosimilitud1(p.exito-delta-0.05)),
                #               c(p.exito+delta,verosimilitud1(p.exito-delta-0.05)),
                #               c(p.exito+delta,max(verosimilitud1(ps))+25),
                #               c(p.exito-delta,max(verosimilitud1(ps))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(p.exito, estim[dentro[1]]),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(ps) 2000*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }else if(n < 1){
                  verosimilitud2 <- function(ps) 1*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(ps) round(n)*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                  }else{
                    verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                  }
                }
                #verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud2(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05,  
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud2(ps)), 
                               (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                               (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                               (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                               max(verosimilitud2(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(ps)), 
                           (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                           (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                           (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                           max(verosimilitud2(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(ps)), 
                                      (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                                      (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                                      (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                                      max(verosimilitud2(ps))),3))
                polygon(rbind(c(p.exito-delta-1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,max(verosimilitud2(ps))+1000000),
                              c(p.exito-delta-1000000,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,max(verosimilitud2(ps))+1000000),
                              c(p.exito+delta,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito-delta-0.05,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito-delta,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito-delta,max(verosimilitud2(ps))+25),
                #               c(p.exito-delta-0.05,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito+delta,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito+delta+0.2,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito+delta+0.2,max(verosimilitud2(ps))+25),
                #               c(p.exito+delta,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = p.exito, 
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
              
              ps <- seq(p.exito-delta-0.05, p.exito+delta+0.2, 0.001)
              if(n > 2000){
                verosimilitud1 <- function(ps) 2000*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
              }else if(n < 1){
                verosimilitud1 <- function(ps) 1*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
              }else{
                if(is.integer(n) == FALSE){
                  verosimilitud1 <- function(ps) round(n)*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }else{
                  verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }
              }
                #verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud1(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05, 
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud1(ps)), 
                               (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                               (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                               (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                               max(verosimilitud1(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(ps)), 
                           (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                           (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                           (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                           max(verosimilitud1(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(ps)), 
                                      (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                                      (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                                      (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                                      max(verosimilitud1(ps))),3))
                polygon(rbind(c(p.exito-delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,max(verosimilitud1(ps))+1000000),
                              c(p.exito-delta,max(verosimilitud1(ps))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito-delta,verosimilitud1(p.exito-delta-0.05)),
                #               c(p.exito+delta,verosimilitud1(p.exito-delta-0.05)),
                #               c(p.exito+delta,max(verosimilitud1(ps))+25),
                #               c(p.exito-delta,max(verosimilitud1(ps))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = p.exito,
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(ps) 2000*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }else if(n < 1){
                  verosimilitud2 <- function(ps) 1*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(ps) round(n)*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                  }else{
                    verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                  }
                }
                #verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud2(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05,  
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud2(ps)), 
                               (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                               (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                               (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                               max(verosimilitud2(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(ps)), 
                           (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                           (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                           (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                           max(verosimilitud2(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(ps)), 
                                      (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                                      (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                                      (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                                      max(verosimilitud2(ps))),3))
                polygon(rbind(c(p.exito-delta-1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,max(verosimilitud2(ps))+1000000),
                              c(p.exito-delta-1000000,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,max(verosimilitud2(ps))+1000000),
                              c(p.exito+delta,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito-delta-0.05,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito-delta,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito-delta,max(verosimilitud2(ps))+25),
                #               c(p.exito-delta-0.05,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(p.exito+delta,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito+delta+0.2,verosimilitud2(p.exito-delta-0.05)),
                #               c(p.exito+delta+0.2,max(verosimilitud2(ps))+25),
                #               c(p.exito+delta,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(p.exito, estim[dentro[1]]), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                ps <- seq(p.exito-delta-0.05, p.exito+delta+0.2, 0.001)
                if(n > 2000){
                  verosimilitud1 <- function(ps) 2000*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }else if(n < 1){
                  verosimilitud1 <- function(ps) 1*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud1 <- function(ps) round(n)*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                  }else{
                    verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                  }
                }
                #verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud1(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05, 
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud1(ps)), 
                               (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                               (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                               (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                               max(verosimilitud1(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(ps)), 
                           (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                           (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                           (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                           max(verosimilitud1(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(ps)), 
                                      (3*min(verosimilitud1(ps))+max(verosimilitud1(ps)))/4, 
                                      (min(verosimilitud1(ps))+max(verosimilitud1(ps)))/2, 
                                      (3*max(verosimilitud1(ps))+min(verosimilitud1(ps)))/4, 
                                      max(verosimilitud1(ps))),3))
                polygon(rbind(c(p.exito-delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,min(verosimilitud1(ps))-1000000),
                              c(p.exito+delta,max(verosimilitud1(ps))+1000000),
                              c(p.exito-delta,max(verosimilitud1(ps))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(p.exito, estim[dentro[1]]),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                ps <- seq(p.exito-delta-0.05, p.exito+delta+0.2, 0.001)
                if(n > 2000){
                  verosimilitud2 <- function(ps) 2000*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }else if(n < 1){
                  verosimilitud2 <- function(ps) 1*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(ps) round(n)*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                  }else{
                    verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                  }
                }
                #verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,8.3,3,23.5))
                plot(ps, verosimilitud2(ps), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                #       ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(p.exito-delta-0.05,  
                               p.exito-delta, p.exito, p.exito+delta, 
                               (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2), labels = FALSE, tck = 0.02)
                text(x = c(p.exito-delta-0.05, p.exito-delta, 
                           p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, 
                           p.exito+delta+0.2), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(p.exito-delta-0.05, p.exito-delta, 
                                p.exito, p.exito+delta, (2*p.exito+2*delta+0.2)/2, p.exito+delta+0.2))
                axis(2, at = c(min(verosimilitud2(ps)), 
                               (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                               (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                               (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                               max(verosimilitud2(ps))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(ps)), 
                           (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                           (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                           (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                           max(verosimilitud2(ps))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(ps)), 
                                      (3*min(verosimilitud2(ps))+max(verosimilitud2(ps)))/4, 
                                      (min(verosimilitud2(ps))+max(verosimilitud2(ps)))/2, 
                                      (3*max(verosimilitud2(ps))+min(verosimilitud2(ps)))/4, 
                                      max(verosimilitud2(ps))),3))
                polygon(rbind(c(p.exito-delta-1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito-delta,max(verosimilitud2(ps))+1000000),
                              c(p.exito-delta-1000000,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,min(verosimilitud2(ps))-1000000),
                              c(p.exito+delta+1000000,max(verosimilitud2(ps))+1000000),
                              c(p.exito+delta,max(verosimilitud2(ps))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = bquote(pi),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(p.exito, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(pi), 
                                       bquote(hat(pi)[n] ~ "=" ~ 1 ~ "/" ~ "(" ~ bar(X)[n] ~ "+" ~ 1 ~ ")"), 
                                       expression(paste(pi %+-% delta)),
                                       bquote("ℓ(" ~ pi ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(pi)[n] ~ "-" ~ pi ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }}
        
        if(input$distri == "Poisson"){
            set.seed(lambda)
          
            if(n > 2000){
              muestras <- matrix(rpois(k*2000, lambda), nrow=k)
            }else if(n < 1){
              muestras <- matrix(rpois(k*1, lambda), nrow=k)
            }else{
              if(is.integer(n) == FALSE){
                muestras <- matrix(rpois(k*round(n), lambda), nrow=k)
              }else{
                muestras <- matrix(rpois(k*n, lambda), nrow=k)
              }
            }
            #muestras <- matrix(rpois(k*n, lambda), nrow=k)
            
            medias <- apply(muestras, 1, mean)
            
            dentro <- which(medias>lambda-delta & medias<lambda+delta)
            long.dentro <- length(dentro)
            prob1 <- long.dentro/k
            
            fuera <- which(medias<=lambda-delta | medias>=lambda+delta)
            long.fuera <- length(fuera)
            prob2 <- long.fuera/k
            
            if (long.fuera == 0){
                par(mfrow = c(3,1))
                
                lambdas <- seq(lambda-delta-0.7, lambda+delta+0.7, 0.01)
                if(n > 2000){
                  verosimilitud1 <- function(lambdas){
                    -2000*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud1 <- function(lambdas){
                    -1*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud1 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }else{
                    verosimilitud1 <- function(lambdas){
                      -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }
                }
                # verosimilitud1 <- function(lambdas){
                #     -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                # }
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud1(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                #       ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud1(lambdas)), 
                               (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                               (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                               (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                               max(verosimilitud1(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(lambdas)), 
                           (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                           (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                           (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                           max(verosimilitud1(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(lambdas)), 
                                      (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                                      (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                                      (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                                      max(verosimilitud1(lambdas))),3))
                polygon(rbind(c(lambda-delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,max(verosimilitud1(lambdas))+1000000),
                              c(lambda-delta,max(verosimilitud1(lambdas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda-delta,verosimilitud1(1.4)),
                #               c(lambda+delta,verosimilitud1(1.4)),
                #               c(lambda+delta,max(verosimilitud1(lambdas))+25),
                #               c(lambda-delta,max(verosimilitud1(lambdas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = bquote(lambda),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(lambda, mean(muestras[dentro[1], ])),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(lambdas){
                    -2000*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud2 <- function(lambdas){
                    -1*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }else{
                    verosimilitud2 <- function(lambdas){
                      -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }
                }
                # verosimilitud2 <- function(lambdas){
                #     -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                # }
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud2(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                #       ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud2(lambdas)), 
                               (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                               (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                               (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                               max(verosimilitud2(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(lambdas)), 
                           (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                           (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                           (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                           max(verosimilitud2(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(lambdas)), 
                                      (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                                      (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                                      (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                                      max(verosimilitud2(lambdas))),3))
                polygon(rbind(c(lambda-delta-1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,max(verosimilitud2(lambdas))+1000000),
                              c(lambda-delta-1000000,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,max(verosimilitud2(lambdas))+1000000),
                              c(lambda+delta,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda-delta-0.7,verosimilitud2(1.4)),
                #               c(lambda-delta,verosimilitud2(1.4)),
                #               c(lambda-delta,max(verosimilitud2(lambdas))+25),
                #               c(lambda-delta-0.7,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda+delta,verosimilitud2(1.4)),
                #               c(lambda+delta+0.7,verosimilitud2(1.4)),
                #               c(lambda+delta+0.7,max(verosimilitud2(lambdas))+25),
                #               c(lambda+delta,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = bquote(lambda),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = lambda, 
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
                
                lambdas <- seq(lambda-delta-0.7, lambda+delta+0.7, 0.01)
                if(n > 2000){
                  verosimilitud1 <- function(lambdas){
                    -2000*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud1 <- function(lambdas){
                    -1*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud1 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }else{
                    verosimilitud1 <- function(lambdas){
                      -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }
                }
                # verosimilitud1 <- function(lambdas){
                #     -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                # }
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud1(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                #       ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud1(lambdas)), 
                               (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                               (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                               (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                               max(verosimilitud1(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(lambdas)), 
                           (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                           (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                           (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                           max(verosimilitud1(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(lambdas)), 
                                      (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                                      (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                                      (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                                      max(verosimilitud1(lambdas))),3))
                polygon(rbind(c(lambda-delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,max(verosimilitud1(lambdas))+1000000),
                              c(lambda-delta,max(verosimilitud1(lambdas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda-delta,verosimilitud1(1.4)),
                #               c(lambda+delta,verosimilitud1(1.4)),
                #               c(lambda+delta,max(verosimilitud1(lambdas))+25),
                #               c(lambda-delta,max(verosimilitud1(lambdas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = bquote(lambda),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = lambda,
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(lambdas){
                    -2000*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud2 <- function(lambdas){
                    -1*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }else{
                    verosimilitud2 <- function(lambdas){
                      -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }
                }
                # verosimilitud2 <- function(lambdas){
                #     -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                # }
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud2(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                #       ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud2(lambdas)), 
                               (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                               (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                               (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                               max(verosimilitud2(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(lambdas)), 
                           (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                           (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                           (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                           max(verosimilitud2(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(lambdas)), 
                                      (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                                      (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                                      (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                                      max(verosimilitud2(lambdas))),3))
                polygon(rbind(c(lambda-delta-1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,max(verosimilitud2(lambdas))+1000000),
                              c(lambda-delta-1000000,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,max(verosimilitud2(lambdas))+1000000),
                              c(lambda+delta,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda-delta-0.7,verosimilitud2(1.4)),
                #               c(lambda-delta,verosimilitud2(1.4)),
                #               c(lambda-delta,max(verosimilitud2(lambdas))+25),
                #               c(lambda-delta-0.7,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(lambda+delta,verosimilitud2(1.4)),
                #               c(lambda+delta+0.7,verosimilitud2(1.4)),
                #               c(lambda+delta+0.7,max(verosimilitud2(lambdas))+25),
                #               c(lambda+delta,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = bquote(lambda),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(lambda, mean(muestras[fuera[1], ])), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                lambdas <- seq(lambda-delta-0.7, lambda+delta+0.7, 0.01)
                if(n > 2000){
                  verosimilitud1 <- function(lambdas){
                    -2000*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud1 <- function(lambdas){
                    -1*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud1 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }else{
                    verosimilitud1 <- function(lambdas){
                      -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                    }
                  }
                }
                # verosimilitud1 <- function(lambdas){
                #     -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                # }
                
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud1(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                #curve(verosimilitud1,
                #      xlab = "",
                #      ylab = "", 
                #      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      #ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                #      las = 1, lwd = 3, cex.axis = 1.5, xaxt = "n", yaxt = "n")
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud1(lambdas)), 
                               (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                               (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                               (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                               max(verosimilitud1(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(lambdas)), 
                           (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                           (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                           (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                           max(verosimilitud1(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(lambdas)), 
                                      (3*min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/4, 
                                      (min(verosimilitud1(lambdas))+max(verosimilitud1(lambdas)))/2, 
                                      (3*max(verosimilitud1(lambdas))+min(verosimilitud1(lambdas)))/4, 
                                      max(verosimilitud1(lambdas))),3))
                polygon(rbind(c(lambda-delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,min(verosimilitud1(lambdas))-1000000),
                              c(lambda+delta,max(verosimilitud1(lambdas))+1000000),
                              c(lambda-delta,max(verosimilitud1(lambdas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = bquote(lambda), 
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(lambda, mean(muestras[dentro[1], ])),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(lambdas){
                    -2000*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else if(n < 1){
                  verosimilitud2 <- function(lambdas){
                    -1*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                  }
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(lambdas){
                      -round(n)*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }else{
                    verosimilitud2 <- function(lambdas){
                      -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                    }
                  }
                }
                # verosimilitud2 <- function(lambdas){
                #     -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                # }
                par(mar=c(5,8.3,3,23.5))
                plot(lambdas, verosimilitud2(lambdas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                #       ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, 
                               lambda-delta, lambda, lambda+delta, 
                               (2*lambda+2*delta+0.7)/2, lambda+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                           lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, 
                           lambda+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(lambda-delta-0.7, (2*lambda-2*delta-0.7)/2, lambda-delta, 
                                lambda, lambda+delta, (2*lambda+2*delta+0.7)/2, lambda+delta+0.7))
                axis(2, at = c(min(verosimilitud2(lambdas)), 
                               (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                               (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                               (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                               max(verosimilitud2(lambdas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(lambdas)), 
                           (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                           (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                           (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                           max(verosimilitud2(lambdas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(lambdas)), 
                                      (3*min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/4, 
                                      (min(verosimilitud2(lambdas))+max(verosimilitud2(lambdas)))/2, 
                                      (3*max(verosimilitud2(lambdas))+min(verosimilitud2(lambdas)))/4, 
                                      max(verosimilitud2(lambdas))),3))
                polygon(rbind(c(lambda-delta-1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda-delta,max(verosimilitud2(lambdas))+1000000),
                              c(lambda-delta-1000000,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,min(verosimilitud2(lambdas))-1000000),
                              c(lambda+delta+1000000,max(verosimilitud2(lambdas))+1000000),
                              c(lambda+delta,max(verosimilitud2(lambdas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = bquote(lambda),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(lambda, mean(muestras[fuera[1], ])), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(lambda), 
                                       bquote(hat(lambda)[n] ~ "=" ~ bar(X)[n]), 
                                       expression(paste(lambda %+-% delta)),
                                       bquote("ℓ(" ~ lambda ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(lambda)[n] ~ "-" ~ lambda ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }}
        
        if(input$distri == "Exponential"){
            set.seed(theta)
          
          if(n > 2000){
            muestras <- matrix(rexp(k*2000, theta), nrow=k)
          }else if(n < 1){
            muestras <- matrix(rexp(k*1, theta), nrow=k)
          }else{
            if(is.integer(n) == FALSE){
              muestras <- matrix(rexp(k*round(n), theta), nrow=k)
            }else{
              muestras <- matrix(rexp(k*n, theta), nrow=k)
            }
          }
            #muestras <- matrix(rexp(k*n, theta), nrow=k)
            
            estimador <- function(x) 1/mean(x)
            estim <- apply(muestras, 1, estimador)
            
            dentro <- which(estim>theta-delta & estim<theta+delta)
            long.dentro <- length(dentro)
            prob1 <- long.dentro/k
            
            fuera <- which(estim<=theta-delta | estim>=theta+delta)
            long.fuera <- length(fuera)
            prob2 <- long.fuera/k
            
            if (long.fuera == 0){
                par(mfrow = c(3,1))
                
              thetas <- seq(theta-delta-0.7, theta+delta+0.7, 0.01)
              if(n > 2000){
                verosimilitud1 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[dentro[1], ])
              }else if(n < 1){
                verosimilitud1 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[dentro[1], ])
              }else{
                if(is.integer(n) == FALSE){
                  verosimilitud1 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }else{
                  verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }
              }
              #verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud1(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud1(thetas)), 
                               (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                               (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                               (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                               max(verosimilitud1(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(thetas)), 
                           (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                           (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                           (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                           max(verosimilitud1(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(thetas)), 
                                      (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                                      (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                                      (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                                      max(verosimilitud1(thetas))),3))
                polygon(rbind(c(theta-delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,max(verosimilitud1(thetas))+1000000),
                              c(theta-delta,max(verosimilitud1(thetas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(theta-delta,verosimilitud1(theta-delta-0.7)),
                #               c(theta+delta,verosimilitud1(theta-delta-0.7)),
                #               c(theta+delta,max(verosimilitud1(thetas))+25),
                #               c(theta-delta,max(verosimilitud1(thetas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi1)[n]%in%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(theta, estim[dentro[1]]),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }else if(n < 1){
                  verosimilitud2 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[dentro[1], ])
                  }else{
                    verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                  }
                }
                #verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud2(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud2(thetas)), 
                               (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                               (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                               (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                               max(verosimilitud2(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(thetas)), 
                           (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                           (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                           (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                           max(verosimilitud2(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(thetas)), 
                                      (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                                      (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                                      (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                                      max(verosimilitud2(thetas))),3))
                polygon(rbind(c(theta-delta-1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,max(verosimilitud2(thetas))+1000000),
                              c(theta-delta-1000000,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,max(verosimilitud2(thetas))+1000000),
                              c(theta+delta,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(theta-delta-0.7,verosimilitud2(theta-delta-0.7)),
                #               c(theta-delta,verosimilitud2(theta-delta-0.7)),
                #               c(theta-delta,max(verosimilitud2(thetas))+25),
                #               c(theta-delta-0.7,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(theta+delta,verosimilitud2(theta-delta-0.7)),
                #               c(theta+delta+0.7,verosimilitud2(theta-delta-0.7)),
                #               c(theta+delta+0.7,max(verosimilitud2(thetas))+25),
                #               c(theta+delta,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi1)[n]%notin%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = theta, 
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
                
              thetas <- seq(theta-delta-0.7, theta+delta+0.7, 0.01)
              if(n > 2000){
                verosimilitud1 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[fuera[1], ])
              }else if(n < 1){
                verosimilitud1 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[fuera[1], ])
              }else{
                if(is.integer(n) == FALSE){
                  verosimilitud1 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }else{
                  verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }
              }
                #verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud1(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud1(thetas)), 
                               (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                               (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                               (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                               max(verosimilitud1(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(thetas)), 
                           (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                           (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                           (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                           max(verosimilitud1(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(thetas)), 
                                      (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                                      (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                                      (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                                      max(verosimilitud1(thetas))),3))
                polygon(rbind(c(theta-delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,max(verosimilitud1(thetas))+1000000),
                              c(theta-delta,max(verosimilitud1(thetas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                # polygon(rbind(c(theta-delta,verosimilitud1(theta-delta-0.7)),
                #               c(theta+delta,verosimilitud1(theta-delta-0.7)),
                #               c(theta+delta,max(verosimilitud1(thetas))+25),
                #               c(theta-delta,max(verosimilitud1(thetas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi1)[n]%in%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = theta,
                       lty = 3, 
                       col = "steelblue2",
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }else if(n < 1){
                  verosimilitud2 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[fuera[1], ])
                  }else{
                    verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                  }
                }
                #verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud2(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud2(thetas)), 
                               (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                               (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                               (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                               max(verosimilitud2(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(thetas)), 
                           (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                           (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                           (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                           max(verosimilitud2(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(thetas)), 
                                      (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                                      (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                                      (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                                      max(verosimilitud2(thetas))),3))
                polygon(rbind(c(theta-delta-1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,max(verosimilitud2(thetas))+1000000),
                              c(theta-delta-1000000,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,max(verosimilitud2(thetas))+1000000),
                              c(theta+delta,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(theta-delta-0.7,verosimilitud2(theta-delta-0.7)),
                #               c(theta-delta,verosimilitud2(theta-delta-0.7)),
                #               c(theta-delta,max(verosimilitud2(thetas))+25),
                #               c(theta-delta-0.7,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                # polygon(rbind(c(theta+delta,verosimilitud2(theta-delta-0.7)),
                #               c(theta+delta+0.7,verosimilitud2(theta-delta-0.7)),
                #               c(theta+delta+0.7,max(verosimilitud2(thetas))+25),
                #               c(theta+delta,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi1)[n]%notin%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(theta, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")), as.expression),
                       col=c("steelblue2", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                thetas <- seq(theta-delta-0.7, theta+delta+0.7, 0.01)
                if(n > 2000){
                  verosimilitud1 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }else if(n < 1){
                  verosimilitud1 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[dentro[1], ])
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud1 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[dentro[1], ])
                  }else{
                    verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                  }
                }
                #verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud1(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud1,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud1(thetas)), 
                               (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                               (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                               (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                               max(verosimilitud1(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud1(thetas)), 
                           (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                           (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                           (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                           max(verosimilitud1(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud1(thetas)), 
                                      (3*min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/4, 
                                      (min(verosimilitud1(thetas))+max(verosimilitud1(thetas)))/2, 
                                      (3*max(verosimilitud1(thetas))+min(verosimilitud1(thetas)))/4, 
                                      max(verosimilitud1(thetas))),3))
                polygon(rbind(c(theta-delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,min(verosimilitud1(thetas))-1000000),
                              c(theta+delta,max(verosimilitud1(thetas))+1000000),
                              c(theta-delta,max(verosimilitud1(thetas))+1000000)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi1)[n]%in%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2",
                      cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(theta, estim[dentro[1]]),
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")),
                                     as.expression), col=c("steelblue2", "darkorchid3", "brown2", "black"), 
                       lty = c(rep(3,3),1), lwd = 3, inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                if(n > 2000){
                  verosimilitud2 <- function(thetas) 2000*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }else if(n < 1){
                  verosimilitud2 <- function(thetas) 1*log(thetas) - thetas*sum(muestras[fuera[1], ])
                }else{
                  if(is.integer(n) == FALSE){
                    verosimilitud2 <- function(thetas) round(n)*log(thetas) - thetas*sum(muestras[fuera[1], ])
                  }else{
                    verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                  }
                }
                #verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,8.3,3,23.5))
                plot(thetas, verosimilitud2(thetas), type = "l", 
                     xaxt = "n", yaxt = "n",xlab = "", ylab = "", lwd = 3)
                # curve(verosimilitud2,
                #       xlab = "",
                #       ylab = "",
                #       xlim = c(theta-delta-0.7, theta+delta+0.7),
                #       ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                #       las = 1, lwd = 3, cex.axis = 1.5)
                axis(1, at = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, 
                               theta-delta, theta, theta+delta, 
                               (2*theta+2*delta+0.7)/2, theta+delta+0.7), labels = FALSE, tck = 0.02)
                text(x = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                           theta, theta+delta, (2*theta+2*delta+0.7)/2, 
                           theta+delta+0.7), y = par("usr")[3], srt = 10, pos = 1, xpd = TRUE, cex = 1.4, 
                     labels = c(theta-delta-0.7, (2*theta-2*delta-0.7)/2, theta-delta, 
                                theta, theta+delta, (2*theta+2*delta+0.7)/2, theta+delta+0.7))
                axis(2, at = c(min(verosimilitud2(thetas)), 
                               (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                               (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                               (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                               max(verosimilitud2(thetas))), labels = FALSE, tck = 0.02)
                text(y = c(min(verosimilitud2(thetas)), 
                           (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                           (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                           (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                           max(verosimilitud2(thetas))), x = par("usr")[1], srt = 10, pos = 2, xpd = TRUE, cex = 1.4, 
                     labels = round(c(min(verosimilitud2(thetas)), 
                                      (3*min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/4, 
                                      (min(verosimilitud2(thetas))+max(verosimilitud2(thetas)))/2, 
                                      (3*max(verosimilitud2(thetas))+min(verosimilitud2(thetas)))/4, 
                                      max(verosimilitud2(thetas))),3))
                polygon(rbind(c(theta-delta-1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,min(verosimilitud2(thetas))-1000000),
                              c(theta-delta,max(verosimilitud2(thetas))+1000000),
                              c(theta-delta-1000000,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,min(verosimilitud2(thetas))-1000000),
                              c(theta+delta+1000000,max(verosimilitud2(thetas))+1000000),
                              c(theta+delta,max(verosimilitud2(thetas))+1000000)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi1)[n]%notin%(phi1%+-%delta)),
                      xlab = bquote(phi1),
                      col.main = "steelblue2", cex.main = 2, cex.lab = 2)
                title(ylab = bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")"),
                      cex.lab = 2, line = 6.5)
                abline(v = c(theta, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("steelblue2", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=sapply(c(bquote(phi1), 
                                       bquote(hat(phi1)[n] ~ "=" ~ 1 ~ "/" ~ bar(X)[n]), 
                                       expression(paste(phi1 %+-% delta)),
                                       bquote("ℓ(" ~ phi1 ~ "|" ~ bold(X) ~ ")")),
                                     as.expression), col=c("steelblue2", "darkorchid3", "brown2", "black"), 
                       lty = c(rep(3,3),1), lwd = 3, inset = c(1,0), xpd = TRUE, bty = "n", cex = 2, y.intersp = 1.2)
                
                par(mar=c(5,8.3,3,23.5))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1, cex.axis = 1.4)
                if(n > 2000){
                  title(main = bquote(n == 2000), cex.main = 2, col.main = "steelblue2")
                }else if(n < 1){
                  title(main = bquote(n == 1), cex.main = 2, col.main = "steelblue2")
                }else{
                  if(is.integer(n) == FALSE){
                    title(main = bquote(n == .(round(n))), cex.main = 2, col.main = "steelblue2")
                  }else{
                    title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                  }
                }
                #title(main = bquote(n == .(n)), cex.main = 2, col.main = "steelblue2")
                legend("topleft", sapply(c(bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "<" ~ delta ~ ")"), 
                                           bquote("Estimated P(" ~ "|" ~ hat(phi1)[n] ~ "-" ~ phi1 ~ "|" ~ "\u2265" ~ delta ~ ")")),
                                         as.expression), pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), 
                       xpd=TRUE, bty="n", cex = 2, y.intersp = 1.5)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }
        }
        
    })
    
    output$download <- downloadHandler(
      filename = "Workshop Cons-MLEs.pdf",
      content = function(file) {
        file.copy("Workshop Cons-MLEs.pdf", file)
      }
    )
})
