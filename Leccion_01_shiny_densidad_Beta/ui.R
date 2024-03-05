library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Distribución Beta"),

    # Sidebar with a slider input for number of bins
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

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("densi_Beta")
        )
    )
)
