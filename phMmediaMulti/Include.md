# Prueba de Hipótesis sobre $\boldsymbol{\mu}$ cuando $\boldsymbol{\Sigma}$ conocida.

Sea ${\boldsymbol{X}}_{1}$,${\boldsymbol{X}}_{2}$,..., ${\boldsymbol{X}}_{n}$ proveniente de una población normal $p$-variada con $\boldsymbol{\mu}$ desconocida y $\boldsymbol{\Sigma}$ conocida ${\boldsymbol{X}}_{i}$~${N}_{p}(\boldsymbol{\mu},\boldsymbol{\Sigma})$, se busca detectar la existencia de posibles diferencias entre el vector de medias poblacional $\boldsymbol{\mu}$ y el vector de medias de referencia ${\boldsymbol{\mu}}_{0}$=(${\mu}_{10}$,...,${\mu}_{p0}{)}^\top$.

Para verificar la Hipótesis:
${H}_{0}$: ${\boldsymbol{\mu}}={\boldsymbol{\mu}}_{0}$,

donde ${\boldsymbol{\mu}}_{0}$ es un vector específico, se usa como estadístico de prueba siguiente:

${\chi}_{0}^{2}$ = $n(\bar{\boldsymbol{X}}-{\boldsymbol{\mu}}_{0}{)}^{\top}{\boldsymbol{\Sigma}}^{-1}(\bar{\boldsymbol{X}} -{\boldsymbol{\mu}}_{0}{)}$ ~ ${\chi}_{(p)}^{2}$ , bajo ${H}_{0}$.

Se usa entonces como región crítica de rechazo, el conjunto de puntos tales que: 

${\chi}_{0}^{2}$ $\ge$ ${\chi}_{(\alpha,p)}^{2}$

donde ${\chi}_{(\alpha,p)}^{2}$, es el número tal que

$P({\chi}_{p}^{2}$ > ${\chi}_{(\alpha,p)}^{2})$ = $\alpha$

Así, una muestra que cumpla la desigualdad ${\chi}_{0}^{2}$ $\ge$ ${\chi}_{(\alpha,p)}^{2}$ , provoca el rechazo de la hipótesis ${H}_{0}$: ${\boldsymbol{\mu}}={\boldsymbol{\mu}}_{0}$.



# Prueba de Hipótesis sobre $\boldsymbol{\mu}$ cuando $\boldsymbol{\Sigma}$ desconocida.

Sea ${\boldsymbol{X}}_{1}$,${\boldsymbol{X}}_{2}$,..., ${\boldsymbol{X}}_{n}$ una muestra aleatoria de una población normla $p$-variada media $\boldsymbol{\mu}$ y matriz de varianzas-covarianzas $\boldsymbol{\Sigma}$, ambas desconocidas.

Definiendo la hipótesis ${H}_{0}$: ${\boldsymbol{\mu}}={\boldsymbol{\mu}}_{0}$, con base en una muestra aleatoria con distribución ${N}_{p}(\boldsymbol{\mu},\boldsymbol{\Sigma})$. 

La expresión ${T}^{2}$ = $n(\bar{\boldsymbol{X}}-{\boldsymbol {\mu}}_{0}{)}^{\top}{S}^{-1}(\bar{\boldsymbol{X}} -{\boldsymbol{\mu}}_{0}{)}$ tiene una distribución ${T}^{2}$ de Hotelling con $v$ = $n-1$ grados de libertad.

Si el nivel de significancia es $\alpha$, entonces, el percentil $(1-\alpha)%$ de la distribución $F$ se considera así:


${T}_{0}^{2}$ = $\frac{(n-1){\times}p}{(n-p)}F(p,n-p)(\alpha)$ = ${T}_{\alpha,p,n-1}^{2}$


Así, una muestra que cumpla la desigualdad ${T}^{2}$ > $\frac{(n-1){\times}p}{(n-p)}{F}_{(p,n-p)}(\alpha)$, provoca el rechazo de la hipótesis ${H}_{0}$: ${\boldsymbol{\mu}}={\boldsymbol{\mu}}_{0}$.