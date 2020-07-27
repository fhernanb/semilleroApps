#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$resultado <- renderText({
        imc <- input$peso / input$estatura^2
        imc <- round(imc, digits=2)
        paste(c("Su indice de masa corporal es", imc))
    })

})
