#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("ggplot2")
library("magrittr")
library("Rcpp")

sourceCpp("distancia.cpp")

to_nubepuntos <- function(a){
  data.frame(value = a, weight = 1/length(a)) -> nubepuntos
  class(nubepuntos) <- c("data.frame", "nubepuntos")
  nubepuntos
}

dist_nubes <- function(nube_0, nube_1){
  rbind(
    cbind(nube_0, binary = 0),
    cbind(nube_1, binary = 1)
  ) -> tmp
  
  distan_np(tmp[order(tmp$value),])
}

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



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Distintas Distancias entre Nubes de Puntos"),
   
   hr(),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       p("Esta aplicación es realizada en el marco del trabajo de investigación titulado 'Applicación de Algoritmos de Agrupamiento a Funciones Emíricas de Densidad Acumlada'; presentado como disertación para optar al título de Maestría en Ciencias - Estadística."),

       hr(),
       
       sliderInput("n1",
                   "Tamaño de la primera nube",
                   min = 1,
                   max = 500,
                   value = 50),
     sliderInput("n2",
                 "Tamaño de la segunda nube",
                 min = 1,
                 max = 500,
                 value = 50),
     sliderInput("d",
                 "Diferencia",
                 min = 0,
                 max = 5,
                 value = 0, 
                 step = 0.1),
           p("El objetivo es establecer que para nubes de puntos de la misma distribución, el criterio propuesto es invariante al tamaño muestral, mientras las distancias no."),
     p("Para información adicional contactar al autor: ", a("Julián Cruz", href = "http://github.com/CruzJulian"))
   ),
   
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         hr(),
         fluidRow(
           column(tableOutput("dist_table"), width = 4),
           column(p("La tabla muestra los valores de la distancia EMD, usada en el algoritmo EP-MEANS; la distancia D2, integral cuadrática; y el criterio de cercanía propuesto; entre nubes de untos normales, cuyas medias difieren según la especificación."), width = 8)
         )
        # dataTableOutput("datos")
        )
   )
)




# Define server logic required to draw a histogram
server <- function(input, output) {
   
  reactive({
    Map(rnorm, c(input$n1, input$n2), c(-input$d/2, input$d/2)) %>% 
       Map(data.frame, Valores = ., Nubes = c("Nube 1", "Nube 2")) %>% do.call(rbind, .)
  }) -> nubes
  
   output$distPlot <- renderPlot({

     nubes() %>% ggplot + aes(x = Valores, colour = Nubes) + geom_step(stat = "ecdf") + theme_minimal()
     # nubes() %$% boxplot(Valores~Nubes)
     
        })
  
   output$dist_table <- renderTable({
     nubes() %$% split(Valores, Nubes) %>% lapply(to_nubepuntos) -> nube_puntos
     data.frame(
       
       EMD = D_EMD(nube_puntos[[1]], nube_puntos[[2]]),
       L2 = dist_nubes(nube_puntos[[1]], nube_puntos[[2]]),
       Propuesto = D_def(nube_puntos[[1]], nube_puntos[[2]])
       
     )
   })
   
  # output$datos <- renderDataTable(nubes())
  
}

# Run the application 
shinyApp(ui = ui, server = server)

