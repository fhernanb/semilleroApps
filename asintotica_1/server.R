#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output, session) {
    input_received <- reactive ({
      if(input$n > 200){
        max
      }else if (input$n < 2){
        min
      }else{
        ifelse(is.integer(input$n) == FALSE, round(input$n), input$n)
      }
    })
    textnoten <- reactive({
      if(input$n >= 2 & input$n <= 200){
        ifelse(is.integer(input$n) == FALSE, paste("<font color=\"#FF0000\">",
                                                   "&#x26A0; n must be an integer.", "</font>"), 
               paste(""))
      }else{
        paste0("<font color=\"#FF0000\">", "&#x26A0; n must be an integer between 2 and 200 inclusive.",
               "</font>")
      }
    })
    output$noten <- renderText({
      HTML(textnoten())
    })
    
    input_received1 <- reactive({
        if(input$gamma1 > 10){
            max
        }else if(input$gamma1 < 1){
            min
        }else{
            input$gamma1
        }
    })
    textnotegamma1 <- reactive({
        if(input$gamma1 >= 1 & input$gamma1 <= 10){
            paste("")
        }else{
            paste0("<font color=\"#FF0000\">", "&#x26A0; &#947; must lie on the interval
                   [1,10].", "</font>")
        }
    })
    output$notegamma1 <- renderText({
        HTML(textnotegamma1())
    })   
    
    input_received2 <- reactive({
        if(input$epsilon1 > 0.55){
            max
        }else if(input$epsilon1 < 0.05){
            min
        }else{
            input$epsilon1
        }
    })
    textnoteepsilon1 <- reactive({
        if(input$epsilon1 >= 0.05 & input$epsilon1 <= 0.55){
            paste("")
        }else{
            paste0("<font color=\"#FF0000\">", "&#x26A0; &#1013; must lie on the interval
                   [0.05,0.55].", "</font>")
        }
    })
    output$noteepsilon1 <- renderText({
        HTML(textnoteepsilon1())
    })   
    
    input_received3 <- reactive({
        if(input$gamma2 > 10){
            max
        }else if(input$gamma2 < 1){
            min
        }else{
            input$gamma2
        }
    })
    textnotegamma2 <- reactive({
        if(input$gamma2 >= 1 & input$gamma2 <= 10){
            paste("")
        }else{
            paste0("<font color=\"#FF0000\">", "&#x26A0; &#947; must lie on the interval
                   [1,10].", "</font>")
        }
    })
    output$notegamma2 <- renderText({
        HTML(textnotegamma2())
    })   
    
    input_received4 <- reactive({
        if(input$epsilon2 > 0.55){
            max
        }else if(input$epsilon2 < 0.05){
            min
        }else{
            input$epsilon2
        }
    })
    textnoteepsilon2 <- reactive({
        if(input$epsilon2 >= 0.05 & input$epsilon2 <= 0.55){
            paste("")
        }else{
            paste0("<font color=\"#FF0000\">", "&#x26A0; &#1013; must lie on the interval
                   [0.05,0.55].", "</font>")
        }
    })
    output$noteepsilon2 <- renderText({
        HTML(textnoteepsilon2())
    })   

    # output$demostracion <- renderUI({
    #     if (input$distri == "Uniform") 
    #         includeHTML("demo_Uniform.html")
    #     else 
    #         includeHTML("demo_Exponential.html")
    # })
    
    output$demostracion <- renderUI({
            includeHTML("Proof.html")
    })

    output$distPlot <- renderPlot({

        if (input$distri == "Uniform") 
            source("core_unif.R", local = TRUE)
        else 
            source("core_exp.R", local = TRUE)
    })
    

    output$info_00 <- renderText({
        x_value <- ifelse(is.null(input$plot_click$x), "NA", round(input$plot_click$x, digits=2))
        y_value <- ifelse(is.null(input$plot_click$y), "NA", round(input$plot_click$y, digits=2))
        paste0(ifelse(input$distri == "Uniform",
               "Click on the graph to obtain the coordinate (&#947;-&#1013;, F<sub>X<sub>(n)</sub></sub>(&#947;-&#1013))",
               "Click on the graph to obtain the coordinate (&#947;+&#1013;, F<sub>X<sub>(1)</sub></sub>(&#947;+&#1013))"),
              " = (", x_value, ", ", y_value, ")")
        
    })
    
    output$info_01 <- renderText({
        x_value <- ifelse(is.null(input$plot_click$x), "NA", round(input$plot_click$x, digits=2))
        y_value <- ifelse(is.null(input$plot_click$y), "NA", round(input$plot_click$y, digits=2))
        paste0("(", x_value, ", ", y_value, ")")
    })
    
    output$download <- downloadHandler(
        filename = "Workshop Conv-Prob-Dist.pdf",
        content = function(file) {
            file.copy("Workshop Conv-Prob-Dist.pdf", file)
        }
    )

})
