library(shiny)

function(input, output, session) {

    output$densi_Beta <- renderPlot({

        curve(dbeta(x, shape1=input$shape1, shape2=input$shape2),
              lwd=5, col="tomato",
              ylab="Densidad", 
              main="Densidad de una Beta")

    })

}
