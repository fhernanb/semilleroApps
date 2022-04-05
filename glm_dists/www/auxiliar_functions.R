
dgamma_glm <- function(x, mu, phi) {
  if (any(mu <= 0)) 
    stop(paste("mu must be positive", "\n", ""))
  if (any(phi <= 0)) 
    stop(paste("phi must be positive", "\n", ""))
  if (any(x < 0)) 
    stop(paste("x must be positive", "\n", ""))
  dgamma(x=x, shape=1/phi, scale=mu*phi)
}

dinvgaus_glm <- function(x, mu, phi) {
  if (any(mu <= 0)) 
    stop(paste("mu must be positive", "\n", ""))
  if (any(phi <= 0)) 
    stop(paste("phi must be positive", "\n", ""))
  if (any(x < 0)) 
    stop(paste("x must be positive", "\n", ""))
  (2*pi*x^3*phi)^-0.5 * exp(-(x-mu)^2/(2*phi*x*mu^2))
}