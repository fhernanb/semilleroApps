library(shiny)

ui <- fluidPage(sidebarLayout(
  sidebarPanel(
    selectInput("dataset", "choose a dataset", c("mtcars", "iris")),
    selectInput("column", "select column", "placeholder1"),
    selectInput("level", "select level", "placeholder2")
  ),
  mainPanel(tableOutput("table"))
))

server <- function(input, output, session){
  
  dataset <- reactive({
    get(input$dataset)
  })
  
  observe({
    updateSelectInput(session, "column", choices = names(dataset())) 
  })
  
  observeEvent(input$column, {
    column_levels <- as.character(sort(unique(
      dataset()[[input$column]]
    )))
    updateSelectInput(session, "level", choices = column_levels)
  })
  
  output$table <- renderTable({
    subset(dataset(), dataset()[[input$column]] == input$level)
  })
}

shinyApp(ui, server)
