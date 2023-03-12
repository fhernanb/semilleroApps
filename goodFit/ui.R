library(shiny)
library(knitr)

shinyUI(pageWithSidebar(
  headerPanel("Exploring the distribution that fits better for a variable"),
  
# Here the sidebarpanel
  sidebarPanel(
    h6("This app can be used to identify the best four
        distributions that fit better for a single variable. The user
        can provide the dataset using the buttons below."),
    h6("As an example the app uses the speed variable from
        the cars dataset."),
    h4("To use the app follow the next steps:"),
    h6("1. Upload the file,"),
    h6("2. Select the separator character,"),
    h6("3. Select the variable."),
    fileInput(inputId="file1", label="Use the next button to load your file.",
              accept = c(
                "text/csv",
                "text/comma-separated-values",
                "text/tab-separated-values",
                "text/plain",
                ".csv",
                ".tsv"
                )),
    checkboxInput("header", label="Does your file contain variable names
                  in the first line?", value=TRUE),
    selectInput(inputId="sep", label="What is the separator character in your file?",
                 choices=list("tab"="\t", ","=",", ";"=";", "space"=" "),
                 selected=";"),
    selectInput("response", label="Select the variable.", choices=""),
    selectInput("familia", "Select the family for the response variable:", 
                choice=list("Real plus" = "realplus",
                            "Real" = "realAll",
                            "Real between entre 0 y 1" = "real0to1",
                            "Counts" = "counts",
                            "Binomial" = "binom")),
    sliderInput("k", "Choose the number \\( k \\) to penalize for 
                     the excess number of parameters
                     in \\(GAIC=-2 \\times logLik + k \\times df\\).
                     The value \\( df \\) corresponds to the number of 
                     distribution parameters.",
                min=2,
                max=20,
                value=2,
                step=1,
                animate=TRUE),
    radioButtons(inputId = "type_plot", 
                 label = "Select the file type to download the plot.", 
                 choices = list("pdf", "png")),
    br(),
    p("This app was created by Semillero de R at Universidad Nacional 
          de Colombia:"),
    tags$a(href="https://srunal.github.io", "https://srunal.github.io")
),

# Here the panels
mainPanel(
  tabsetPanel(type ="pills",
              tabPanel("Selected distributions I",
                       h4("A continuación se presenta el histograma para 
                          la variable de interés
                          con la curva de densidad para cada distribución."),
                       plotOutput("distPlot1", width="700px", height="600px"),
                       downloadButton(outputId = "downplot1", label = "Download the plot")
              ),
              tabPanel("Selected distributions II",
                       h4("A continuación se presenta el histograma para 
                          la variable de interés
                          con la curva de densidad para cada distribución y
                          el qqplot asociado."),
                       plotOutput("distPlot2", width="700px", height="800px"),
                       downloadButton(outputId = "downplot2", label = "Download the plot")
              ),
              tabPanel("Data", uiOutput("data_table")),
              tabPanel("Goodness of fit test"),
              tabPanel("Theory", includeHTML("include.html"))
    )
  )
 )
)
 

