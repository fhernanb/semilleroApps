library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  observe({
    dt <- subset(dt, Sector == input$sector)
    
    updateCheckboxGroupInput(session, "covariables",
                             label = 'Por defecto la app tiene 3 variables 
                        seleccionadas,
                         usted puede marcar las casillas para agregar o quitar
                         variables y así iniciar el proceso de selección.',
                             choices = colnames(dt[, -(1:5)]),
                             selected = c('activos', 'pasivos', 'patrimonio'))
  })
  
  output$inputData <- renderTable({
    dt <- subset(dt, Sector == input$sector)
    dt
  })
  

  output$plot1 <- renderPlot({
    dt <- subset(dt, Sector == input$sector)
    
    plot(density(dt$ing), main='Densidad para ingresos',
         xlab='Ingresos', ylab='Densidad', lwd=3, las=1, col='dodgerblue3')
    rug(dt$ing, col='dodgerblue3')
  })
  
  output$plot2 <- renderPlot({
    dt <- subset(dt, Sector == input$sector)
    
    panel.cor <- function(x, y, ...) {
      par(usr = c(0, 1, 0, 1))
      txt <- as.character(format(cor(x, y), digits=2))
      text(0.5, 0.5, txt, cex = 6 * abs(cor(x, y)), col='dodgerblue3')
    }
    
    variables <- c('ing', input$covariables)
    pairs(dt[, variables], upper.panel=panel.cor, col='dodgerblue3', las=1,
          main='Diagrama de dispersión y correlación lineal entre 
          Ingresos y las variables seleccionadas', pch=19)
  })
  

  output$regresion <- renderPrint({
    dt <- subset(dt, Sector == input$sector)

    min.scope <- 'ing ~ 1'
    max.scope <- paste('ing ~', paste(input$covariables, collapse=' + '))
    require(MASS)
    m1 <- lm(max.scope, data=dt)
    m2 <- stepAIC(object=m1, direction='backward', trace=0, 
                  steps=5000, k=log(nrow(dt)))
    m2 <- model.select(model=m2, sig=0.05)
    summary(m2)
  })
  
  
  output$tree<- renderPlot({
    
    form <- paste('ing ~', paste(input$covariables, collapse=' + '))
    form <- as.formula(form)
    
    require(disttree)
    tr <- disttree(form, data = dt, family = input$dist)
    plot(tr, main=paste0("Árbol de regresión con distribución ", input$dist))
    
    
  })
  

  output$ecuacion1 <- renderUI({
    dt <- subset(dt, Sector == input$sector)
    
    min.scope <- 'ing ~ 1'
    max.scope <- paste('ing ~', paste(input$covariables, collapse=' + '))
    require(MASS)
    m1 <- lm(max.scope, data=dt)
    m2 <- stepAIC(object=m1, direction='backward', trace=0, 
                  steps=5000, k=log(nrow(dt)))
    m2 <- model.select(model=m2, sig=0.05)
    a <- round(coef(m2), digits=2)
    a[a > 0] <- paste0(" +", a[a > 0])
    b <- names(m2$coefficients)[-1]
    tit <- paste(c('$$\\widehat{Ing} =', a[1], paste(a[-1], b), '$$'), collapse=' ')

    withMathJax(helpText(tit))
  })

  
})
