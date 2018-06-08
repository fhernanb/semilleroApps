# Prueba de hipótesis para el cociente de varianzas

Suponga que se tienen dos muestras aleatorias que provienen de poblaciones normales así:

- $n_1$ observaciones $X_{11}, X_{12}, \ldots, X_{1,n1}$ de una población I con  varianza $\sigma^2_1$, 
- $n_2$ observaciones $X_{21}, X_{22}, \ldots, X_{2,n2}$ de una población II con varianza $\sigma^2_2$,
- ambas muestras son independientes entre sí.

En este problema se desea estudiar la hipótesis nula $H_0: \sigma_1^2 / \sigma_2^2 = 1$ de igualdad de varianzas y se sospecha que el cociente de varianzas podría estar en alguna de las siguientes situaciones:

- $H_a: \sigma_1^2 / \sigma_2^2 < 1$
- $H_a: \sigma_1^2 / \sigma_2^2 \neq 1$
- $H_a: \sigma_1^2 / \sigma_2^2 > 1$

El estadístico para realizar la prueba es:
$$
F_0=\frac{S_1^2}{S_1^2},
$$
donde $S_1^2$ y $S_2^2$ son las varianzas de las muestras I y II respectivamente. El estadístico $F_0$, bajo la suposición de que $H_0$ es verdadera, tiene distribución $f$ con $n_1-1$ grados de libertad en el numerador y $n_2-1$ grados de libertad en el denominador.

Si el valor calculado para el estadístico dado en la ecuación anterior se denota por $f_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna $H_a$ así:

- Si $H_a: \sigma_1^2 / \sigma_2^2 < \sigma^2_0$ entonces valor-$P$=$P(f_{n_1-1,n_2-1} < f_0)$.
- Si $H_a: \sigma_1^2 / \sigma_2^2 \neq \sigma^2_0$, valor-$P$=$2 \times \min \left\{ P(f_{n_1-1,n_2-1} < f_0), P(f_{n_1-1,n_2-1} > f_0) \right\}$.
- Si $H_a: \sigma_1^2 / \sigma_2^2 > \sigma^2_0$ entonces valor-$P$=$P(f_{n_1-1,n_2-1} > f_0)$.


En esta prueba, al no rechazar la hipótesis nula $H_0$, se concluye que $\sigma_1^2 / \sigma_2^2 = 1$ lo que implica en términos prácticos que $\sigma_1^2 = \sigma_2^2$, es decir que las varianzas poblacionales se pueden considerar iguales.