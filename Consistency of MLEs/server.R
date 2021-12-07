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
    
    output$MLE <- renderPlot({
        
        k <- 10000
        n <- input$n
        lambda <- input$l
        p.exito <- input$p 
        theta <- input$t
        delta <- input$delta
        
        if(input$distri == "Geometric"){
            set.seed(p.exito)
            muestras <- matrix(rgeom(k*n, p.exito), nrow=k)
            
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
                ps <- seq(0.01, p.exito+0.4, 0.01)
                verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,max(verosimilitud1(ps))+25),
                              c(p.exito-delta,max(verosimilitud1(ps))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(p.exito, estim[dentro[1]]),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta-0.05,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,max(verosimilitud2(ps))+25),
                              c(p.exito-delta-0.05,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,max(verosimilitud2(ps))+25),
                              c(p.exito+delta,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = p.exito, 
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
                ps <- seq(0.01, p.exito+0.4, 0.01)
                verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,max(verosimilitud1(ps))+25),
                              c(p.exito-delta,max(verosimilitud1(ps))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = p.exito,
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta-0.05,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,max(verosimilitud2(ps))+25),
                              c(p.exito-delta-0.05,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,max(verosimilitud2(ps))+25),
                              c(p.exito+delta,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(p.exito, estim[dentro[1]]), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                ps <- seq(0.01, p.exito+0.4, 0.01)
                verosimilitud1 <- function(ps) n*log(ps) + sum(muestras[dentro[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud1(p.exito-delta-0.05), max(verosimilitud1(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,verosimilitud1(p.exito-delta-0.05)),
                              c(p.exito+delta,max(verosimilitud1(ps))+25),
                              c(p.exito-delta,max(verosimilitud1(ps))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(pi)[n]%in%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(p.exito, estim[dentro[1]]),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(ps) n*log(ps) + sum(muestras[fuera[1], ])*log(1-ps)
                par(mar=c(5,5,2,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(p.exito-delta-0.05, p.exito+delta+0.2),
                      ylim = c(verosimilitud2(p.exito-delta-0.05), max(verosimilitud2(ps))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(p.exito-delta-0.05,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito-delta,max(verosimilitud2(ps))+25),
                              c(p.exito-delta-0.05,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(p.exito+delta,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,verosimilitud2(p.exito-delta-0.05)),
                              c(p.exito+delta+0.2,max(verosimilitud2(ps))+25),
                              c(p.exito+delta,max(verosimilitud2(ps))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(pi)[n]%notin%(pi%+-%delta)),
                      xlab = expression(pi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(p.exito, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(p.exito-delta, p.exito+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(pi), 
                                expression(paste(hat(pi)[n], "=", 1, "/", (bar(X)[n]+1))), 
                                expression(pi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", pi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(pi)[n], "-",pi, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }}
        
        if(input$distri == "Poisson"){
            set.seed(lambda)
            muestras <- matrix(rpois(k*n, lambda), nrow=k)
            
            medias <- apply(muestras, 1, mean)
            
            dentro <- which(medias>lambda-delta & medias<lambda+delta)
            long.dentro <- length(dentro)
            prob1 <- long.dentro/k
            
            fuera <- which(medias<=lambda-delta | medias>=lambda+delta)
            long.fuera <- length(fuera)
            prob2 <- long.fuera/k
            
            if (long.fuera == 0){
                par(mfrow = c(3,1))
                
                lambdas <- seq(0, lambda+4, 0.1)
                verosimilitud1 <- function(lambdas){
                    -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta,verosimilitud1(1.4)),
                              c(lambda+delta,verosimilitud1(1.4)),
                              c(lambda+delta,max(verosimilitud1(lambdas))+25),
                              c(lambda-delta,max(verosimilitud1(lambdas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = expression(bold(lambda)),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(lambda, mean(muestras[dentro[1], ])),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(lambdas){
                    -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta-0.7,verosimilitud2(1.4)),
                              c(lambda-delta,verosimilitud2(1.4)),
                              c(lambda-delta,max(verosimilitud2(lambdas))+25),
                              c(lambda-delta-0.7,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,max(verosimilitud2(lambdas))+25),
                              c(lambda+delta,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = expression(lambda),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = lambda, 
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
                
                lambdas <- seq(0, lambda+4, 0.1)
                verosimilitud1 <- function(lambdas){
                    -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta,verosimilitud1(1.4)),
                              c(lambda+delta,verosimilitud1(1.4)),
                              c(lambda+delta,max(verosimilitud1(lambdas))+25),
                              c(lambda-delta,max(verosimilitud1(lambdas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = expression(bold(lambda)),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = lambda,
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(lambdas){
                    -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta-0.7,verosimilitud2(1.4)),
                              c(lambda-delta,verosimilitud2(1.4)),
                              c(lambda-delta,max(verosimilitud2(lambdas))+25),
                              c(lambda-delta-0.7,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,max(verosimilitud2(lambdas))+25),
                              c(lambda+delta,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = expression(lambda),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(lambda, mean(muestras[fuera[1], ])), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                lambdas <- seq(0, lambda+4, 0.1)
                verosimilitud1 <- function(lambdas){
                    -n*lambdas + sum(muestras[dentro[1], ])*log(lambdas) - sum(log(factorial(muestras[dentro[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud1(1.4), max(verosimilitud1(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta,verosimilitud1(1.4)),
                              c(lambda+delta,verosimilitud1(1.4)),
                              c(lambda+delta,max(verosimilitud1(lambdas))+25),
                              c(lambda-delta,max(verosimilitud1(lambdas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(lambda)[n]%in%(lambda%+-%delta)),
                      xlab = expression(bold(lambda)),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(lambda, mean(muestras[dentro[1], ])),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(lambdas){
                    -n*lambdas + sum(muestras[fuera[1], ])*log(lambdas) - sum(log(factorial(muestras[fuera[1], ])))
                }
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(lambda-delta-0.7, lambda+delta+0.7),
                      ylim = c(verosimilitud2(1.4), max(verosimilitud2(lambdas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(lambda-delta-0.7,verosimilitud2(1.4)),
                              c(lambda-delta,verosimilitud2(1.4)),
                              c(lambda-delta,max(verosimilitud2(lambdas))+25),
                              c(lambda-delta-0.7,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(lambda+delta,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,verosimilitud2(1.4)),
                              c(lambda+delta+0.7,max(verosimilitud2(lambdas))+25),
                              c(lambda+delta,max(verosimilitud2(lambdas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(lambda)[n]%notin%(lambda%+-%delta)),
                      xlab = expression(lambda),
                      ylab = expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(lambda, mean(muestras[fuera[1], ])), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(lambda-delta, lambda+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(lambda), 
                                expression(paste(hat(lambda)[n], "=", bar(X)[n])), 
                                expression(lambda%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", lambda, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(lambda)[n], "-",lambda, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }}
        
        if(input$distri == "Exponential"){
            set.seed(theta)
            muestras <- matrix(rexp(k*n, theta), nrow=k)
            
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
                
                thetas <- seq(0, theta+4, 0.1)
                verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,max(verosimilitud1(thetas))+25),
                              c(theta-delta,max(verosimilitud1(thetas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi)[n]%in%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(theta, estim[dentro[1]]),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta-0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,max(verosimilitud2(thetas))+25),
                              c(theta-delta-0.7,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,max(verosimilitud2(thetas))+25),
                              c(theta+delta,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi)[n]%notin%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = theta, 
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else if (long.dentro == 0) {
                par(mfrow = c(3,1))
                
                thetas <- seq(0, theta+4, 0.1)
                verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,max(verosimilitud1(thetas))+25),
                              c(theta-delta,max(verosimilitud1(thetas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi)[n]%in%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = theta,
                       lty = 3, 
                       col = "deepskyblue3",
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta-0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,max(verosimilitud2(thetas))+25),
                              c(theta-delta-0.7,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,max(verosimilitud2(thetas))+25),
                              c(theta+delta,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi)[n]%notin%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(theta, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", ">", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            } else {
                par(mfrow = c(3,1))
                
                thetas <- seq(0, theta+4, 0.1)
                verosimilitud1 <- function(thetas) n*log(thetas) - thetas*sum(muestras[dentro[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud1,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud1(theta-delta-0.7), max(verosimilitud1(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,verosimilitud1(theta-delta-0.7)),
                              c(theta+delta,max(verosimilitud1(thetas))+25),
                              c(theta-delta,max(verosimilitud1(thetas))+25)), col=rgb(0, 1, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.dentro) ~ hat(phi)[n]%in%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1",
                      cex.main = 2, cex.lab = 2)
                abline(v = c(theta, estim[dentro[1]]),
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                verosimilitud2 <- function(thetas) n*log(thetas) - thetas*sum(muestras[fuera[1], ])
                par(mar=c(5,5,3,17))
                curve(verosimilitud2,
                      xlab = "",
                      ylab = "",
                      xlim = c(theta-delta-0.7, theta+delta+0.7),
                      ylim = c(verosimilitud2(theta-delta-0.7), max(verosimilitud2(thetas))+25),
                      las = 1, lwd = 3)
                polygon(rbind(c(theta-delta-0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,verosimilitud2(theta-delta-0.7)),
                              c(theta-delta,max(verosimilitud2(thetas))+25),
                              c(theta-delta-0.7,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                polygon(rbind(c(theta+delta,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,verosimilitud2(theta-delta-0.7)),
                              c(theta+delta+0.7,max(verosimilitud2(thetas))+25),
                              c(theta+delta,max(verosimilitud2(thetas))+25)), col=rgb(1, 0, 0, 0.3), border = NA)
                title(main = bquote("From 10000 samples on" ~ .(long.fuera) ~ hat(phi)[n]%notin%(phi%+-%delta)),
                      xlab = expression(phi),
                      ylab = expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")")),
                      col.main = "royalblue1", cex.main = 2, cex.lab = 2)
                abline(v = c(theta, estim[fuera[1]]), 
                       lty = 3, 
                       col = c("deepskyblue3", "darkorchid3"),
                       lwd = 3)
                abline(v = c(theta-delta, theta+delta),
                       lty = 3,
                       col = "brown2",
                       lwd = 3)
                legend("topleft", 
                       legend=c(expression(phi), 
                                expression(paste(hat(phi)[n], "=", 1, "/", bar(X)[n])), 
                                expression(phi%+-%delta),
                                expression(paste(italic(ln), "(", "L", "(", phi, "|", bold(X), ")", ")"))),
                       col=c("deepskyblue3", "darkorchid3", "brown2", "black"), lty = c(rep(3,3),1), lwd = 3, 
                       inset = c(1,0), xpd = TRUE, bty = "n", cex = 2)
                
                par(mar=c(5,4,2,13))
                prob <- barplot(c(prob1, prob2),
                                ylim = c(0,1.15),
                                col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)),
                                las = 1)
                title(main = bquote(n == .(n)), cex.main = 2, col.main = "royalblue1")
                legend("topleft", c(expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", "<", delta, ")")), 
                                    expression(paste("P", "(","|", hat(phi)[n], "-",phi, "|", "\u2265", delta, ")"))),
                       pch = 15, col = c(rgb(0, 1, 0, 0.3), rgb(1, 0, 0, 0.3)), inset=c(1,0), xpd=TRUE, bty="n", cex = 2)
                text(x = prob, y = c(prob1, prob2), pos = 3, cex = 2,
                     col = "grey11", label = round(c(prob1, prob2), 3))
            }
        }
        
    })
    
    output$download <- downloadHandler(
        filename = "Exercises MLE.pdf",
        content = function(file) {
            file.copy("Exercises MLE.pdf", file)
        }
    )
})
