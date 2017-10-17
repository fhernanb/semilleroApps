library(shiny)
shinyServer(function(input,output,session){
        
        
       output$analisis_ph <- renderTable({
                inFile <- input$file1
                if(is.null(inFile)) 
                       dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
                else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
                y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
                prueba_hip_varianza(variable = y, 
                                   varianza_h_n = input$sigma20, 
                                  nivel_significancia = input$alfa,
                                 tipo_de_prueba = input$h0)
        })
        
        observe({
                inFile <- input$file1
                if(is.null(inFile)) 
                        dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
                else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
                updateSelectInput(session, "variable", choices = names(dt))
        })
        
        output$summary <- renderTable({
                inFile <- input$file1
                if(is.null(inFile)) 
                        dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
                else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
                dt
        })
        
       # output$statistic <- renderTable({
        #        inFile <- input$file1
         #       if(is.null(inFile)) 
          #              dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
           #     else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
            #    y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
             #   res <- data.frame(Media=mean(y), Varianza=var(y), n=length(y))
              #  res
        #})
        
        output$distPlot <- renderPlot({
                inFile <- input$file1
                if(is.null(inFile)) 
                        dt <- read.table('geardata.txt', col.names = c("diameter", "batch_number"))
                else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
                par(mfrow=c(1, 2), bg='gray98')
                y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
                hist(y, col='deepskyblue3', freq=F, las=1,
                     xlab=as.character(input$variable), main='Histograma y densidad',
                     ylab='Densidad')
                lines(density(y), lwd=4, col='firebrick3')
                qqnorm(y, las=1, main='QQplot',
                       pch=19, col='deepskyblue3',
                       ylab=as.character(input$variable))
                qqline(y)
                shapi <- shapiro.test(y)
                legend('topleft', bty='n', col='red', text.col='deepskyblue3',
                       legend=paste('Valor P=', round(shapi$p.value,2)))
        })
        
        #output$resul1 <- renderText({
                #inFile <- input$file1
                #if(is.null(inFile)) 
                 #       dt <- read.table('geardata.txt', header=T, col.names = c("diameter", "bold_value"))
                #else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
               # y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
              #  ph <- Var.test(x=y, alternative=input$h0, mu=input$sigma20, conf.level=input$alfa)
             #   conclusion <- ifelse(ph$p.value < 0.05, 'se rechaza', 'no se rechaza')
            #    paste0('El estadistico de prueba fue to=', round(ph$statistic, 2),
           #            ' con un valor P de ', round(ph$statistic, 4), ', por lo tanto se concluye
          #             que basados en la evidencia muestral la hipotesis nula ', conclusion,
         #              ' (nivel de significancia 5%).')
        #})
        
        
       # output$resul2 <- renderText({
                #inFile <- input$file1
                #if(is.null(inFile)) 
                 #       dt <- read.table('geardata.txt', header=T, col.names = c("diameter", "bold_value"))
                #else dt <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
                #y <- na.omit(dt[, input$variable])  # Para sacar los NA de la variable
                #ph <- t.test(x=y, alternative=input$h0, mu=input$sigma20, conf.level=input$alfa)
                #intervalo <- paste("(", round(ph$conf.int[1], digits=4), ", ",
                 #                  round(ph$conf.int[2], digits=4), ").", sep='')
                #paste0('El intervalo de confianza del ', 100*input$alfa,
                 #      '% para la media poblacional es ', intervalo)
        #})
        
        output$miteoria <- renderUI({
               HTML(markdown::markdownToHTML(knit(input='incluede.md', quiet = TRUE)))
        })
        
        
        
})