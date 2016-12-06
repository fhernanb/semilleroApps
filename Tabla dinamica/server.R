df=data.frame(lapply(1:25,function(i)i=rnorm(20)))
colnames(df)=as.character(letters[1:25])

shinyServer(function(input, output,session) {
  
  output$pivot <- renderRpivotTable({
    rpivotTable(data = df)
  })
  
  
})