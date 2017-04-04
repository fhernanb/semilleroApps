Distribución hipergeométrica
=======================
La distribución hipergeométrica con parámetros:

- $m$: número de éxitos en la población,
- $n$: número de fracasos en la población,
- $k$: tamaño de muestra,

se denota por $h(x; m, n, k)$.

Distribución binomial
=======================
La distribución binomial con parámetros:

- $n$ número de ensayos,
- $p$ como probabilidad de éxito exito individual,

se denota por $b(x; n, p)$.

Aproximación
=======================
La distribución hipergeométrica $h(x; m, n, k)$ se puede aproximar por medio de la distribución binomial $b(x; n, p)$ con

$$p = \frac{m}{m+n}$$

cuando $m+n$ tiende a infinito.

Se usa la aproximación generalmente cuando:

1. $n$ es menor que $\frac{m+n}{10}$, 
2. $\frac{m}{m+n-1}$ sea cercano a 1, 
3. $\frac{n}{m+n}$ es menor que 0.05, es decir cuando la muestra es inferior al 5% de la población.