Teorema del Límite Central
=======================

Es un teorema fundamental de probabilidad y estadística que establece que, la distribución de las medias de una muestrales $\bar{x}_n$ provenientes de una población cualquiera con varianza finita ($\sigma^2$), convergen en distribución a una normal a medida que el tamano $n$ de la muestra crece.

Simbólicamente
=======================
Si $x_1, x_2, \ldots, x_n$ son una muestra aleatoria de una población cualquiera con media $\mu$ y varianza finita $\sigma^2$, la media muestral 

$$\bar{x}_n= \frac{1}{n} \sum_{i=1}^{n}x_i$$

cumple que

$$\sqrt{n} \left( \bar{x}_n - \mu \right) / \sigma \overset{d}{\rightarrow} N(0, 1), \quad n \to \infty$$
es decir, que la distribución de $\bar{x}_n$ se puede escribir como
$$\bar{x}_n \overset{aprox}{\sim} N(\mu, \sigma^2/n)$$

a medida que $n$ aumenta.

Implicaciones
=======================
* Garantiza un patrón de comportamiento de las medias muestrales siempre y cuando se cumpla la condición que $n$ es suficientemente grande.

* La media de la distribución de las $\bar{x}$ coincide con la media de la población $\mu$.
	
* La variabilidad de la distribución de las $\bar{x}$ esta dada por $\sigma^2/n$ y disminuye a medida que aumenta $n$.

* A medida que $n$ aumenta, las medias muestrales $\bar{x}$ tiene distribución normal sin importar la distribución de la población de la cual fueron obtenidas.

