library(shiny)

fluidPage(
    titlePanel("Distribución Beta"),

    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "shape1",
                        label = "Parametro shape 1:",
                        min = 0,
                        max = 10,
                        value = 2),
            
            sliderInput(inputId = "shape2",
                        label = "Parametro shape 2:",
                        min = 0,
                        max = 10,
                        value = 5)
        ),

        mainPanel(
            plotOutput("densi_Beta")
        )
    )
)
