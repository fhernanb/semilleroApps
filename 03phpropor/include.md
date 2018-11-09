# Prueba de hipótesis para la media $\mu$

Suponga que se tiene una muestra aleatoria $X_1, X_2, \ldots, X_n$ proveniente de una población normal. Se quiere estudiar la hipótesis nula $H_0: \mu = \mu_0$ y se sospecha que la media $\mu$ cumple una de las siguientes situaciones:

1. $H_a: \mu < \mu_0$
2. $H_a: \mu \neq \mu_0$
3. $H_a: \mu > \mu_0$

El estadístico para realizar la prueba es $$T_0=\frac{\bar{X} - \mu_0}{S/\sqrt{n}},$$

donde $\bar{X}$ y $S$ son la media y desviación estándar muestral respectivamente.

Bajo la suposición de que $H_0$ es verdadera, $T_0$ tiene distribución $t$-student con $n-1$ grados de libertad.

Si el valor calculado para el estadístico dado en la ecuación anterior se denota por $t_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna $H_a$ así:

- Si $H_a: \mu < \mu_0$ entonces valor-$P$=$P(t_{n-1} < t_0)$. 
- Si $H_a: \mu \neq \mu_0$ entonces valor-$P$=$2 \times P(t_{n-1} > \lvert t_0 \rvert)$.
- Si $H_a: \mu > \mu_0$ entonces valor-$P$=$P(t_{n-1} > t_0)$.

Si se dá el caso en que la muestra aleatoria no proviene de una población normal pero se cumple que $n \geq 40$, entonces el estadístico para realizar la prueba es:
$$
Z_0=\frac{\bar{X} - \mu_0}{S/\sqrt{n}},
$$
y en este caso el estadístico $Z_0$, en virtud del Teorema del Límite Central, tiene una distribución $z \sim N(0, 1)$ bajo la suposición de que $H_0$ es verdadera. Si el valor calculado del estadístico es $z_0$, se pueden usar las expresiones anteriores para calcular el valor-$P$ sustituyendo $t_0$ por $z_0$ y $t_{n-1}$ por $z$.

En cualquiera de los casos, la hipótesis nula $H_0$ se rechaza si el valor-$P$ es menor que el nivel de significancia ($\alpha$) fijado previamente por el analista.
