# Prueba de hipótesis para la media $\mu$

Suponga que se tiene el número de éxitos $X$ en una muestra de tamaño $n$. Se quiere estudiar la hipótesis nula  $H_0: p = p_0$ y se sospecha que la proporción $p$ podría estar en alguna de las siguientes situaciones:

- $H_1: p < p_0$
- $H_1: p \neq p_0$
- $H_1: p > p_0$

El estadístico para realizar la prueba es:

$$
Z_0=\frac{p-p_0}{\sqrt{\frac{p_{0}(1-p_{0})}{n}}},
$$

donde $p=X/n$ corresponde a la proporción de éxitos en una muestra de tamaño $n$. Siempre que $np$ y $n(1-p)$ sean ambos mayores o iguales a 10, y bajo la suposición de que $H_0$ es verdadera, el estadístico $Z_0$ tiene una distribución aproximadamente normal estándar.

Si el valor calculado para el estadístico dado en la ecuación \eqref{est_prop} se denota por $z_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna como:

- Si $H_a: p < p_0$, entonces valor-$P$=$P(z < z_0)$. 
- Si $H_a: p \neq p_0$, entonces valor-$P$=$2 \times P(z > \lvert z_0 \rvert)$.
- Si $H_a: p > p_0$, entonces valor-$P$=$P(z > z_0)$.

La hipótesis nula $H_0$ se rechaza si el valor-$P$ es menor que el nivel de significancia ($\alpha$).

Cuando $\left|p-p_{0}\right|>1/2n$ se usa corrección por continuidad en el estadístico de prueba. Así, dependiendo de la hipótesis alterna el estadístico tendrá una expresión diferente: 

- Si $H_a: p < p_0$, entonces
	$$
	Z_0=\frac{p-p_0 +\frac{1}{2n}}{\sqrt{\frac{p_{0}(1-p_{0})}{n}}}. 
	$$
- Si $H_a: p \neq p_0$, entonces
	$$
	Z_0=\frac{p-p_0 +\frac{1}{2n}}{\sqrt{\frac{p_{0}(1-p_{0})}{n}}}.
	$$
- Si $H_a: p > p_0$, entonces
	$$ Z_0=\frac{p-p_0-\frac{1}{2n}}{\sqrt{\frac{p_{0}(1-p_{0})}{n}}}. 
	$$

El criterio del valor-$P$ será el mismo utilizado cuando no se usa corrección por continuidad.
