library(shiny)
library(gamlss)
library(gamlss.dist)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("All gamlss distributions"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            # Para elegir la distribucion
            selectInput(inputId="distribution",
                        label="Select the gamlss distribution:",
                        choices=grep("^[A-Z ]+$", ls("package:gamlss.dist"), value = TRUE),
                        selected="EXP"),
            
            # Para elegir los valores de los parametros
            h5("To show the probability density function (pdf) or 
               probability mass function (pmf) you must select values 
               for the parameters."),
            
            conditionalPanel(condition="output.nopar==1",
                             numericInput(inputId="mu",
                                          label=HTML("Select &mu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25)),
            
            conditionalPanel(condition="output.nopar==2",
                             numericInput(inputId="mu",
                                          label=HTML("Select &mu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="sigma",
                                          label=HTML("Select &sigma;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25)),
            
            conditionalPanel(condition="output.nopar==3",
                             numericInput(inputId="mu",
                                          label=HTML("Select &mu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="sigma",
                                          label=HTML("Select &sigma;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="nu",
                                          label=HTML("Select &nu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25)),
            
            conditionalPanel(condition="output.nopar==4",
                             numericInput(inputId="mu",
                                          label=HTML("Select &mu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="sigma",
                                          label=HTML("Select &sigma;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="nu",
                                          label=HTML("Select &nu;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25),
                             
                             numericInput(inputId="tau",
                                          label=HTML("Select &tau;:"),
                                          min=-20,
                                          max=20,
                                          step=0.1,
                                          value=0.25)),
            
            # Para ingresar el maximo y minimo
            h5("To display the correct form of the pdf or pmf you must
               select appropiate minimum and maximum values for X."),
            
            numericInput(inputId = "minimo",
                         label = HTML("Select the minimum value for the random variable:"),
                         min = -30,
                         max =  30,
                         value = 0,
                         step= 0.01),
            numericInput(inputId = "maximo",
                         label = HTML("Select the maximum value for the random variable:"),
                         min = -30,
                         max =  30,
                         value = 5,
                         step= 0.01),
            
            img(src="gamlss.png", height = 60, width = 200),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot", width = "400px"),
            h5("Next you can find the Skweness and Kurtosis moments for the distribution."),
            verbatimTextOutput("sk")
        )
    )
))
