Var.test <- function(x, alternative='two.sided',
                     null.value=1, conf.level=0.95) {
  alpha <- 1 - conf.level
  n <- length(x)
  
  if (alternative == 'two.sided') { 
    alt <- 'not equal to'
    quantiles <- c(qchisq(p=alpha/2, df=n-1, lower.tail=F),
                   qchisq(p=1-alpha/2, df=n-1, lower.tail=F))
    conf.int <- (n-1) * var(x) / quantiles
    statistic <- (n-1) * var(x) / null.value
    p.value <- 2 * min(c(pchisq(statistic, n-1, lower.tail=F),
                         pchisq(statistic, n-1, lower.tail=T)))
  }
  
  if (alternative == 'less') {
    alt <- 'less than'
    quantiles <- c(qchisq(p=conf.level, df=n-1, lower.tail=F),
                   0)
    conf.int <- (n-1) * var(x) / quantiles
    statistic <- (n-1) * var(x) / null.value
    p.value <- pchisq(statistic, n-1)
  }
  
  if (alternative == 'greater') {
    alt <- 'greater than'
    quantiles <- c(0,
                   qchisq(p=conf.level, df=n-1, lower.tail=T))
    conf.int <- (n-1) * var(x) / quantiles
    statistic <- (n-1) * var(x) / null.value
    p.value <- pchisq(statistic, n-1, lower.tail=F)
  }
  
  res <-   list(conf.int=conf.int, statistic=statistic, df=n-1,
                alternative=alternative,
                alt=alt, null.value=null.value,
                conf.level=conf.level,
                data.name=deparse(substitute(x)), 
                p.value=p.value, sample.var=var(x))
  class(res) <- "vartest"
  res
}