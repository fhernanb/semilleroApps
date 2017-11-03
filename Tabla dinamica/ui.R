library(shiny)
library(rpivotTable)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "example"),
  dashboardSidebar(disable = T),
  dashboardBody(
    
    tags$head(tags$style( type = 'text/css',  '#pivot{ overflow-x: scroll; }')),
    rpivotTableOutput('pivot', width = "100%", height = "500px")
  )
  
))