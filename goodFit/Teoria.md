---
title: "Teoría"
author: "Juan Manuel Marin Quintero"
date: \today
output: pdf_document
bibliography: biblioExample.bib
---



# *MODELOS GAMLSS*
<p style="text-align: justify;">Los modelos GAMLSS (Modelos Aditivos Generalizados para Ubicacion, Escala y Forma) nacen debido a que en la practica los modelos de regresion lineal estandar en algunas ocasiones no cumplen los supuestos clasicos sobre normalidad y la varianza constante de los errores, ademas la linealidad de la relacion entre la variable respuesta y las explicativas rara vez se mantienen. Nelder y Wedderburn [1972] y Hastie y Tibshirani[1970] introdujeron modelos lineales generalizados (GLM) y modelos aditivos generalizados (GAM) para superar algunas de las limitaciones del modelo lineal estandar.   
</p> 
Mikis Stasinopoulos (2015)

<p style="text-align: justify;">Es un moderno enfoque basado en la distribucion de los modelos de regresion (semiparametricos), donde todos los parametros de la distribucion asumida para la repuesta pueden ser modelados como funciones aditivas de la variable explicativa.
</p>

<p style="text-align: justify;">GAMLSS proporciona mas de 90 distribuciones continuas, discretas y mixtas para modelar la variable de respuesta. Tambien se pueden usar versiones truncadas, censuradas, logaritmicas y de mezcla finita de estas distribuciones. Se anexa el listado de las Principales Distribuciones Gammls en el siguiente link</p>

http://www.gamlss.org/wp-content/uploads/2013/01/Distributions-2010-only-The-table.pdf


<p style="text-align: justify;">En este caso no se pretende modelar un modelo de regresion, sino ajustar una distribucion de las familias GAMLSS a un solo conjunto de datos explicado por una sola variable, mediante un algoritmo de maximizacion no lineal. No existen variables explicativas, ya que solo se tienen cuenta el analisis de una sola variable dada por el usuario, solo se desea saber de las distribuciones de la familias GAMLSS cual es la que mejor ajusta ese conjunto de datos explicados por dicha variable.
</p>

<p style="text-align: justify;">El usuario ingresa su base de datos en formato csv, especificando el tipo de separacion de los datos, si tiene o no encabezado de variables y selecciona una de las variables que tiene la base de datos. A continuacion elige una del grupo de familias Reales, Reales Lineales, Reales Positivas, Reales de 0 a 1, Conteos y Binomial. Cabe aclarar que tienen ciertas restricciones por ejemplo si se elijen familia Reales de 0 a 1 tienen que estar los datos en ese intervalo y Los conteos deben tener falso y verdadero. La penalizacion K es un valor que se da para castigar la cantidad de parametros de una distribucion, entre mayor sea el valor, con mayor facilidad saldran distribuciones con menor cantidad de parametros. La aplicacion internamente estima cada una de las distribuciones que hay en el grupo de la familia y mediante un criterio de AIC selecciona las mejores cuatro distribuciones. Finalmente se muestra un grafico con el valor de los parametros de dichas distribuciones con su correspondiente densidad en los datos.
</p>

# *Referencias*

Mikis Stasinopoulos, Vlasios Voudouris, Bob Rigby. 2015. Flexible Regression and Smoothing the Gamlss
Packages in R.http://www.gamlss.org/wp-content/uploads/2015/07/FlexibleRegressionAndSmoothingDraft-1.pdf (1): 17 y 18.


