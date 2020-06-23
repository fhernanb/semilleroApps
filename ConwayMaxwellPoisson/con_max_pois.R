dcmp = function(x, lambda, nu, log.z = NULL, log = FALSE)
{
  if (nu==1) return(dpois(x,lambda,log=log))
  
  # Perform argument checking
  if (lambda < 0 || nu < 0)
    stop("Invalid arguments, only defined for lambda >= 0, nu >= 0");
  if (x < 0 || x != floor(x))
    return (0);
  if (is.null(log.z))
    log.z = com.compute.log.z(lambda, nu);
  
  # Return pmf
  log.d = x*log(lambda)-nu*lfactorial(x)-log.z
  if (log) {
    return(log.d)
  } else {
    return(exp(log.d))
  }
}

com.compute.log.z = function(lambda, nu, log.error = 1e-6)
{
  # Perform argument checking
  if (lambda <= 0 || nu < 0)
    stop("Invalid arguments, only defined for lambda > 0, nu >= 0");
  
  if (nu==0) return(-log(1-lambda)) # Geometric sum
  if (nu==1) return(exp(-lambda))  # Poisson normalizing constant
  
  # Initialize values
  j = 0;
  llambda = log(lambda)                                 # precalculate for speed
  lfact = 0                                             # log(factorial(0))
  z = j * llambda - nu * lfact;                         # first term in sum
  z.last = -Inf                                         # to ensure entering the loop
  
  # Continue until we have reached specified precision
  while (abs(z - z.last) > log.error) {
    z.last = z;                                         # For comparison in while statement
    j = j + 1;                                          # Next term in sum
    lfact = lfact+log(j)                                # Calculate increment for log factorial
    z = com.log.sum(z, j * llambda - nu * lfact );      # Log of current sum
  }
  return (z);
}


com.log.sum = function(x,y)		# log.sum(x,y) = log( exp(x) + exp(y) )
{
  if (x == -Inf)
  { return (y); }
  else if (y == -Inf)
  { return (x); }
  else if (x > y)
  { return (x + log1p( exp(y - x) ) ); }
  else
  { return (y + log1p( exp(x - y) ) ); }
}