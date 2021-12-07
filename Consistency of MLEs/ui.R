
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
            br(),
            p('Click on the blue small triangle to observe an animation
            of the three displayed graphs.'),
            br(),
            sliderInput(inputId = "n",
                        label = "Sample size n=",
                        value = 10,
                        min = 1,
                        max = 5000, step = 1, animate = TRUE),
            br(),
            selectInput(inputId = "distri",
                        label = "Probability distribution:",
                        choices = c("Geometric",
                                    "Poisson",
                                    "Exponential"),
                        selected = "Poisson"),
            br(),
            conditionalPanel(condition="input.distri == 'Geometric'",
                             sliderInput(inputId = "p",
                                         label = HTML("Population success probability &#960;="),
                                         value = 0.2,
                                         min = 0.2,
                                         max = 0.5)),
            conditionalPanel(condition="input.distri == 'Poisson'",
                             sliderInput(inputId = "l",
                                         label = HTML("Population mean &#955;="),
                                         value = 5,
                                         min = 3,
                                         max = 8)),
            conditionalPanel(condition="input.distri == 'Exponential'",
                             sliderInput(inputId = "t",
                                         label = HTML("Population rate &#981;="),
                                         value = 1,
                                         min = 1,
                                         max = 5)),
            sliderInput(inputId = "delta",
                        label = HTML("&#948;="),
                        value = 0.08,
                        min = 0.07,
                        max = 0.09),
            tags$a("Click here to get the classroom activity
                    to interact with the app.", 
                   href="Classroom_activity_MLE.pdf"),
            br(),
            p("This app was developed by Mateo Ochoa Medina and
            Freddy Hernandez Barajas from
            Universidad Nacional de Colombia:"),
            br(),
            img(src="https://fhernanb.github.io/docs/logo_unal_negro.png",
                height = 56, width = 140)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "pills",
                        tabPanel("Illustration",
                                 plotOutput("MLE", width="800px", height="700px")),
                        tabPanel("Proof", includeHTML("Proof.html")))
            
        )
    )
))
