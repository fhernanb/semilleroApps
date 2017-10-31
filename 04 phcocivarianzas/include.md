Suponga que se tienen dos muestras aleatorias que provienen de poblaciones normales así:

- $n_1$ observaciones $x_{11}, x_{12}, \ldots, x_{1,n1}$ de una población I con  varianza $\sigma^2_1$. 
- $n_2$ observaciones $x_{21}, x_{22}, \ldots, x_{2,n2}$ de una población II con varianza $\sigma^2_2$.
- Ambas muestras son independientes entre sí.

Se quiere estudiar la hipótesis nula $H_0: \sigma_1^2 / \sigma_2^2 = 1$ y se sospecha que el cociente de varianzas $\sigma_1^2 / \sigma_2^2$ cumple una de las siguientes situaciones:

1. $H_1: \sigma_1^2 / \sigma_2^2 < 1$
2. $H_1: \sigma_1^2 / \sigma_2^2 \neq 1$
3. $H_1: \sigma_1^2 / \sigma_2^2 > 1$

El estadístico para realizar la prueba es

$$f_0=\frac{s_1^2}{s_1^2},$$

donde $s_1^2$ y $s_2^2$ son las varianzas muestrales de las poblaciones I y II respectivamente.

En este caso el estadístico $f_0$, bajo la suposición de que $H_0$ es verdadera, tiene distribución $f$ con $n_1-1$ grados de libertad en el numerador y $n_2-1$ grados de libertad en el denominador (Montgomery & Runger, 1996).
