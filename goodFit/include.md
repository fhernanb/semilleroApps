Prueba de bondad de ajuste
=======================

Esta aplicación hace la comparación de modelos usando el Generalized Akaike Information Criterion propuesto por Akaike (1983) dado por la expresión

$$GAIC = −2 \times l + k \times df,$$

donde $l$ corresponde al valor de log-verosimilitud estimada para el modelo y $df$ corresponde al número de parámetros estimados del modelo. El valor de $k$ es una penalización que el analista asigna por el exceso de parámetros, cuando $k=2$ el $GAIC$ coincide con el $AIC$, el Schwarz Bayesian criterion ($SBC$) propuesto por Schwarz (1978), se da cuando el valor de penalidad es $k = log(n)$, donde $n$ es el número de observaciones del modelo.

Distribuciones disponibles
=======================

Las distribuciones que se pueden elegir en la aplicación son las que están disponibles en el paquete [Manual de gamlss](https://cran.r-project.org/web/packages/gamlss/gamlss.pdf) de R, a continuación el listado de familias y las distribuciones que pertenecen a cada una de ellas.

1. Reales positivos: "EXP","GA","IG","LNO", "WEI3", "BCCGo", "exGAUS", "GG", "GIG", "BCTo", "BCPEo".
2. Reales: "EXP","GA","IG","LNO", "WEI3", "BCCGo", "exGAUS", "GG", "GIG", "BCTo", "BCPEo",
"GU", "RG" ,"LO", "NET", "TF", "PE", "SN1", "SN2", "SHASH", "EGB2", "JSU", "SEP1", "SEP2", "SEP3", "SEP4","ST1", "ST2", "ST3", "ST4", "ST5", "GT"
3. Reales entre 0 y 1: "BE", "BEINF", "BEINF0", "BEINF1", "BEOI", "BEZI", "GB1".
4. Conteos: "PO", "LG", "NBI", "NBII", "PIG", "DEL", "SI", "ZIP", "ZAP", "ZALG", "ZANBI", "ZIP2", "ZIPIG".
5. Binomiales: "BI", "BB", "ZIBI", "ZIBB", "ZABI", "ZABB".

Para obtener información sobre cada una de las anteriores distribuciones se recomienda consultar la tabla 4.2 y Apéndice A del [Manual de gamlss](http://www.gamlss.org/wp-content/uploads/2013/01/gamlss-manual.pdf).



