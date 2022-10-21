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

shinyUI(fluidPage(
    
    theme = shinytheme("paper"),

    titlePanel("Convergence in Probability and in Distribution"),

    sidebarLayout(
        sidebarPanel(
            
            p(HTML('This application illustrates how the order statistics 
            X<sub>(n)</sub> and X<sub>(1)</sub> converge in probability to 
            their objective parameter given respectively by the uniform 
            distribution on the interval (0, <b>&#947;</b>), and the shifted 
            exponential distribution with &#955 = 1 on the interval 
            [<b>&#947;</b>, &#8734;). To do so, the empirical cumulative 
            distribution function (ECDF) of X<sub>(n)</sub> and X<sub>(1)</sub> 
            is obtained first.')),
        
            p(HTML('The user can select the sample size <b>n</b>, the distribution, 
            the parameter <b>&#947;</b>, and <b>&#1013;</b>. The application simulates
            10000 samples of size <b>n</b> from the selected distribution to 
            compute 10000 values of X<sub>(n)</sub> or X<sub>(1)</sub> (represented 
            respectively by x<sub>(n)</sub> and x<sub>(1)</sub>) and plot their 
            corresponding ECDF. Thus, as the empirical F<sub>X<sub>(n)</sub></sub>(t) 
            and F<sub>X<sub>(1)</sub></sub>(q) approach respectively the degenerate 
            distributions F(t) and F(q) as <b>n</b> increases, it is inferred in that
            order that X<sub>(n)</sub> and X<sub>(1)</sub> converge in probability 
            to their respective parameter.')),
            
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
                         "Click here to get a workshop to interact with the 
                         application."),
            
            br(),
            
            p("This application was developed by Mateo Ochoa Medina and
            Freddy Hernández Barajas from
            Universidad Nacional de Colombia:"),
            
            img(src = "Logo_unal_negro.png",
                height = 60, width = 140)
            
        ),

        mainPanel(
            tabsetPanel(type = "pills",
                        tabPanel("Illustration",
                                 plotOutput("distPlot", 
                                            click = "plot_click",
                                            height = "500px",
                                            width = "800px"),
                                 htmlOutput("info_00")),
                        tabPanel("Proofs", 
                                 includeHTML("Proof.html"))
                        )
        )
    )
))
