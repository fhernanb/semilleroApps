Prueba de hipótesis para la media $\mu$
=======================

Suponga que se tiene una muestra aleatoria $x_1, x_2, \ldots, x_n$ proveniente de una población normal. Se quiere estudiar la hipótesis nula $H_0: \mu = \mu_0$ y se sospecha que la media $\mu$ cumple una de las siguientes situaciones:

1. $H_1: \mu < \mu_0$
2. $H_1: \mu \neq \mu_0$
3. $H_1: \mu > \mu_0$

El estadístico para realizar la prueba es $$t_0=\frac{\bar{x} - \mu_0}{s/\sqrt{n}},$$

donde $\bar{x}$ y $s$ son la media y desviación estándar muestrales respectivamente.

Bajo la suposición de que $H_0$ es verdadera, $t_0$ tiene distribución $t$-student con $n-1$ grados de libertad.

Si se dá el caso en que la muestra aleatoria no proviene de una población normal pero se cumple que $n \geq 40$, entonces en virtud del Teorema del Límite Central el estadístico para realizar la prueba es $$Z=\frac{\bar{x} - \mu_0}{s/\sqrt{n}},$$

y en esta situación el estadístico $Z$ tiene una distribución $N(0, 1)$.