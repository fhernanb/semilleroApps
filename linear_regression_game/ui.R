library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Juguemos a adivinar"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h4("En este juego usted debe adivinar los valores 
               de los parametros para un problema de regresion 
               lineal simple."),
            textInput("nombre", 
                      label="Por favor ingrese su nombre"),
            h5('En este juego usted debe elegir los valores
               apropiados para el intercepto y la
               pendiente con el objetivo de MINIMIZAR 
               la suma de cuadrados del error.'),
            numericInput("b0",
                        "Introduce the intercept:",
                        min = -50,
                        max = 50,
                        step = 0.01,
                        value = 0),
            numericInput("b1",
                         "Introduce the slope:",
                         min = -50,
                         max = 50,
                         step = 0.01,
                         value = 1),
            #submitButton("Submit"),
            actionButton("update", "Someter los valores"),
            h5("La linea de color verde en el segundo
               diagrama de dispersion representa el minimo
               valor de la suma de cuadrados del error, ese
               es el valor objetivo que usted debe alcanzar."),
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
