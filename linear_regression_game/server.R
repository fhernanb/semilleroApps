n <- 20
b0 <- isolate(sample(-5:5, size=1))
b1 <- isolate(sample(-5:5, size=1))
x <- isolate(runif(n, min=-5, max=10))
y <- isolate(rnorm(n, mean=b0+b1*x, sd=5))
mod <- lm(y ~ x)
best_b0 <- round(coef(mod)[1], 2)
best_b1 <- round(coef(mod)[2], 2)
ssr <- sum((y-(best_b0+best_b1*x))^2)
ssr <- round(ssr, digits=2)
aux <- sum((y-(0+1*x))^2)

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    #Example
    values <- reactiveValues(df_data = NULL)
    values <- reactiveValues(df = data.frame(beta_0=0, 
                                             beta_1=1,
                                             sce=aux))
    
    newEntry <- observeEvent(input$update,{
        b0_new  <- c(values$df$beta_0, as.numeric(input$b0))
        b1_new  <- c(values$df$beta_1, as.numeric(input$b1))
        rta <- sum((y - (input$b0 + input$b1 * x))^2)
        rta <- round(rta, digits=2)
        sce_new <- c(values$df$sce, as.numeric(rta))
        
        values$df <- data.frame(beta_0=b0_new, 
                                beta_1=b1_new,
                                sce=sce_new)
    })
    
    output$example <- renderTable({values$df})

    output$my_plot <- renderPlot({
        par(mfrow=c(1, 2)) 
        # Figura 1
        plot(x=x, y=y, 
             #main=c(best_b0, best_b1),
             main="Diagrama de dispersion y modelo ajustado",
             pch=20, las=1)
        abline(h=0, v=0, lty="dashed", col=gray(0.8))
        aux <- function(inter, slope) inter + slope * x
        y_hat <- aux(input$b0, input$b1)
        abline(a=input$b0, b=input$b1, lwd=3, col="deepskyblue3")
        segments(x0=x, y0=y, x1 =x, y1=y_hat, col="tomato")

        # If correct
        if (min(values$df$sce) == ssr) 
            legend("center","center",
                   paste0(input$nombre, "\n felicitaciones, \n lo hiciste bien!!! "), 
                   text.col="darkorchid3", cex=2, bty="n", bg="#ffffff00")
        
        # Figura 2
        with(values$df, plot(sce, las=1, type='b',
                             ylab="Suma de Cuadrado del Error",
                             xlab="Intento",
                             ylim=c(0, max(sce)),
                             main="Evolucion de SCE"))
        text(x=1, y=ssr, 
             paste0("Obj=", ssr), 
             col="green4", pos=4)
        abline(h=ssr, col="green4", lty="dashed")
        
        # If correct
        if (min(values$df$sce) == ssr) 
            legend("center","center",
                   paste0(input$nombre, "\n felicitaciones, \n lo hiciste bien!!! "), 
                   text.col="darkorchid3", cex=2, bty="n", bg="#ffffff00")
    })

})
