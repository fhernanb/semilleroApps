Aplicaciones Shiny
==============

![](myFigures/shiny_logo.jpg)

Aplicaciones desarrolladas con Shiny por el <a href="https://srunal.github.io/" target="_blank">Semillero de R</a> de la <a href="http://ciencias.medellin.unal.edu.co/escuelas/estadistica/" target="_blank">Escuela de Estadística</a>
de la Universidad Nacional de Colombia sede Medellín.


Para correr una de las aplicaciones usted debe tener instalado el paquete **shiny** de R, y luego debe usar la fución `runGithub()`. Por ejemplo, para correr la aplicación sobre la distribución **tamaños de muestra** usted debe copiar el siguiente código en la consola de Rstudio:

```s
if (!require("shiny"")) install.packages("shiny")
library(shiny)
runGitHub(repo="semilleroApps", 
          user="fhernanb", 
          sub="samplesize")
```

Otra forma sería clonando el repositorio o descargando el repositorio y luego copia el siguiente código en la consola de Rstudio:

`shiny::runApp("samplesize")`.

Los nombres de las aplicaciones disponibles están al lado derecho de las carpetas azules arriba de este texto. A continuación una figura ilustrativa.

![](myFigures/figura1.png)