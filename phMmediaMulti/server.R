library(shiny)

shinyServer(function(input,output,session){

#Base de datos------------
  observe({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header,
                        sep=input$sep)
   updateCheckboxGroupInput(session, "names",
                             choices = colnames(dt[,]),
                             selected = c("x1","x2","x3"))
                             
  })
  
  output$inputData <- renderTable({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    dt
  })
  
  #Esta.Prue-----
  
  To<-function(base,M0){
    Mmues<-c(unname(colMeans(base))) #varia segun la base sumistrada
    n<- nrow(base) ##DEBE VARIAR SEGUN LA SELECCIÓN
    S<-cov(base) # DEBE VARIAR SEGUN LA SELECCIÓN
    Scom<-solve(S)
   #obtencion del valor del EP-------
    T0<-n*t(Mmues-M0)%*%Scom%*%(Mmues-M0)
    p<-length(M0) # VARIA segÚn el tamaño de variables escogidas para el vector
    a<-((n-1)*p/(n-p))
    value<-pf(q=T0/a,df1=p,df2=n-p,lower.tail=F)
    res<-list(estadistico=T0,p=p,n=n,Mmues=Mmues,S=S,
              a=a,
              df1=p,
              df2=n-p,
              value=value)
    return(res)
  }
  
#para mostrar-----------------
  output$med_muestra <- renderPrint({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    vv <- c(input$names)
    #manera de entrar vector de medias--------------
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    
    Mprima<- To(base = dt[,vv], M0=vectorMed)
    round(Mprima$Mmues,2)
          })
  
  output$med_ho <- renderPrint({
    #manera de entrar vector de medias--------------
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    round(vectorMed,2)
    
    })
  
  output$S_muestra <- renderPrint({
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    vv <- c(input$names)
    #manera de entrar vector de medias--------------
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    
    Mprima<- To(base = dt[,vv], M0=vectorMed)
    round(Mprima$S,2)
    })

  output$grafico1 <- renderPlot({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    ph <- To(base = dt[,vv], M0=vectorMed)
    asbio::shade.F(x=(as.numeric(ph$estadistico)/ph$a),
                   nu1=ph$df1,
                   nu2=ph$df2, 
                   tail='upper', las=1, 
                   shade.col="dodgerblue3", cex=2)
  })
  
  output$titleValorp<- renderText({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    
    #manera de entrar vector de medias--------------
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    
    ph <- To(base = dt[,vv], M0=vectorMed)
    paste0('Distribución F (', ph$p,",",ph$n-ph$p,")")
  })
  
  output$resul1<- renderText({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    
    #manera de entrar vector de medias--------------
    vectorMed <- input$vectorIng
    vectorMed <- as.numeric(unlist(strsplit(vectorMed, "[\n, \t]")))
    vectorMed <- vectorMed[!is.na(vectorMed)]
    
    ph <- To(base = dt[,vv], M0=vectorMed)
        paste0('El estadístico de prueba es T2 =', round(ph$estadistico, 2),
               ', con un valor-P = ',round(ph$value, 4),
               " ,concluya según el nivel de significancia.")
  })
  
  output$qqplot <- renderPlot({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    
    require(car)
    dist<-mahalanobis(dt[,vv],center=colMeans(dt[,vv]),cov=var(dt[,vv]))
    qqPlot(dist, dist="chisq", df=length(dt[, vv]), pch=19,
           ylab='Distancias de Mahalanobis', las=1,
           xlab='Cuantiles de una chi-cuadrada con p grados de libertad')
    
    grid()
  })

  
  output$royston <- renderPrint({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    # Para sacar los NA de la variable
    
    require(MVN)
      valorqq<-mvn(data= dt[,vv],mvnTest = "royston", multivariatePlot= "qq")
      valorqq$multivariateNormality
  })
  
  output$mardia <- renderPrint({
    vv <- c(input$names)
    inFile <- input$file1
    if(is.null(inFile)) 
      dt <- read.delim2('base.txt')
    else dt <- read.csv(inFile$datapath, header=input$header, 
                        sep=input$sep)
    # Para sacar los NA de la variable
    
    require(MVN)
    valorqq<-mvn(data= dt[,vv],mvnTest = "mardia", multivariatePlot= "qq")
    valorqq$multivariateNormality
  })
  

  })
