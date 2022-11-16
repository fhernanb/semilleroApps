
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
            The user selects the sample size <b>n</b>; the distribution; its respective
            parameter <b>&#952;</b>, <b>&#952;<sub>0</sub></b>; and <b>&#948;</b>. The 
            application simulates 10000 samples from the selected distribution, and computes 
            the number of times the maximum likelihood estimate of <b>&#952;</b>, 
            <span style="position: relative; margin-left:-9px; left: 9.5px; bottom: 7px">^</span> 
            <b>&#952;<sub>n</sub></b>, is within (green area) and outside (red area) the 
            interval <b>(&#952;<sub>0</sub> &#177; &#948;)</b>, as well as their proportion.')),
            
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
                                         label = HTML("Select success probability &#960;, &#960;<sub>0</sub>="),
                                         value = 0.2,
                                         min = 0.2,
                                         max = 0.5)),
            conditionalPanel(condition="input.distri == 'Poisson'",
                             sliderInput(inputId = "l",
                                         label = HTML("Select mean &#955;, &#955;<sub>0</sub>="),
                                         value = 5,
                                         min = 3,
                                         max = 8)),
            conditionalPanel(condition="input.distri == 'Exponential'",
                             sliderInput(inputId = "t",
                                         label = HTML("Select rate &#981;, &#981;<sub>0</sub>="),
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
                                 plotOutput("MLE", width="800px", height="700px")),
                        tabPanel("Proof", includeHTML("Proof.html")))
            
        )
    )
))
