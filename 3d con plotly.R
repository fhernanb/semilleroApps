# https://towardsdatascience.com/make-beautiful-3d-plots-in-r-an-enhancement-on-the-story-telling-613ddd11e98

input <- NULL
input$m1 <- 1
input$m2 <- 3
input$sd1 <- 0.7
input$sd2 <- 0.8
input$rho <- -0.5

mu <- c(input$m1, input$m2)
Sigma <- matrix(c(input$sd1^2, input$rho * input$sd1 * input$sd2,
                  input$rho * input$sd1 * input$sd2, input$sd2^2), ncol = 2)


N <- 30
x1 <- seq(from=input$m1-4*input$sd1, 
          to  =input$m1+4*input$sd1, 
          length.out=N)
x2 <- seq(from=input$m2-4*input$sd2, 
          to  =input$m2+4*input$sd2, 
          length.out=N)

densidad_curva <- function(x1, x2) dmvnorm(cbind(x1, x2), 
                                           mean=mu, 
                                           sigma=Sigma)  

probX <- outer(x1, x2, FUN="densidad_curva")

# 3D plot of joint probability distribution without projection
library(plotly)
fig <- plot_ly(x=x1, y=x2, z=probX) %>% add_surface()
fig





