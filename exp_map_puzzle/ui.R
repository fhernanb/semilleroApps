library(shiny)
library(knitr)

shinyUI(pageWithSidebar(
  headerPanel("App to analize country map puzzles datasets"),
  
# Here the sidebarpanel
  sidebarPanel(
    img(src="foto3.png", height = 240, width = 220),
    h6("This app can be used to analyze datasets from
       the experiment with map puzzles."),
    h6("As an example the app uses the paper dataset but the
       user could input another file with the data."),
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
    selectInput("response", label="Select the Response variable.", choices=""),
    selectInput("factor", label="Select the factor.", choices="")
),

# Here the panels
mainPanel(
  tabsetPanel(type ="pills",
              tabPanel("Results",
                       h4("Here you can find the results."),
                       plotOutput("distPlot1", width="330px", height="480px"),
                       verbatimTextOutput("anovaTable")
              ),
              tabPanel("Data", uiOutput("data_table"))
    )
  )
 )
)
 

