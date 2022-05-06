
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
    theme = shinytheme("paper"),
    
    # Application title
    titlePanel("Consistency of MLEs"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            p(HTML('This application shows the consistency of 
            maximum likelihood estimators (MLEs) for several probability distributions. 
            The user selects the distribution, the population
            parameter <b>&#952;</b>, the sample size <b>n</b> and a <b>&#948;</b>
            value. The application simulates 10000 samples from the selected 
            distribution, and computes the number of times the MLE is within (green area)
            and outside (red area) the interval <b>(&#952; &#177; &#948;)</b>.')),
        
            p('Click on the blue small triangle to observe an animation
            of the three displayed graphs.'),
            
            br(),
            
            numericInput(inputId = "n",
                         label = "Select sample size n=",
                         value = 10,
                         min = 1,
                         max = 2000),
            htmlOutput("noten"),
            
            selectInput(inputId = "distri",
                        label = "Probability distribution:",
                        choices = c("Geometric",
                                    "Poisson",
                                    "Exponential"),
                        selected = "Poisson"),
            
            conditionalPanel(condition="input.distri == 'Geometric'",
                             sliderInput(inputId = "p",
                                         label = HTML("Select population success probability &#960;="),
                                         value = 0.2,
                                         min = 0.2,
                                         max = 0.5)),
            conditionalPanel(condition="input.distri == 'Poisson'",
                             sliderInput(inputId = "l",
                                         label = HTML("Select population mean &#955;="),
                                         value = 5,
                                         min = 3,
                                         max = 8)),
            conditionalPanel(condition="input.distri == 'Exponential'",
                             sliderInput(inputId = "t",
                                         label = HTML("Select population rate &#981;="),
                                         value = 1,
                                         min = 1,
                                         max = 5)),
            
            sliderInput(inputId = "delta",
                        label = HTML("Select &#948;="),
                        value = 0.08,
                        min = 0.07,
                        max = 0.09),
            
            downloadLink("download", 
                         "Click here to get a workshop to interact with the app."),
            
            br(),
            
            p("This app was developed by Mateo Ochoa Medina and
            Freddy Hernández Barajas from
            Universidad Nacional de Colombia:"),
            
            img(src = "Logo_unal_negro.png",
                height = 60, width = 140)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "pills",
                        tabPanel("Illustration",
                                 plotOutput("MLE", 
                                            width="600px", 
                                            height="800px")),
                        tabPanel("Proof", includeHTML("Proof.html")))
            
        )
    )
))
