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
            (<b>X<sub>(1)</sub></b> or <b>X<sub>(n)</sub></b>)
             converge in probability to the objective parameters 
             in two cases:')),
            
            p(strong("- Uniform distribution on the interval"),
              HTML("(0, &#947;)")),
            p(strong("- Shifted exponential distribution with parameter"),
              HTML("&#955 = 1"),
              strong("on the interval"),
              HTML("[&#947;, &#8734;)")),
            
            br(),
            
            p(HTML('The user selects the distribution, the population
            parameter <b>&#947;</b> and the sample size <b>n</b>. 
            The application computes the order statistics 
            (<b>X<sub>(1)</sub></b> or <b>X<sub>(n)</sub></b>) for each one of 
            the 10000 simulated samples from the selected distribution and plot 
            their empirical cumulative distribution function.')),

            p(HTML("Click on the blue small triangle to observe an 
               animation of the cumulative distribution function of the 
               order statistics (<b>X<sub>(1)</sub></b> or <b>X<sub>(n)</sub></b>).")),
            
            br(),
            
            sliderInput(inputId = "n",
                        label = "Select sample size n=",
                        value = 2,
                        min = 1,
                        max = 200, step = 1, animate = TRUE),
            
            selectInput(inputId = "distri",
                        label = "Probability distribution:",
                        choices = c("Uniform", "Shifted Exponential"),
                        selected = "Uniform"),
            
            br(),
            
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
            
            tags$a("Click here to get the classroom activity
                    to interact with the app.", 
                   href="Classroom_activity_CONVERGENCE.pdf"),
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
                        tabPanel("Results",
                                 plotOutput("distPlot", 
                                            click = "plot_click"),
                                 htmlOutput("info_00")),
                        tabPanel("Proofs", 
                                 includeHTML("Proof.html"))
                        )
        )
    )
))
