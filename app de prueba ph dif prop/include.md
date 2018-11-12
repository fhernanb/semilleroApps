# Prueba de hipótesis para la media $\mu$

Suponga que se tienen $X$ y $Y$ éxitos de dos variables aleatorias binomiales con las siguientes características:

- $X$ número de éxitos observados en $n_1$ ensayos cuya probabilidad de éxito es $p_1$.
- $Y$ número de éxitos observados en $n_2$ ensayos cuya probabilidad de éxito es $p_2$. 

En este caso se quiere estudiar la hipótesis nula $H_0: p_1 - p_2 = \delta_0$ y se sospecha que la diferencia de proporciones $p_1 - p_2$ podría estar en alguna de las siguientes situaciones:

- $H_a: p_1 - p_2 < \delta_0$
- $H_a: p_1 - p_2 \neq \delta_0$
- $H_a: p_1 - p_2 > \delta_0$


El estadístico para realizar la prueba es:
$$
Z_0=\frac{p_1 -p_2 - \delta_0}{\sqrt{\frac{p_{1}(1-p_{1})}{n_1} +\frac{p_{2}(1-p_{2})}{n_2}}},
$$

donde $p_1 =X/n_1$ y $p_2 =Y/n_2$ corresponden a la proporción de éxitos en una muestra de tamaño $n_1$ y $n_2$, respectivamente. En estas pruebas es común considerar que $\delta_0=0$. En este caso, una práctica estándar es crear una estimación conjunta de las proporciones poblacionales tal que $p_1=p_2$, de tal forma que el estadístico de prueba sea:

$$
Z_0=\frac{p_1 -p_2 }{\sqrt{ p(1-p)\left(\frac{1}{n_1} +\frac{1}{n_2} \right)}},
$$

donde $p=(X+Y)/(n_1 + n_2)$. Bajo la suposición de que $H_0$ es verdadera, el estadístico $Z_0$ en \eqref{est_difprop2}tiene una distribución aproximadamente normal estándar.

Si el valor calculado para el estadístico dado en la ecuación se denota por $z_0$, entonces el valor-$P$ de la prueba se calcula de acuerdo a la hipótesis alterna como:

- Si $H_a:p_1 - p_2 < 0$, entonces valor-$P$=$P(z < z_0)$. 
- Si $H_a:p_1 - p_2 \neq 0$, entonces valor-$P$=$2 \times P(z > \lvert z_0 \rvert)$.
- Si $H_a: p_1 - p_2 > 0$, entonces valor-$P$=$P(z > z_0)$.

La hipótesis nula $H_0$ se rechaza si el valor-$P$ es menor que el nivel de significancia ($\alpha$).\\

Cuando $\left| p_1-p_2 \right|> 0.5 \left( 1/n_1 + 1/n_2 \right)$ se usa corrección por continuidad en el estadístico de prueba. Así, dependiendo de la hipótesis alterna el estadístico \eqref{est_difprop2} tendrá una expresión diferente: 

- Si $H_a: p_1 -p_2 < 0$, entonces
	$$
	Z_0=\frac{p_1 -p_2 +\frac{1}{2} \left( \frac{1}{n_1} + \frac{1}{n_2} \right)}{\sqrt{ p(1-p)\left(\frac{1}{n_1} +\frac{1}{n_2} \right)}}. 
  $$
- Si $H_a: p_1 -p_2 \neq 0$, entonces
	$$
	Z_0=\frac{p_1 -p_2 +\frac{1}{2} \left( \frac{1}{n_1} + \frac{1}{n_2} \right)}{\sqrt{ p(1-p)\left(\frac{1}{n_1} +\frac{1}{n_2} \right)}}.
	$$
- Si $H_a: p_1 -p_2 > 0$, entonces 
  $$
	Z_0=\frac{p_1 -p_2 -\frac{1}{2} \left( \frac{1}{n_1} + \frac{1}{n_2} \right)}{\sqrt{ p(1-p)\left(\frac{1}{n_1} +\frac{1}{n_2} \right)}}. 
	$$

El criterio del valor-$P$ será el mismo utilizado cuando no se usa corrección por continuidad.