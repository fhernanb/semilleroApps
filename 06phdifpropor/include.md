# Prueba de hipótesis para la diferencia de medias

Suponga que se tienen dos muestras aleatorias que provienen de poblaciones normales así:

- $n_1$ observaciones $X_{11}, X_{12}, \ldots, X_{1,n1}$ de una población I con media $\mu_1$ y varianza $\sigma^2_1$,
- $n_2$ observaciones $X_{21}, X_{22}, \ldots, X_{2,n2}$ de una población II con media $\mu_2$ y varianza $\sigma^2_2$,
- ambas muestras son independientes entre sí.

En este problema se quiere estudiar la hipótesis nula $H_0: \mu_1 - \mu_2 = \delta_0$ y se sospecha que la diferencia de medias $\mu_1 - \mu_2$ podría estar en alguna de las siguientes situaciones:

- $H_a: \mu_1 - \mu_2 < \delta_0$
- $H_a: \mu_1 - \mu_2 \neq \delta_0$
- $H_a: \mu_1 - \mu_2 > \delta_0$

El valor $\delta_0$ corresponde a la diferencia entre las medias poblacionales; cuando $\delta_0=0$, la hipótesis nula se convierte en $H_0: \mu_1 = \mu_2$ lo que significa que se está probando igualdad de medias.

Para realizar esta prueba de hipótesis se deben diferenciar dos casos, uno en el que las varianzas poblacionales son iguales y otro caso en el que las varianzas poblaciones son diferentes, esto se puede chequear utilizando la prueba de comparación de varianzas. Para cada uno de los casos hay un estadístico de prueba, una distribución asociada y un valor-$P$, a continuación se presentan los dos casos en detalle.

## Caso 1: varianzas poblacionales iguales $\sigma_1^2 = \sigma_2^2$

En este caso el estadístico para realizar la prueba es:
$$
T_0=\frac{\bar{X}_1 - \bar{X}_2 - \delta_0}{S_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}},
$$
donde $\bar{X}_1$ y $\bar{X}_2$ son las medias de las muestras I y II respectivamente; la cantidad $S_p^2$ es una varianza combinada y se calcula como:
$$S_p^2=\frac{(n_1-1)S_1^2+(n_2-1)S_2^2}{n_1+n_2-2},$$
donde $S_1^2$ y $S_2^2$ son las varianzas de las muestras I y II respectivamente. En este caso el estadístico $T_0$, bajo la suposición de que $H_0$ es verdadera, tiene distribución $t$-student con $n_1+n_2-2$ grados de libertad \cite{Walpole12}.

Si el valor calculado para el estadístico dado en la ecuación \eqref{est_dif_med_var_igu} se denota por $t_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna $H_a$ así:

- Si $H_a: \mu_1 - \mu_2 < \delta_0$ entonces valor-$P$=$P(t_{n_1+n_2-2} < t_0)$. 
- Si $H_a: \mu_1 - \mu_2 \neq \delta_0$ entonces valor-$P$=$2 \times P(t_{n_1+n_2-2} > \lvert t_0 \rvert)$.
- Si $H_a: \mu_1 - \mu_2 > \delta_0$ entonces valor-$P$=$P(t_{n_1+n_2-2} > t_0)$.

## Caso 2: varianzas poblacionales diferentes $\sigma_1^2 \neq \sigma_2^2$

En este caso el estadístico para realizar la prueba es:
$$
T_0=\frac{\bar{X}_1 - \bar{X}_2 - \delta_0}{\sqrt{\frac{S_1^2}{n_1} + \frac{S_2^2}{n_2}}}.
$$
Bajo la suposición de que $H_0$ es verdadera, $T_0$ tiene distribución $t$-student con $v$ grados de libertad \cite{Walpole12}, en donde $v$ se calcula como:
$$v=\frac{ \left( \frac{S_1^2}{n_1} + \frac{S_2^2}{n_2} \right)^2 }{ \frac{(S_1^2/n_1)^2}{n_1-1} + \frac{(S_2^2/n_2)^2}{n_2-1}}$$

Si el valor calculado para el estadístico dado en la ecuación \eqref{est_dif_med_var_dif} se denota por $t_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna $H_a$ así:

- Si $H_a: \mu_1 - \mu_2 < \delta_0$ entonces valor-$P$=$P(t_{v} < t_0)$. 
- Si $H_a: \mu_1 - \mu_2 \neq \delta_0$ entonces valor-$P$=$2 \times P(t_{v} > \lvert t_0 \rvert)$.
- Si $H_a: \mu_1 - \mu_2 > \delta_0$ entonces valor-$P$=$P(t_{v} > t_0)$.



