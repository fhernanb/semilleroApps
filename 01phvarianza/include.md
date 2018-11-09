Sea $X_1, X_2, \ldots, X_n$ una muestra aleatoria proveniente de una población normal con varianza $\sigma^2$ y supóngase que se desea probar la hipótesis de que $\sigma^2$ es igual a un valor de referencia $\sigma^2_0$, es decir, la hipótesis nula a estudiar es $H_0: \sigma^2 = \sigma_0^2$. En este problema las sospechas sobre la varianza  $\sigma^2$ se resumen por medio de la hipótesis alterna ($H_a$) en una de tres situaciones como se muestra a continuación:

- $H_a: \sigma^2 < \sigma_0^2$,
- $H_a: \sigma^2 \neq \sigma_0^2$,
- $H_a: \sigma^2 > \sigma_0^2$,

El estadístico para realizar la prueba es:

$$
	X_0^2=\frac{(n-1) S^2}{\sigma_0^2},
$$

donde $S$ corresponde a la desviación estándar muestral. Bajo la suposición de que $H_0$ es verdadera, el estadístico $X_0^2$ tiene distribución $\chi^2$ con $n-1$ grados de libertad.

Si el valor calculado para el estadístico dado en la ecuación anterior se denota por $\chi_0^2$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna $H_a$ así:

- Si $H_a: \sigma^2 < \sigma_0^2$ entonces valor-$P$=$P(\chi^2_{n-1} < \chi_0^2)$. 
- Si $H_a: \sigma^2 \neq \sigma_0^2$ entonces valor-$P$=$2 \times \min \left\{ P(\chi^2_{n-1} < \chi_0^2),~ P(\chi^2_{n-1} > \chi_0^2) \right\}$.
- Si $H_a: \sigma^2 > \sigma_0^2$ entonces valor-$P$=$P(\chi^2_{n-1} > \chi_0^2)$.

