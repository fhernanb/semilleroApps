#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    theme = shinytheme("paper"),

    # Application title
    titlePanel("Convergence in probability"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            p(HTML('This app shows how the order statistics 
            (X<sub>(n)</sub> or X<sub>(1)</sub>)
             converge in probability to the objective parameters 
             in two cases:')),
            
            p(HTML("&#9679;"), strong("Uniform distribution on the interval"),
              HTML("(0, &#947;).")),
            p(HTML("&#9679;"), strong("Shifted exponential distribution with parameter"),
              HTML("&#955 = 1"),
              strong("on the interval"),
              HTML("[&#947;, &#8734;).")),
            
            p(HTML('The user selects the distribution, the population
            parameter <b>&#947;</b>, and the sample size <b>n</b>. 
            The application computes the order statistics 
            (x<sub>(1)</sub> or x<sub>(n)</sub>) for each one of 
            the 10000 simulated samples from the selected distribution, and plots 
            their empirical cumulative distribution function (ECDF).')),

            p(HTML("Click on the blue small triangle to observe an 
               animation of the ECDF of the 
               order statistics (X<sub>(1)</sub> or X<sub>(n)</sub>).")),
            
            br(),
            
            numericInput(inputId = "n",
                        label = "Select sample size n=",
                        value = 2,
                        min = 2,
                        max = 200),
            htmlOutput("noten"),
            
            selectInput(inputId = "distri",
                        label = "Probability distribution:",
                        choices = c("Uniform", "Shifted Exponential"),
                        selected = "Uniform"),
            
            conditionalPanel(condition="input.distri == 'Uniform'",
                             numericInput(inputId = "gamma1",
                                          label = HTML("Select &#947;="), 
                                          value = 6, min = 1, max = 10),
                             htmlOutput("notegamma1"),
                             numericInput(inputId = "epsilon1",
                                          label = HTML("Select &#1013;="),
                                          value = 0.3, min = 0.05, max = 0.55),
                             htmlOutput("noteepsilon1")),
            conditionalPanel(condition="input.distri == 'Shifted Exponential'",
                             numericInput(inputId = "gamma2",
                                          label = HTML("Select &#947;="), 
                                          value = 6, min = 1, max = 10),
                             htmlOutput("notegamma2"),
                             numericInput(inputId = "epsilon2",
                                          label = HTML("Select &#1013;="),
                                          value = 0.3, min = 0.05, max = 0.55),
                             htmlOutput("noteepsilon2")
                             ),
            
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
                                 plotOutput("distPlot", 
                                            click = "plot_click",
                                            height = "500px",
                                            width = "390px"),
                                 htmlOutput("info_00")),
                        tabPanel("Proofs", 
                                 includeHTML("Proof.html"))
                        )
        )
    )
))
