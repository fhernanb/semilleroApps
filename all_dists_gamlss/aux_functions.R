# Funcion para extraer los valores de mu, sigma, nu y tau
# que tienen por defecto las distribuciones de gamlss
# el resultado es una lista con los parametros y los valores
extract_param_gamlss_fam <- function(x) {
  param <- formals(paste0("d", x))
  param <- param[-1]
  param <- rev(param)[-1]
  param
  # param <- unlist(param)
  # paste0(paste0(names(param), "=", param), collapse=",")
}

# Funcion que identifica plenamente cualquier distribucion
# de gamlss
# dist es "GA", "NO" o "PO"
identifica <- function(dist, input=NULL) {
  d <- gamlss.family(dist)
  
  param <- extract_param_gamlss_fam(dist) # lista con default parametros
  
  # if (d$nopar == 1) {
  #   if (is.na(input$mu)) mu <- param$mu
  #   else mu <- "input$mu"
  # }
  # 
  # if (d$nopar == 2) {
  #   if (is.na(input$mu))       mu <- param$mu
  #   else mu <- "input$mu"
  #   if (is.na(input$sigma)) sigma <- param$sigma
  #   else sigma <- "input$sigma"
  # }
  # 
  # if (d$nopar == 3) {
  #   if (is.na(input$mu))       mu <- param$mu
  #   else mu <- "input$mu"
  #   if (is.na(input$sigma)) sigma <- param$sigma
  #   else sigma <- "input$sigma"
  #   if (is.na(input$nu))       nu <- param$nu
  #   else nu <- "input$nu"
  # }
  # 
  # if (d$nopar == 4) {
  #   if (is.na(input$mu))       mu <- param$mu
  #   else mu <- "input$mu"
  #   if (is.na(input$sigma)) sigma <- param$sigma
  #   else sigma <- "input$sigma"
  #   if (is.na(input$nu))       nu <- param$nu
  #   else snu <- "input$nu"
  #   if (is.na(input$tau))     tau <- param$stau
  #   else tau <- "input$tau"
  # }
  
  which_param <- case_when(
    d$nopar == 1 ~ ",mu=input$mu",
    d$nopar == 2 ~ ",mu=input$mu,sigma=input$sigma",
    d$nopar == 3 ~ ",mu=input$mu,sigma=input$sigma,nu=input$nu",
    d$nopar == 4 ~ ",mu=input$mu,sigma=input$sigma,nu=input$nu,tau=input$tau"
  )
  
  # which_param <- case_when(
  #   d$nopar == 1 ~ ",mu=mu",
  #   d$nopar == 2 ~ ",mu=mu,sigma=sigma",
  #   d$nopar == 3 ~ ",mu=mu,sigma=sigma,nu=nu",
  #   d$nopar == 4 ~ ",mu=mu,sigma=sigma,nu=nu,tau=tau"
  # )
  
  list(family=d$family, parameters=d$parameters, nopar=d$nopar,
       type=d$type, which_param=which_param, param=param)
}

# Funcion para dibujar el diagrama de probabilidades
# input es el ingreso de la app
plot_discrete <- function(input) {
  
  the_dist <- identifica(input$distribution)
  
  xs <- seq(from=input$minimo, to=input$maximo)
  texto <- eval(paste0("d", input$distribution, "(xs",
                       the_dist$which_param, ")"))
  ys <- eval(parse(text=texto))
  plot(x=xs, y=ys, type='p', xlab='X', ylab='Probability', 
       col='tomato',lwd=2,las=1, main=the_dist$family)
  segments(xs, 0, xs, ys)
}

# Funcion para dibujar la pdf
# input es el ingreso de la app
plot_continuous <- function(input) {
  
  the_dist <- identifica(input$distribution)
  
  param <- extract_param_gamlss_fam(input$distribution) # lista con default parametros
  
  # if (the_dist$nopar == 1) {
  #   if (is.na(input$mu)) input$mu <- param$mu
  # }
  
  texto <- eval(paste0("curve(d", input$distribution, "(x",
                       the_dist$which_param, 
                       #",mu=5,sigma=2",
                       ")",
                       ",from=input$minimo,to=input$maximo,",
                       "col='tomato',lwd=2,las=1,main=the_dist$family,
                       xlab='X', ylab='Density')"))
  eval(parse(text=texto))
  #plot(c(-5, 5), c(0, 1), xlab="", ylab="", type='n', main=input$mu, sub=input$sigma)
}

# Esta funcion sirve para obtener los limites de integracion
# de pdf continuas
limites <- function(dist) {
  d <- gamlss.family(dist)
  regions <- c(d$y.valid(-0.5), d$y.valid( 0.5), d$y.valid( 1.5))
  limites_int <- case_when(
    identical(regions, c(TRUE,TRUE,TRUE))   ~ ",lower=-Inf,upper=Inf",
    identical(regions, c(FALSE,TRUE,TRUE))  ~ ",lower=0,upper=Inf",
    identical(regions, c(FALSE,TRUE,FALSE)) ~ ",lower=0,upper=1"
  )
  limites_int
}

# Funcion para calcular los momentos teoricos
theoMomentSK <- function(fam="NO", lower=-Inf, upper=Inf, ...) {
  fam <- as.gamlss.family(fam)
  fname <- fam$family[[1]]
  dfun <- paste("d", fname, sep = "")
  pdf <- eval(parse(text = dfun))
  xk_pdf <- function(x, k=1, ...) x^k * pdf(x, ...)
  # Moments about zero
  if (fam$type == "Discrete") {
    mu1_p <- try(add(f=xk_pdf, k=1, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu2_p <- try(add(f=xk_pdf, k=2, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu3_p <- try(add(f=xk_pdf, k=3, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu4_p <- try(add(f=xk_pdf, k=4, lower=lower, upper=upper, ...)$value, silent=TRUE)
  }
  else {
    mu1_p <- try(integrate(f=xk_pdf, k=1, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu2_p <- try(integrate(f=xk_pdf, k=2, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu3_p <- try(integrate(f=xk_pdf, k=3, lower=lower, upper=upper, ...)$value, silent=TRUE)
    mu4_p <- try(integrate(f=xk_pdf, k=4, lower=lower, upper=upper, ...)$value, silent=TRUE)
  }
  # If there are some errors in the integrals
  if (class(mu1_p) == "try-error") mu1_p <- NA
  if (class(mu2_p) == "try-error") mu2_p <- NA
  if (class(mu3_p) == "try-error") mu3_p <- NA
  if (class(mu4_p) == "try-error") mu4_p <- NA
  # Central moments
  mu2 <- mu2_p - mu1_p^2
  mu3 <- mu3_p - 3 * mu2_p * mu1_p + 2 * mu1_p^3
  mu4 <- mu4_p - 4 * mu3_p * mu1_p + 6 * mu2_p * mu1_p^2 - 3 * mu1_p^4
  # Skewness and Kurtosis
  gamma.1 <- mu3/mu2^1.5
  beta.2  <- mu4/mu2^2
  gamma.2 <- mu4/mu2^2 - 3
  # Transforming Skewness and Kurtosis
  tskew <- gamma.1/(1 + abs(gamma.1))
  tkurt <- gamma.2/(1 + abs(gamma.2))
  
  list(mom.skew = gamma.1, trans.mom.skew = tskew, 
       mom.kurt = beta.2, excess.mom.kurt = gamma.2, trans.mom.kurt = tkurt,
       expected_value = mu1_p, variance = mu2)
}


