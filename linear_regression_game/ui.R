library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Juguemos a adivinar"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h5("En este juego usted debe adivinar el intercepto
                y la pendiente de la linea recta azul que mejor
               explica la nube de puntos. El objetivo es MINIMIZAR 
               la suma de cuadrados de los errores (SCE)."),
            h5("En el diagrama de la izquierda estan los puntos
               y la linea recta."),
            h5("En el diagrama de la derecha se muestra la evolucion
                del SCE para cada intento. La linea de color verde
                representa el minimo
               valor de SCE, ese
               es el valor objetivo que usted debe alcanzar."),
            br(),
            textInput("nombre", 
                      label="Por favor ingrese su nombre"),
            numericInput("b0",
                        "Ingrese el valor del intercepto:",
                        min = -50,
                        max = 50,
                        step = 0.01,
                        value = 0),
            numericInput("b1",
                         "Ingrese el valor de la pendiente:",
                         min = -50,
                         max = 50,
                         step = 0.01,
                         value = 1),
            #submitButton("Submit"),
            actionButton("update", "Someter los valores"),
            br(),
            img(src="logo.png", height=200, width=200)
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("my_plot"),
            h4("Tabla con las respuestas sometidas:"),
            tableOutput("example")
        )
    )
))
