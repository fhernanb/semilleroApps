library(shiny)
library(ggplot2)

source("www/auxiliar_functions.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
      
      if (input$Distribucion == "Normal") {
        p <- ggplot() + 
          geom_function(colour="indianred1", fun=dnorm, lwd=2,
                        args=list(mean=input$mu_normal, sd=input$sigma)) + 
          xlim(input$min_normal, input$max_normal) +
          theme(legend.position = "none") + 
          labs(x="X", y="Density", 
               title=bquote(paste("X ~ N(",
                                  mu, "=", .(input$mu_normal),
                                  ", ",
                                  sigma^2, "=", .(input$sigma), ")")))
        print(p)
      }
      
      if (input$Distribucion == "Gamma") {
        p <- ggplot() + 
          geom_function(color="dodgerblue2", fun=dgamma_glm, lwd=2,
                        args=list(mu=input$mu_gamma, phi=input$phi_gamma)) + 
          xlim(input$min_gamma, input$max_gamma) +
          theme(legend.position = "none") + 
          labs(x="X", y="Density", 
               title=bquote(paste("X ~ Gamma(",
                                  mu, "=", .(input$mu_gamma),
                                  ", ",
                                  phi, "=", .(input$phi_gamma), ")")))
        print(p)
      }
      
      if (input$Distribucion == "Inv. gaussian") {
        p <- ggplot() + 
          geom_function(color="darkslategray3", fun=dinvgaus_glm, lwd=2,
                        args=list(mu=input$mu_invgaus, phi=input$phi_invgaus)) + 
          xlim(input$min_invgaus, input$max_invgaus) +
          theme(legend.position = "none") + 
          labs(x="X", y="Density", 
               title=bquote(paste("X ~ InvGaussian(",
                                  mu, "=", .(input$mu_invgaus),
                                  ", ",
                                  phi, "=", .(input$phi_invgaus), ")")))
        print(p)
      }
      
      if (input$Distribucion == "Binomial") {
        xs <- seq(from=0, to=input$m)
        ys <- dbinom(x=xs, size=input$m, prob=input$mu_binom)
        plot(x=xs, y=ys, type='p', xlab='X', ylab='Probability', 
             col='mediumpurple1', lwd=2, las=1)
        segments(xs, 0, xs, ys, col="mediumpurple1", lwd=3)
      }
      
      if (input$Distribucion == "Poisson") {
        xs <- seq(from=0, to=input$max_pois)
        ys <- dpois(x=xs, lambda=input$mu_pois)
        plot(x=xs, y=ys, type='p', xlab='X', ylab='Probability', 
             col='lightsalmon2', lwd=2, las=1)
        segments(xs, 0, xs, ys, col="lightsalmon2", lwd=3)
      }
      
      if (input$Distribucion == "Negative binomial") {
        xs <- seq(from=0, to=input$max_negbin)
        ys <- dnbinom(x=xs, mu=input$mu_negbin, size=input$k)
        plot(x=xs, y=ys, type='p', xlab='X', ylab='Probability', 
             col='olivedrab3', lwd=2, las=1)
        segments(xs, 0, xs, ys, col="olivedrab3", lwd=3)
      }

      
    }, res = 96)

})


  