Prueba de hipotesis para la media $\mu$ holaaa
=======================

Suponga que se tiene una muestra aleatoria $x_1, x_2, \ldots, x_n$ proveniente de una poblacion normal. Se quiere estudiar la hipotesis nula $H_0: \mu = \mu_0$

=======================
Problema:



```r
x <- rnorm(n=50, mean=5)
t.test(x, mu0=51)
```

```
## 
## 	One Sample t-test
## 
## data:  x
## t = 37.27, df = 49, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  4.663148 5.194670
## sample estimates:
## mean of x 
##  4.928909
```




=======================
Referencias

Gauss M. Cordeiro, (1992). Introducao a teoria de verossimilhanca. Rio de Janeiro, UFRJ.
