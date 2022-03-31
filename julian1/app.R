#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("dplyr")
library("magrittr")
library("ggplot2")
library("agricolae")
library("Rcpp")
sourceCpp("distancia.cpp")

expand.grid(LET = LETTERS, let = letters) %$% paste(LET, let, sep = "") -> Aa

to_nubepuntos <- function(a){
  data.frame(value = a, weight = 1/length(a)) -> nubepuntos
  class(nubepuntos) <- c("data.frame", "nubepuntos")
  nubepuntos
}

collapsa_nubes <- function(nube_list){
  
  sum(unlist(lapply(nube_list, nrow))) -> n_total
  lapply(nube_list, function(nube){
    nube$weight <- nube$weight*nrow(nube)/n_total
    nube}) -> .
  do.call(rbind, .) -> nubepuntos
  class(nubepuntos) <- c("data.frame", "nubepuntos")
  nubepuntos
  
}

list_outer <- function(a,b, fun) {
  outer(a, b, function(x,y) vapply(seq_along(x), function(i) fun(x[[i]], y[[i]]), numeric(1)))
}

list_auto <- function(a, fun){list_outer(a, a, fun)}

auto <- function(a, fun){fun(a, a)}

D_EMD <- function(nube_0, nube_1){
  rbind(
    cbind(nube_0, binary = 0),
    cbind(nube_1, binary = 1)
  ) -> tmp
  
  EMD(tmp[order(tmp$value),])
}

D_def <- function(nube_0, nube_1){
  rbind(
    cbind(nube_0, binary = 0),
    cbind(nube_1, binary = 1)
  ) -> tmp
  
  # sqrt(min(nrow(nube_0), nrow(nube_1))) * distan_np(tmp[order(tmp$value),])
  distan_def(tmp[order(tmp$value),])
}

ep_means <- function(lista_nubes, n_grupos = NULL, grupos_iniciales = NULL){
  
  if(is.null(grupos_iniciales)) {
    sample(length(lista_nubes), n_grupos, replace = FALSE) -> cuales
    
    centros <- setNames(lista_nubes[cuales], LETTERS[1:n_grupos])
  } else{
    split(lista_nubes, grupos_iniciales) -> agrupados
    lapply(agrupados, collapsa_nubes) -> centros
    
  }
  
  antes <- 0
  ahora <- 1000
  umbral <- 0.0002
  while(abs(antes - ahora) > umbral){
    antes <- ahora
    list_outer(centros, lista_nubes, D_EMD) -> dist_matriz
    letters[apply(dist_matriz, 2, which.min)] -> grupos
    sum(apply(dist_matriz, 2, min)) -> ahora
    split(lista_nubes, grupos) -> agrupados
    lapply(agrupados, collapsa_nubes) -> centros
    
  }
  
  data.frame(trt = names(lista_nubes), Grupo = grupos)
  
}

k_clouds <- function(lista_nubes, n_grupos = NULL, grupos_iniciales = NULL, umbral = 0.1, iter_max = 100){
  
  if(is.null(grupos_iniciales)) {
    sample(length(lista_nubes), n_grupos, replace = FALSE) -> cuales
    
    centros <- setNames(lista_nubes[cuales], LETTERS[1:n_grupos])
  } else{
    split(lista_nubes, grupos_iniciales) -> agrupados
    lapply(agrupados, collapsa_nubes) -> centros
    
  }
  
  antes <- 0
  minimo <- ahora <- 10000
  iter_actual <- 0
  while(abs(antes - ahora) > umbral & iter_actual < iter_max){
    antes <- ahora
    list_outer(centros, lista_nubes, D_def) -> dist_matriz
    letters[apply(dist_matriz, 2, which.min)] -> grupos
    sum(apply(dist_matriz, 2, min)) -> ahora
    split(lista_nubes, grupos) -> agrupados
    lapply(agrupados, collapsa_nubes) -> centros
    if(ahora < minimo){
      grupos_min <- grupos
      centros_min <- centros
    }
    iter_actual <- iter_actual + 1
    print(ahora)
  }
  
  data.frame(trt = names(lista_nubes), Grupo = grupos_min)
  
}

Simul_Datos <- function(Cuantas_nubes, Media, Desviacion){
  
  data.frame(
    Y = c(
      rnorm(Cuantas_nubes[1]*12, Media[1], Desviacion[1]),
      rnorm(Cuantas_nubes[2]*12, Media[2], Desviacion[2]),
      rnorm(Cuantas_nubes[3]*12, Media[3], Desviacion[3]),
      rnorm(Cuantas_nubes[4]*12, Media[4], Desviacion[4]),
      rnorm(Cuantas_nubes[5]*12, Media[5], Desviacion[5])
    ),
    X = rep(
      Aa[1:sum(Cuantas_nubes)], 
      each=12),
    grupo = rep(rep(letters[1:5], Cuantas_nubes), each = 12)
  )  
}

Simul_Boxplot <- function(Datos){ggplot(Datos) + aes(x = X, y = Y, fill = grupo) + geom_boxplot() + theme_minimal()}

Simul_ECDFplot <- function(Datos){ggplot(Datos) + aes(group = X, x = Y, colour = grupo) + geom_step(stat = "ecdf") + theme_minimal()}

Simul_Tabla <-function(Datos){
  
  # Media
  Media_trt <- Datos %$% aggregate(Y, list(X), mean) %>% setNames(c("trt", "Media"))
  
  #Duncan
  DUNCAN <- aov(Y~X, data = Datos) %>% duncan.test("X")
  
  #LSD
  LSD <- aov(Y~X, data = Datos) %>% LSD.test("X")
  
  #K nubes
  Datos %$% split(Y, X) %>% lapply(to_nubepuntos) %>% k_clouds(n_grupos = 5, umbral = 0.01) -> CC
  
  #J nubes
  Datos %$% split(Y, X) %>% lapply(to_nubepuntos) %>% list_auto(D_def) %>% as.dist %>% hclust(method = "ward.D") %>% cutree(5) %>% "["(letters, .) -> CC$Ward
  
  #EP Means
  Datos %$% split(Y, X) %>% lapply(to_nubepuntos) %>% ep_means(n_grupos = 5) %$% Grupo -> CC$EP
  
  
  list(
    Media_trt,
    setNames(unique(Datos[c("X", "grupo")]), c("trt", "Grupo")),
    CC,
    LSD$groups[-2], 
    DUNCAN$groups[-2]
  ) -> tmp
  
  Reduce(function(dtf1,dtf2) left_join(dtf1,dtf2, by = "trt"), tmp) %>% 
    setNames(c("Tratamiento", "Media", "Grupo Inicial", "K Nubes", "J Nubes", "EP Means", "LSD", "Duncan")) -> tabla
  
  tabla  
}


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Simulación"),
  hr(),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p("Esta aplicación es realizada en el marco del trabajo de investigación titulado 'Applicación de Algoritmos de Agrupamiento a Funciones Emíricas de Densidad Acumlada'; presentado como disertación para optar al título de Maestría en Ciencias - Estadística."),
      hr(),
      tabsetPanel(
        tabPanel(
          "1",
          sliderInput("C1",
                      "Cuántas nubes",
                      min = 2,
                      max = 10,
                      value = 4),
          sliderInput("M1",
                      "Media",
                      min = -10,
                      max = 10,
                      value = -2),
          sliderInput("S1",
                      "Desviación Estándar",
                      min = 0,
                      max = 5,
                      value = 0.5,
                      step = 0.5)
        ),
        tabPanel(
          "2",
          sliderInput("C2",
                      "Cuántas nubes",
                      min = 2,
                      max = 10,
                      value = 4),
          sliderInput("M2",
                      "Media",
                      min = -10,
                      max = 10,
                      value = -1),
          sliderInput("S2",
                      "Desviación Estándar",
                      min = 0,
                      max = 5,
                      value = 0.5,
                      step = 0.5)
        ),
        tabPanel(
          "3",
          sliderInput("C3",
                      "Cuántas nubes",
                      min = 2,
                      max = 10,
                      value = 4),
          sliderInput("M3",
                      "Media",
                      min = -10,
                      max = 10,
                      value = 0),
          sliderInput("S3",
                      "Desviación Estándar",
                      min = 0,
                      max = 5,
                      value = 0.5,
                      step = 0.5)
        ),
        tabPanel(
          "4",
          sliderInput("C4",
                      "Cuántas nubes",
                      min = 2,
                      max = 10,
                      value = 4),
          sliderInput("M4",
                      "Media",
                      min = -10,
                      max = 10,
                      value = 1),
          sliderInput("S4",
                      "Desviación Estándar",
                      min = 0,
                      max = 5,
                      value = 0.5,
                      step = 0.5)
        ),
        tabPanel(
          "5",
          sliderInput("C5",
                      "Cuántas nubes",
                      min = 2,
                      max = 10,
                      value = 4),
          sliderInput("M5",
                      "Media",
                      min = -10,
                      max = 10,
                      value = 2),
          sliderInput("S5",
                      "Desviación Estándar",
                      min = 0,
                      max = 5,
                      value = 0.5,
                      step = 0.5)
        )
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Box Plot",
          plotOutput("boxPlot"),
          hr(),
          p("La figura muestra las distintas nubes de puntos y sus grupos iniciales.")
        ),
        tabPanel("ECDF Plot",
          plotOutput("ecdfPlot"),
          hr(),
          p("La figura muestra las distintas nubes de puntos y sus grupos iniciales.")
        ),
        tabPanel("Pruebas",
                 tableOutput("tabla"),
                 hr(),
                 p("La tabla muestra los procesos d clasificación llevados a cabo por los distintos métodos.")
        )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  reactive(
    Simul_Datos(
      c(input$C1, input$C2, input$C3, input$C4, input$C5),
      c(input$M1, input$M2, input$M3, input$M4, input$M5),
      c(input$S1, input$S2, input$S3, input$S4, input$S5)
      )
    ) -> Datos_Simulados
   
  renderPlot(Simul_Boxplot(Datos_Simulados())) -> output$boxPlot
  renderPlot(Simul_ECDFplot(Datos_Simulados())) -> output$ecdfPlot
  renderTable(Simul_Tabla(Datos_Simulados())) -> output$tabla
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

