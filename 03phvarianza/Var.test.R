var.test <- function(x, alternative='two.sided',
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



var_test_one <- function(varx, nx, alternative, conf.level, null.value) {
  alpha <- 1 - conf.level
  # Alternative two.sided
  if (alternative == 'two.sided') { 
    quantiles <- c(qchisq(p=alpha/2, df=nx-1, lower.tail=F),
                   qchisq(p=1-alpha/2, df=nx-1, lower.tail=F))
    conf.int <- (nx-1) * varx / quantiles
    statistic <- (nx-1) * varx / null.value
    p.value <- 2 * min(c(pchisq(statistic, nx-1, lower.tail=F),
                         pchisq(statistic, nx-1, lower.tail=T)))
  }
  # Alternative less
  if (alternative == 'less') {
    quantiles <- c(qchisq(p=conf.level, df=nx-1, lower.tail=T),
                   0)
    conf.int <- (nx-1) * varx / quantiles
    statistic <- (nx-1) * varx / null.value
    p.value <- pchisq(statistic, nx-1)
  }
  # Alternative greater
  if (alternative == 'greater') {
    quantiles <- c(Inf,
                   qchisq(p=conf.level, df=nx-1, lower.tail=F))
    conf.int <- (nx-1) * varx / quantiles
    statistic <- (nx-1) * varx / null.value
    p.value <- pchisq(statistic, nx-1, lower.tail=F)
  }
  
  # To ensure that the output values are in the correct form
  names(statistic) <- 'X-squared'
  parameter <- nx - 1
  names(parameter) <- 'df'
  attr(conf.int, 'conf.level') <- conf.level
  estimate <- varx
  names(estimate) <- 'variance of x'
  method <- 'X-squared test for variance'
  data.name <- paste('varx =', varx, 'and nx =', nx)
  
  res <- list(statistic=statistic,
              parameter=parameter,
              p.value=p.value,
              conf.int=conf.int,
              estimate=estimate,
              null.value=null.value,
              alternative=alternative,
              method=method,
              data.name=data.name)
  return(res)
}

var_test_two <- function(varx, nx, vary, ny, 
                         alternative, conf.level, null.value) {
  alpha <- 1 - conf.level
  # Alternative two.sided
  if (alternative == 'two.sided') { 
    quantiles <- c(qf(p=alpha/2,   df1=nx-1, df2=ny-1, lower.tail=F),
                   qf(p=1-alpha/2, df1=nx-1, df2=ny-1, lower.tail=F))
    conf.int <- (varx / vary) / quantiles
    statistic <- (varx / vary) / null.value
    p.value <- 2 * min(c(pf(statistic, nx-1, ny-1, lower.tail=F),
                         pf(statistic, nx-1, ny-1, lower.tail=T)))
  }
  # Alternative less
  if (alternative == 'less') {
    quantiles <- c(Inf,
                   qf(p=conf.level, df1=nx-1, df2=ny-1, lower.tail=F))
    conf.int <- (varx / vary) / quantiles
    statistic <- (varx / vary) / null.value
    p.value <- pf(q=statistic, df1=nx-1, df2=ny-1, lower.tail=T)
  }
  # Alternative greater
  if (alternative == 'greater') {
    quantiles <- c(qf(p=conf.level, df1=nx-1, df2=ny-1, lower.tail=T),
                   0)
    conf.int <- (varx / vary) / quantiles
    statistic <- (varx / vary) / null.value
    p.value <- pf(q=statistic, df1=nx-1, df2=ny-1, lower.tail=F)
  }
  
  # To ensure that the output values are in the correct form
  names(statistic) <- 'F'
  parameter <- c(nx-1, ny-1)
  names(parameter) <- c('num df', 'denom df')
  attr(conf.int, 'conf.level') <- conf.level
  estimate <- varx / vary
  names(estimate) <- 'ratio of variances'
  method <- 'F test to compare two variances'
  data.name <- paste('varx =', varx, ', nx =', nx,
                     ', vary =', vary, 'and ny =', ny)
  
  res <- list(statistic=statistic,
              parameter=parameter,
              p.value=p.value,
              conf.int=conf.int,
              estimate=estimate,
              null.value=null.value,
              alternative=alternative,
              method=method,
              data.name=data.name)
  return(res)
}