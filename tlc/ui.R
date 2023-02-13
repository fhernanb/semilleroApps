library(shiny)
library(knitr)
library(markdown)

#  interfaz del usuario para montaje de comandos y ventanas, bases si se requiere
fluidPage(
  
  # Titulo de la aplicacion
  titlePanel("Central Limit Theorem (CLT)"),
  

  ### ubicacion de botones y ventanas en la aplicacion
  sidebarLayout(
     sidebarPanel(
       h4('This app illustrates the Central Limit Theorem.'),
       br(),
       h6('The app simulates 1000 samples from any of five available distribution
           and the user selects the sample size (n) to verify that
           distribution of sample mean converges to a Normal distribution.'),
       br(),
  ### relaciona las distribuciones a usar y por defecto selecciona la distribucion normal.    
       selectInput(inputId = "distri",
                   label = "Select the source distribution:",
                   choices = c("Normal",
                               "Uniform",
                               "Gamma",
                               "Beta",
                               "Mix of two normal"),
                   selected = "Gamma"),
  
      br(),

  # Distribucion normal
  conditionalPanel(condition="input.distri == 'Normal'",
                   numericInput(inputId="media",
                                label=HTML("Enter the mean &mu;."),
                                value="10",
                                step=0.1),
                   
                   numericInput(inputId="desvi",
                                label=HTML("Enter the standard deviation &sigma;."),
                                min=0.1,
                                value="3",
                                step=0.1) ),
  
  # Distribucion Uniforme
  conditionalPanel(condition="input.distri == 'Uniform'",
                   numericInput(inputId="min",
                                label=HTML("Enter the minimum value."),
                                value="0",
                                step=0.1),
                   
                   numericInput(inputId="max",
                                label=HTML("Enter the maximum value."),
                                min=0,
                                value="1",
                                step=0.1) ),
  
  # Distribucion Gamma
    conditionalPanel(condition="input.distri == 'Gamma'",
                   numericInput(inputId="shape",
                                label=HTML("Enter the shape parameter."),
                                min=0.01,
                                value="1",
                                step=0.1),
                   
                   numericInput(inputId="scale",
                                label=HTML("Enter the scale parameter."),
                                min=0.01,
                                value="1",
                                step=0.1) ),
  
  # Distribucion beta
    conditionalPanel(condition="input.distri == 'Beta'",
                   numericInput(inputId="shape1",
                                label=HTML("Enter the parameter a."),
                                min=0.01,
                                value="1.5",
                                step=0.1),
                   
                   numericInput(inputId="shape2",
                                label=HTML("Enter the parameter b."),
                                min=0.01,
                                value="0.9",
                                step=0.1) ),
  
  # Distribucion mezcla dos normales
  conditionalPanel(condition="input.distri == 'Mix of two normal'",
                   numericInput(inputId="mu1",
                                label=HTML("Enter the mean for population 1."),
                                min=-15,
                                max= 15,
                                value="-4",
                                step=0.1),
                   
                   numericInput(inputId="mu2",
                                label=HTML("Enter the mean for population 2."),
                                min=-15,
                                max= 15,
                                value="6",
                                step=0.1),
                   
                   numericInput(inputId="sd1",
                                label=HTML("Enter the standard deviation 1."),
                                min=0.01,
                                max= 15,
                                value="1",
                                step=0.1),
                   
                   numericInput(inputId="sd2",
                                label=HTML("Enter the standard deviation 2."),
                                min=0.01,
                                max= 15,
                                value="3",
                                step=0.1),
                   
                   numericInput(inputId="prob1",
                                label=HTML("Enter the percentage of population 1"),
                                min=0.01,
                                max=0.99,
                                value="0.3",
                                step=0.01) ),

  
  sliderInput(inputId="n", 
                  "Select the sample size n:", 
                  value=1,
                  min=1, 
                  max=1000, step=NULL, animate=T),
  

  p("App created by Semillero de R at Universidad Nacional de Colombia:"),
  img(src="https://github.com/fhernanb/fhernanb.github.io/blob/master/my_docs/logo_unal_negro.png?raw=true",
      height = 56, width = 140),
  tags$a(href="https://srunal.github.io", "https://srunal.github.io")
  ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("CLT",
                           plotOutput("TLC", width="550px", height="550px")),
                  tabPanel("Theory", includeHTML("include.html"))
                  
      )
    )
  )
)

