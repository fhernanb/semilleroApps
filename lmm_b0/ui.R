library(latex2exp)
library(markdown)

shinyUI(fluidPage(
  
    # Application title
  titlePanel("MLM con Intercepto aleatorio"),
  
   sidebarLayout(
     sidebarPanel(
      p("Esta aplicación es una herramienta de aprendizaje que ilustra 
        el Modelo Lineal Mixto con intercepto aleatorio."),
      p("Esta aplicación sirve para comprender el impacto que tiene cada 
        parámetro del Modelo Lineal Mixto con intercepto aleatorio."),
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
                  label = HTML("Ingrese el número de observaciones por 
                               grupo/cluster :"),
                  min = 1,
                  max = 100,
                  value = 40,
                  step= 1, animate = TRUE),
      sliderInput(inputId = "sigma2b0",
                  label = HTML("Ingrese el valor de la varianza 
                               &sigma;<sub>b</sub><sup>2</sup> del 
                               intercepto aleatorio :"),
                  min = 0.01,
                  max = 100,
                  value = 60,
                  step= 0.01, animate = TRUE),
      sliderInput(inputId = "sigma2",
                  label = HTML("Ingrese el valor de la varianza 
                               &sigma;<sup>2</sup> del error 
                               aleatorio :"),
                  min = 0.01,
                  max = 100,
                  value = 2,
                  step= 0.01, animate = TRUE),
      hr(), #Traza una linea suave

      p("Otros parámetros del Modelo Lineal Mixto que el 
      usuario se muestran a continuación. Por favor modifíquelos."),
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
      
      
      
      
      img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
          height = 56, width = 140),
      
      br(),
      
      h5('Autor: Jessica Nathaly Pulzara Mora.'),
      
      h5('Autor: Freddy Hernandez Barajas.')
      
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Modelo Lineal Mixto con intercepto aleatorio", 
         align = "center"), # Crea un título de tamaño h3= mediano, donde hn con n=1,2,.. son títulos de distintos tamaños y n grande -> título más pequeño
      tabsetPanel(type = "pills", 
                  tabPanel("Ilustración",br(), 
                           h4(HTML("Modelo <em> Y<sub>ij</sub> &#61; &beta;<sub>&#48;</sub> &#43; &beta;<sub>&#49;</sub> X<sub>&#49;ij</sub> &#43; b<sub>&#48;i</sub> &#43; &epsilon;<sub>ij</sub> </em>"), align = "center"), br(), 
                           plotOutput("grafico1")),
                  
                  tabPanel("Teoría", includeHTML("teoria.html"))
                  
      )
  
    )
  )
))


