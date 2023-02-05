library(shiny)
library(gamlss)
library(gamlss.dist)
library(dplyr)

source("aux_functions.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$nopar <- reactive({
    the_dist <- identifica(input$distribution)
    the_dist$nopar
    })
  
  outputOptions(output, 'nopar', suspendWhenHidden = FALSE)
  
  # Primer output
  output$distPlot <- renderPlot({
    the_dist <- identifica(dist=input$distribution, input=input$mu)
    if (the_dist$type == "Discrete")
      plot_discrete(input)
    else
      plot_continuous(input)
    }, res = 96)
  
  output$value <- renderPrint({ input$distribution })
  
  output$summary <- renderPrint({
    input
  })
  
  # Segundo output
  output$sk <- renderPrint({ 
    the_dist <- identifica(input$distribution)
    theoMomentSK(fam=input$distribution, mu=3)
    texto <- eval(paste0("theoMomentSK(fam=", input$distribution,
                         the_dist$which_param,
                         limites(input$distribution),
                         ")"))
    print(texto)
    eval(parse(text=texto))
  })

})
