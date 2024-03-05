library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$densi_Beta <- renderPlot({

        curve(dbeta(x, shape1=input$shape1, shape2=input$shape2),
              lwd=3, col="tomato",
              ylab="Densidad", 
              main="Densidad de una Beta")

    })

}
