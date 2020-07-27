#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("IMC"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput(inputId="peso",
                         label="Ingrese su peso en kilogramos",
                         value=65, step=1),
            numericInput(inputId="estatura",
                         label="Ingrese su estatura en metros",
                         value=1.70,
                         step=0.01)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            verbatimTextOutput('resultado')
        )
    )
))
