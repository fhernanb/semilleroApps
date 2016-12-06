Dist <- 'norm'
Dist <- 'weibull'
Dist <- 'gamma'

n.points <- 20
sigmas <- 2

x <- rnorm(n=100, mean=15, sd=3)
x <- rweibull(n=1000, shape=2, scale=1.5)
x <- rgamma(n=1000, shape=7.5, rate=1)

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

p








