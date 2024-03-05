library(shiny)
require(gamlss)

source("auxiliar.R")

shinyServer(function(input, output, session){
  
  # Function to plot 
  mis_graficos <- function(resp, fact) {
    # actualizando los datos
    inFile <- input$file1
    if(is.null(inFile))
      dt <- datos
    else dt <- read.csv(inFile$datapath, 
                        header=input$header, 
                        sep=input$sep)
    
    # partiendo la ventana grafica
    par(mfrow=c(2, 1))
    # Boxplot
    boxplot(dt[, resp] ~ dt[, fact],
            ylab="Time (min)",
            xlab="Type of map",
            las=1)
    # # Grafico de residuales
    mod <- aov(dt[, resp] ~ dt[, fact])
    qqnorm(residuals(mod), pch=19, las=1)
    qqline(residuals(mod))
  }
  
  mi_tabla_anova <- function(resp, fact) {
    # actualizando los datos
    inFile <- input$file1
    if(is.null(inFile))
      dt <- datos
    else dt <- read.csv(inFile$datapath, 
                        header=input$header, 
                        sep=input$sep)
    
    resp <- as.character(resp)
    fact <- as.character(fact)
    mod <- aov(dt[, resp] ~ dt[, fact])
    cat("Anova table"); cat("\n")
    br()
    br()
    print(summary(mod))
  }
  
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- datos
    else dt <- read.csv(inFile$datapath, 
                        header=input$header, 
                        sep=input$sep)
    updateSelectInput(session, "response",
                      choices = names(dt))
    updateSelectInput(session, "factor",
                      choices = names(dt),
                      selected = names(dt))
  })
  
  output$data_table <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- datos
    else dt <- read.csv(inFile$datapath, 
                        header=input$header, 
                        sep=input$sep)
    dt
  })
  
  output$distPlot1 <- renderPlot({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- datos
    else dt <- read.csv(inFile$datapath, 
                        header=input$header, 
                        sep=input$sep)
    mis_graficos(input$response, input$factor)
  })
  
  output$anovaTable <- renderPrint({
    mi_tabla_anova(input$response, input$factor)
  })
  

})