Verosimilitud (_Likelihood_)
=======================

Uno de los metodos mas utilizados para la estimacion de parametros se le atribuye a Sir Ronald Fisher quien propuso la nocion de verosimilitud como un metodo de estimacion y como un criterio para comparar dos hipotesis (Cordeiro (1992)).

=======================
Problema:

Suponga que se tiene una distribucion de probabilidad con funci?n de densidad $f(x \sim \theta_1, \theta_2, \ldots, \theta_p)$ en la cual $\theta_1, \theta_2, \ldots, \theta_p$ corresponden a los parametros de la distribucion. Supongamos que se toma una muestra aleatoria $x_1, x_2, \ldots, x_n$.

Como utilizar la informacion muestral para estimar los parametros $\theta_1, \theta_2, \ldots, \theta_p$ de la distribucion?

# Funcion de verosimilitud $L(\boldsymbol{\theta})$

La funcion de verosimilitud se denota por $L(\boldsymbol{\theta})$ y se define como:

$$
L(\boldsymbol{\theta})=\prod_{i=1}^{i=n}f(x_i | \theta_1, \theta_2, \ldots, \theta_p)
$$
donde $\boldsymbol{\theta}=(\theta_1, \theta_2, \ldots, \theta_p)^\top$ es el vector de parametros desconocido y a estimar.

# Funci?n de log-verosimilitud $l(\boldsymbol{\theta})$

La funcion de log-verosimilitud se denota por $l(\boldsymbol{\theta})$ y se define como:

$$
l(\boldsymbol{\theta})=\sum_{i=1}^{i=n} \log f(x_i | \theta_1, \theta_2, \ldots, \theta_p)
$$

# Metodo de maxima verosimiltud

El metodo consiste en encontrar valores para $\theta_1, \theta_2, \ldots, \theta_p$ de manera que hagan maximo el valor de $l(\boldsymbol{\theta})$, eso valores que se denotan por $\hat{\theta}_1, \hat{\theta}_2, \ldots, \hat{\theta}_p$ y corresponden a los estimadores de Maxima Verosimilitud.

=======================
Referencias

Gauss M. Cordeiro, (1992). Introducao a teoria de verossimilhanca. Rio de Janeiro, UFRJ.
