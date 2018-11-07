
library(shiny)
library(readxl)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
  
  data<- read_xlsx("BDempresas1.xlsx")

  output$hist1 <- renderPlot({
    reg <- subset(data, data$Region==input$regiones)
    hist(reg$Utilidad_neta, col = 'darkgray')
  })
  
  output$disp_puesto_util_neta <- renderPlot({
    data1 <- data[-c(1,2),]
    ggplot(data1, aes(data1$Puesto,data1$Utilidad_neta/1000000)) + 
      geom_jitter(width=0.5, size=2) + 
      labs(y="Utilidad neta (en millones de pesos)", x="Puesto en el año 2017") + 
      geom_hline(yintercept=mean(data1$Utilidad_neta/1000000, na.rm=T), color="red")
  })
  
  output$disp_puesto_util_oper <- renderPlot({
    data1 <- data[-c(1,2),]
    ggplot(data1, aes(data1$Puesto, data1$Utilidad_operacional/1000000)) + 
      geom_jitter(width = .5, size=2) + 
      labs(y="Utilidad operativa (en millones de pesos)", x="Puesto en el año 2017")
  })
  
  output$boxplotEBITDA <- renderPlot({
    ggplot(data=data, aes(x=data$Sector, y=jitter(data$Margen_EBITDA))) + 
      geom_boxplot(fill="Gray") + ylab("Margen EBITDA (%)") + xlab("Sector") + 
      theme(legend.position="top") + theme(axis.text.x=element_text(angle=90)) 
  })

 output$disp_puesto_marebitda <- renderPlot({
    data1 <- data[-c(1,2),]
    ggplot(data=data1, aes(x=data1$Puesto, y=data1$Margen_EBITDA)) + 
      geom_jitter(width=0.5, size=2) + labs(y="Margen EBITDA (%)", x="Puesto año 2017")
 })
 
 output$disp_puesto_ebitda <- renderPlot({
    data1 <- data[-c(1,2),]
    ggplot(data1, aes(data1$Puesto, data1$EBITDA/1000000)) + 
      geom_jitter(width = .5, size=2) + 
      labs(y="EBITDA (en millones de pesos)", x="Puesto en el año 2017")
  }) 
  
  output$boxplotEndeu <- renderPlot({
    data2 <- data[-c(85,81),]
    ggplot(data=data2, aes(x=data2$Region, y=jitter(data2$Nivel_endeudamiento))) + 
      geom_boxplot(fill="Gray") + ylab("% Nivel de endeudamiento") + xlab("Región") + 
      theme(legend.position="top") + 
      stat_summary(fun.y=mean, colour="darkred", geom="point", shape=18, size=3, show_guide=FALSE)
  })
  
  output$disp_puesto_nivende <- renderPlot({
    data2 <- data[-c(85,81),]
    ggplot(data=data2, aes(x=data2$Puesto, y=data2$Nivel_endeudamiento)) + 
      geom_jitter(width=0.5, size=2) + labs(y="% Nivel de endeudamiento", x="Puesto año 2017")
  })
  
  output$disp_puesto_rentact <- renderPlotly({ 
    data1 <- data[-c(85,81),]
    p <- ggplot(data1, aes(data1$Puesto, data1$Rentabilidad_neta_activo, col = data1$Sector)) + 
      geom_jitter(width=0.5, size=2) + 
      labs(y="Rentabilidad neta del activo (%)", x="Puesto en el año 2017")
    
    ggplotly(p)
  })
  
  output$disp_puesto_rentpat <- renderPlotly({  
    data1 <- data[-97,]
    p <- ggplot(data1, aes(data1$Puesto, data1$Rentabilidad_neta_patrimonio, col=data1$Sector)) + 
      geom_jitter(width=0.5, size=2) + 
      labs(y="Rentabilidad neta del patrimonio (%)", x="Puesto en el año 2017")  
    
    ggplotly(p)
  })
  
})
