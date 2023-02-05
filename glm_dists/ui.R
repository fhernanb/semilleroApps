library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("glm distributions"),
    
    h4("Select the glm distribution and then fixed
       the parameters to obtain the probability distribution."),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          
          selectInput("Distribucion",
                      "What distribution?",
                      choices=c("Normal", "Gamma", "Inv. gaussian", 
                                "Binomial",
                                "Poisson", "Negative binomial"),
                      selected="Normal"),
          
          conditionalPanel(condition="input.Distribucion=='Normal'",
                           numericInput(inputId="mu_normal",
                                        label=HTML("Select &mu;:"),
                                        value="0.5",
                                        step=0.01),
                           
                           numericInput(inputId="sigma",
                                        label=HTML("Select &sigma;:"),
                                        min=0.01,
                                        value="1.2",
                                        step=0.01),
                           
                           numericInput(inputId="min_normal",
                                        label="Select the minimun value for xlim",
                                        value="-1", step=1),
                           numericInput(inputId="max_normal",
                                        label="Select the maximum value for xlim",
                                        value="3", step=1)
                           
                           ),
          
          conditionalPanel(condition="input.Distribucion=='Gamma'",
                           numericInput(inputId="mu_gamma",
                                        label=HTML("Select &mu;:"),
                                        min=0.01,
                                        value=1.5,
                                        step=0.01),
                           
                           numericInput(inputId="phi_gamma",
                                        label=HTML("Select &phi;:"),
                                        min=0.01,
                                        value=0.3,
                                        step=0.01),
                           
                           numericInput(inputId="min_gamma",
                                        label="Select the minimun value for xlim",
                                        value="0.01", step=1),
                           numericInput(inputId="max_gamma",
                                        label="Select the maximum value for xlim",
                                        value="3", step=1)
                           
                           ),
          
          conditionalPanel(condition="input.Distribucion=='Inv. gaussian'",
                           numericInput(inputId="mu_invgaus",
                                        label=HTML("Select &mu;:"),
                                        min=0.01,
                                        value="1.5",
                                        step=0.01),
                           
                           numericInput(inputId="phi_invgaus",
                                        #label=HTML("Select &phi;:"),
                                        label="Select φ",
                                        min=0.1,
                                        value="1.2",
                                        step=0.1),
                           
                           numericInput(inputId="min_invgaus",
                                        label="Select the minimun value for xlim",
                                        value="0.01", step=1),
                           numericInput(inputId="max_invgaus",
                                        label="Select the maximum value for xlim",
                                        value="3", step=1)
                           
                           ),
          
          conditionalPanel(condition="input.Distribucion=='Binomial'",
                           numericInput(inputId="mu_binom",
                                        label=HTML("Select &mu;:"),
                                        min=0.01,
                                        max=0.99,
                                        value=0.3,
                                        step=0.01),
                           
                           numericInput(inputId="m",
                                        label=HTML("Select m the number of experiments"),
                                        min=1,
                                        value=7,
                                        step=1)
                           ),
          
          conditionalPanel(condition="input.Distribucion=='Poisson'",
                           numericInput(inputId="mu_pois",
                                        label=HTML("Select &mu;:"),
                                        min=0.01,
                                        value="2.7",
                                        step=0.01),
                           
                           numericInput(inputId="max_pois",
                                        label="Select the maximum value for xlim",
                                        value="15", step=1)
                           
                           ),
          
          conditionalPanel(condition="input.Distribucion=='Negative binomial'",
                           numericInput(inputId="mu_negbin",
                                        label=HTML("Select &mu;:"),
                                        min=0.01,
                                        value="2.7",
                                        step=0.01),
                           
                           numericInput(inputId="k",
                                        label=HTML("Select k"),
                                        min=0.01,
                                        value="1.6",
                                        step=0.01),
                           
                           numericInput(inputId="max_negbin",
                                        label="Select the maximum value for xlim",
                                        value="15", step=1)
                           
                           
                           ),
          
          img(src="logo.png", height = 60, width = 140),
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot", width = "400px")
        )
    )
))
