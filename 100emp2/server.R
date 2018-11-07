
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  observe({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)
    
    updateCheckboxGroupInput(session, "covariables",
                             label = 'Por defecto la app tiene 3 variables seleccionadas,
                         usted puede marcar las casillas para agregar o quitar
                         variables y así iniciar el proceso de selección',
                             choices = colnames(dt[, -(1:5)]),
                             selected = c('activos', 'pasivos', 'patrimonio')
                             )
  })
  
  output$inputData <- renderTable({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)
    
    dt
  })
  

  output$plot1 <- renderPlot({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)

    plot(density(dt$ing), main='Densidad para ingresos',
         xlab='Ingresos', ylab='Densidad', lwd=2, las=1, col='dodgerblue3')
    rug(dt$ing, col='dodgerblue3')
  })
  
  output$plot2 <- renderPlot({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)

    panel.cor <- function(x, y, ...) {
      par(usr = c(0, 1, 0, 1))
      txt <- as.character(format(cor(x, y), digits=2))
      text(0.5, 0.5, txt, cex = 6 * abs(cor(x, y)), col='dodgerblue3')
    }
    
    variables <- c('ing', input$covariables)
    pairs(dt[, variables], upper.panel=panel.cor, col='dodgerblue3', las=1,
          main='Diagrama de dispersión entre Ingresos y las variables seleccionadas')
  })
  

  output$regresion <- renderPrint({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)

    min.scope <- 'ing ~ 1'
    max.scope <- paste('ing ~', paste(input$covariables, collapse=' + '))
    require(MASS)
    m1 <- lm(max.scope, data=dt)
    m2 <- stepAIC(object=m1, direction='backward', trace=0, 
                  steps=5000, k=log(nrow(dt)))
    summary(m2)
  })
  

  output$ecuacion1 <- renderUI({
    dt <- readxl::read_excel("BDempresas.xlsx")
    dt <- subset(dt, ing < 55000000)
    
    min.scope <- 'ing ~ 1'
    max.scope <- paste('ing ~', paste(input$covariables, collapse=' + '))
    require(MASS)
    m1 <- lm(max.scope, data=dt)
    m2 <- stepAIC(object=m1, direction='backward', trace=0, 
                  steps=5000, k=log(nrow(dt)))
    a <- round(coef(m2), digits=2)
    a[a > 0] <- paste0(" +", a[a > 0])
    b <- names(m2$coefficients)[-1]
    tit <- paste(c('$$Ing =', a[1], paste(a[-1], b), '$$'), collapse=' ')

    withMathJax(helpText(tit))
  })

  
})
