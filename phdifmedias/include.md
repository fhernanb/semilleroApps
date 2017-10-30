Prueba de hipótesis para la diferencia de medias $\mu_1 - \mu_2$
=======================

Suponga que se tienen dos muestras aleatorias que provienen de poblaciones normales así:

- $x_{11}, x_{12}, \ldots, x_{1,n1}$ proveniente de una población I con media $\mu_1$ y varianza $\sigma^2_1$. 
- $x_{21}, x_{22}, \ldots, x_{2,n2}$ proveniente de una población II con media $\mu_2$ y varianza $\sigma^2_2$.
- Ambas muestras son independientes entre sí.

Se quiere estudiar la hipótesis nula $H_0: \mu_1 - \mu_2 = \delta_0$ y se sospecha que la diferencia de medias $\mu_1 - \mu_2$ cumple una de las siguientes situaciones:

1. $H_1: \mu_1 - \mu_2 < \delta_0$
2. $H_1: \mu_1 - \mu_2 \neq \delta_0$
3. $H_1: \mu_1 - \mu_2 > \delta_0$

Para realizar la prueba de hipótesis se deben diferenciar dos casos, uno en el que las varianzas son **iguales** y otro caso en el que son **diferentes**, para cada uno de estos casos hay un estadístico de prueba y una distribución del estadístico, a continuación se presentan los dos casos en detalle.

### Caso 1, varianzas poblacionales iguales $\sigma_1^2 = \sigma_2^2$
En este caso el estadístico para realizar la prueba es

$$t=\frac{\bar{x}_1 - \bar{x}_2 - \delta_0}{S_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}},$$

donde $\bar{x}_1$ y $\bar{x}_2$ son las medias muestrales de las poblaciones I y II respectivamente, la cantidad $S_p$ es una desviación combinada y se obtiene como

$$S_p=\frac{(n_1-1)s_1^2+(n_2-1)s_2^2}{n_1+n_2-2},$$

donde $s_1^2$ y $s_2^2$ son las varianzas muestrales de las poblaciones I y II respectivamente.

En este caso el estadístico $t$, bajo la suposición de que $H_0$ es verdadera, tiene distribución $t$-student con $n_1+n_2-2$ grados de libertad.


### Caso 2, varianzas poblacionales diferentes $\sigma_1^2 \neq \sigma_2^2$
En este caso el estadístico para realizar la prueba es 

$$t=\frac{\bar{x}_1 - \bar{x}_2 - \delta_0}{\sqrt{\frac{s_1^2}{m} + \frac{s_2^2}{n}}}$$

El estadístico $t$ bajo la suposición de que $H_0$ es verdadera tiene distribución $t$-student con $v$ grados de libertad calculados como:

$$v=\frac{ \left( \frac{s_1^2}{m} + \frac{s_2^2}{n} \right)^2 }{ \frac{(s_1^2/m)^2}{m-1} + \frac{(s_2^2/n)^2}{n-1}}$$
