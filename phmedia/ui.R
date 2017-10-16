library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
  headerPanel(title=HTML("Hypothesis test for &mu;"),
              windowTitle="Test_for_mu"),
  sidebarPanel(
    h5('This app performs the hypothesis test for the mean of
        a quantitative variable.'),
    
    h6('The app works with a dataset as example but the user can upload
       her/his own dataset.'),
    
    fileInput(inputId='file1',
              label='Use the next button to upload your dataset.',
              accept = c(
                'text/csv',
                'text/comma-separated-values',
                'text/tab-separated-values',
                'text/plain',
                '.csv',
                '.tsv'
              )
    ),
    checkboxInput(inputId='header',
                  label='Does the dataset have header?', 
                  value=TRUE),
    
    selectInput(inputId="sep",
                label = "What is the separation sign?", 
                choices = list(Tab='\t', Comma=',', Semicolon=';'),
                selected = ';'),
    
    selectInput(inputId="variable",
                label="Choose the quantitative variable to perform
                        the hypothesis test.",
                choices=""),
    
    numericInput(inputId='mu0', 
                 label=HTML("Enter the reference value of 
                            &mu;<sub>0</sub> to test
                            H<sub>0</sub>: &mu; = &mu;<sub>0</sub>"), 
                 value=0),
    
    selectInput(inputId="h0", 
                label=HTML("Choose the alternative hipothesis
                          < , &ne; o >"), 
                choices=list("Less" = "less", 
                             "Different" = "two.sided",
                             "Greater" = "greater"),
                selected = "two.sided"),
    
    sliderInput(inputId='alfa', 
                label='Optional: choose the confidence level to
                        create the interval confidence.',
                min=0.90, max=0.99,
                value=0.95, step=0.01),
    
    img(src="logo.png", height = 60, width = 150),
    br(),
    
    tags$a(href="https://srunal.wordpress.com/", "https://srunal.wordpress.com/")

),

mainPanel(
  tabsetPanel(type = "pills",
              
              tabPanel("Results",
                       h5('Next you can find the histogram with density 
                          and the qqplot for the choosen variable.'),
                       
                       plotOutput("distPlot",
                                  width='500px',
                                  height='300px'),
                       
                       h5("- Summary table with sample statistics:"),
                       tableOutput('statistic'),
                       
                       h5("- Results for the hypothesis test:"),
                       textOutput("resul1"),
                       
                       h5(HTML("- Confidence interval for the mean &mu;")),
                       textOutput("resul2")),
              
              tabPanel("Dataset", 
                       "Next you can find the dataset used in the app.",
                       uiOutput('summary')),
              
              tabPanel("Theory", includeHTML("include.html"))
              
  )
)
  
))




