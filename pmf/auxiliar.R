
pmf <- function(a, b, pmf) {
  # To convert pmf to a function
  pmf <- gsub(" ", "", pmf)
  pmf <- substr(pmf, start=6, stop=nchar(pmf))
  funcion <- function(x) eval(parse(text=pmf))
  
  # To obtain probs and cumulative
  x_vals <- a:b
  n <- length(x_vals)
  probs <- numeric(n)
  for (i in 1:n) 
    probs[i] <- funcion(x_vals[i])
  suma <- sum(probs)
  cumul_probs <- cumsum(probs)
  
  list(x_vals=x_vals, 
       cumul_probs=cumul_probs,
       probs=probs, 
       suma=suma)
}



