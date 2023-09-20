
pdf <- function(a, b, cuantil, pdf) {
  # To convert pmf to a function
  pdf <- gsub(" ", "", pdf)
  pdf <- substr(pdf, start=6, stop=nchar(pdf))
  pdf <- paste(pdf, ' * x^0')
  fun <- function(x) eval(parse(text=pdf))
  prob <- integrate(fun, lower=a, upper=cuantil)$value
  area <- integrate(fun, lower=a, upper=b)$value
  list(prob=prob, area=area, fun=fun)
}



