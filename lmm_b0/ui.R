library(latex2exp)
library(markdown)

shinyUI(fluidPage(
  
    # Application title
  titlePanel("MLM Intercepto aleatorio"),
  
   sidebarLayout(
     sidebarPanel(
      p("Esta aplicación es una herramienta de aprendizaje que modela gráficamente un Modelo Lineal Mixto con intercepto aleatorio."),
      p("Esta aplicación sirve para interiorizar/evidenciar el efecto que tiene cada parámetro (fijo u aleatorio) en un Modelo Lineal Mixto con intercepto aleatorio."),
      hr(), #Traza una linea suave
      p("Modifique los valores de los parámetros y 
        observe lo que sucede con el Modelo Lineal Mixto."),
      br(), # Deja un espacio en blanco osea salta una línea.
      sliderInput(inputId = "mgrupos",
                  label = HTML("Ingrese el número de grupos/clusters :"),  #HTML para que reconozca el caracter mu y sigma (para que los dibuje bonito)
                  min = 1,
                  max = 100,
                  value = 5, #Define donde se pone el cursor del slide por defecto al correr el programa.
                  step= 1, animate = TRUE), #Animate= T pone la flecha de play en la parte inferior del slider donde si se da clic va pasando por los valores que tome, de manera automÃ¡tica.
      sliderInput(inputId = "nmuestras",
                  label = HTML("Ingrese el número de observaciones por grupo/cluster :"),
                  min = 1,
                  max = 100,
                  value = 40,
                  step= 1, animate = TRUE),
      sliderInput(inputId = "sigma2b0",
                  label = HTML("Ingrese el valor de la varianza &sigma;<sub>b</sub><sup>2</sup> del intercepto aleatorio :"),
                  min = 0.01,
                  max = 100,
                  value = 60,
                  step= 0.01, animate = TRUE),
      sliderInput(inputId = "sigma2",
                  label = HTML("Ingrese el valor de la varianza &sigma;<sup>2</sup> del error aleatorio :"),
                  min = 0.01,
                  max = 100,
                  value = 2,
                  step= 0.01, animate = TRUE),
      hr(), #Traza una linea suave
      br(),
      
      p("Otros parámetros del Modelo Lineal Mixto que el usuario puede cambiar son: "),
      numericInput(inputId = "beta0",
                  label = HTML("Ingrese el valor del intercepto fijo :"),
                  value = 0,
                  min = -100,
                  max = 100,
                  step= 0.01),
      numericInput(inputId = "beta1",
                  label = HTML("Ingrese el valor de la pendiente fija :"),
                  min = -100,
                  max = 100,
                  value = 1,
                  step= 0.01),
      
      
      
      
      img(src="logo.png", height = 60, width = 120), #, style="display: block; margin-left: auto; margin-right: auto;"
      
      br(),
      
      h5(' Autor : Jessica Nathaly Pulzara Mora.'),
      
      h5(' Asesor: Freddy Hernandez Barajas.')
      
      ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Modelo Lineal Mixto con intercepto aleatorio", align = "center"), # Crea un título de tamaño h3= mediano, donde hn con n=1,2,.. son títulos de distintos tamaños y n grande -> título más pequeño
      tabsetPanel(type = "tabs", 
                  tabPanel("Gráfica",br(), h4(HTML(" <em> Y<sub>ij</sub> &#61; &beta;<sub>&#48;</sub> &#43; &beta;<sub>&#49;</sub> X<sub>&#49;ij</sub> &#43; b<sub>&#48;i</sub> &#43; &epsilon;<sub>ij</sub> </em>"), align = "center"), br(), 
                           plotOutput("grafico1")),
                  
                  tabPanel("Teoría", br(),
                           h3("¿Qué es un MLM?"), br(),
                            p("Los modelos lineales mixtos son una generalización del modelo de regresión lineal que toma en cuenta tanto (1) la variación que se explica por los efectos fijos de las variables independientes de interés, y (2) la variación que no se explica por las variables independientes de interés - efectos aleatorios. Dado que el modelo incluye una mezcla de efectos fijos y aleatorios, se llama modelo mixto. Estos efectos aleatorios esencialmente dan estructura al término de error ε y explican los efectos individuales de las diferentes observaciones."),
                            p("Este tipo de modelos contempla la posible existencia de observaciones correlacionadas o con variabilidad heterogénea."),
                            p("Cuando un modelo líneal mixto tiene intercepto aleatorio, significa que cada muestra (o individuo) del grupo tiene variación individual en su intercepto con respecto al individuo promedio (o poblacional); lo cual proporciona mayor flexibilidad al modelo."),
                            br(), 
                           h3("Ecuación del modelo"),br(), h4(HTML("<em> Y<sub>ij</sub> &#61; &beta;<sub>&#48;</sub> &#43; &beta;<sub>&#49;</sub> X<sub>&#49;ij</sub> &#43; b<sub>&#48;i</sub> &#43; &epsilon;<sub>ij</sub> </em>"), align = "center"),br(), HTML(" Para <em> i </em> &isin; { &#49;,..., <em> n </em> } y <em> j </em> &isin; { &#49;,..., <em> m<sub>i</sub> </em> }, donde"), 
                            br(),
                            br(),
                            HTML("<em> Y<sub>ij</sub> </em> &#8712; &#8476; es la respuesta de la j-ésima muestra del i-ésimo sujeto "),
                            br(),
                            HTML("<em> &beta;<sub>&#48;</sub> </em> &#8712; &#8476; es el intercepto fijo para el modelo de regresión "),
                            br(),
                            HTML("<em> &beta;<sub>&#49;</sub> </em> &#8712; &#8476; es la pendiente fija para el modelo de regresión "),
                            br(),
                            HTML("<em> X<sub>&#49;ij</sub> </em> &#8712; &#8476; es el predictor de la j-ésima muestra del i-ésimo sujeto "),
                            br(),
                            HTML("<em> b<sub>&#48;i</sub> ~<sup>iid</sup> N(&#48;, &sigma;<sub>b</sub><sup>2</sup>) es el intercepto aleatorio para el i-ésimo sujeto "),
                            br(),
                            HTML("<em> &epsilon;<sub>ij</sub> ~ <sup>iid</sup> N(&#49;, &sigma;<sub>&epsilon;</sub><sup>2</sup>) es el termino para el error Gaussiano "),
                            br(),
                            br(),
                           h3("Utilidad Modelo"), 
                            br(),
                            p("Los modelos lineales mixtos pueden ser útiles al analizar los datos de ciertos experimentos, según la forma en que sean diseñados. Cuando hay factores que no le interesan pero que afectan a una observación, esto se denomina diseño bloqueado. Cuando, por ejemplo, desea probar cierto medicamento en una prueba médica. Un efecto aleatorio es entonces la respuesta individual de un sujeto de prueba. Esto generalmente se prueba durante un cierto período de tiempo, es decir, datos longitudinales. Puede haber ciertos grupos de sujetos que tienen un rendimiento diferente cuando se realizan los mismos experimentos en diferentes grupos, es decir, medidas repetidas. Otro ejemplo es datos anidados o cruzados."),
                            br(),
                            p("Algunos de los campos en los cuales se aplica son: Tomografía computarizada, Biología, medicina, entre otros."),
                            br(), 
                           h3("Referencias"), 
                            a(" http://eio.usc.es/pub/gridecmb/index.php/modelos-mixtos-utilizando-r "),
                           br(),
                            a(" https://web.stanford.edu/class/psych252/section/Mixed_models_tutorial.html "),
                           br(),
                            a(" https://beta.vu.nl/nl/Images/werkstuk-loon_tcm235-419752.pdf "),
                           br(),
                            a("http://users.stat.umn.edu/~helwig/notes/lmer-Notes.pdf")
                  )
                  
      )
  
    )
  )
))


