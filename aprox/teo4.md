Distribución hipergeométrica
=======================
La distribución hipergeométrica se puede definir con los siguientes parámetros:

- $m$: número de éxitos en la población,
- $n$: número de fracasos en la población,
- $k$: tamaño de muestra.

Aproximación
=======================
La distribución hipergeométrica $h(x; m, n, k)$ se puede aproximar por medio de la distribución binomial si

$$\frac{k}{m+n} \leq 0.05,$$

es decir, si el tamaño de la muestra __NO__ sobrepasa el 5 por ciento de la población.


La nueva distribución binomial de aproximación tendrá entonces:

Media $$\mu = k \frac{m}{m + n}$$

Varianza $$\sigma^2=k \frac{m}{m+n} (1-\frac{m}{m+n})$$

Tomado de Walpole, R. E., Myers, R. H., Myers, S. L., & Ye, K. (2012). Probability & statistics for engineers & scientists. Boston: Prentice Hall, página 155.