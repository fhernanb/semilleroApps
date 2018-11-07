library(shiny)

shinyServer(function(input, output, session) {
   
  output$distPlot <- renderPlot({
    
    dt <- readxl::read_excel("BDempresas.xlsx")
    
    with(dt, plot(x=activos, y=ing, pch=19))

  })
  
})
