library(shiny)

shinyServer(function(input, output, session){

# ----------------------- Shadow function ----------------------
  shadowtext <- function(x, y=NULL, labels, col='white', bg='black',
                         theta= seq(0, 2*pi, length.out=50), r=0.1, ... ) {

    xy <- xy.coords(x,y)
    xo <- r*strwidth('A')
    yo <- r*strheight('A')

    # draw background text with small shift in x and y in background colour
    for (i in theta) {
      text( xy$x + cos(i)*xo, xy$y + sin(i)*yo, labels, col=bg, ... )
    }
    # draw actual text in exact xy position in foreground colour
    text(xy$x, xy$y, labels, col=col, ... )
  }
  #--------------------------------------------------------------

  output$miplot <- renderPlot({

#----------------------------- Normal  ---------------------------------

       if(input$Distribucion == "Normal"){
         if(input$Propede == "Percentil"){

           media <- input$Media
           desvi <- input$Sd
           proba <- input$Probabilidad
           percentil <- qnorm(p=proba, mean=media, sd=desvi)

           k <- 5  # numero de desviaciones
           curve(dnorm(x, media, desvi), xlim=media+c(-k,k)*desvi, lwd=3,
                 main='Distribución normal', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(media-k*desvi, media+k*desvi, desvi), pos=0)
           axis(2, las=1)
           secuencia <- seq(media-k*desvi, percentil, length.out=10000)
           cord.x <- c(media-k*desvi, secuencia, percentil)
           cord.y <- c(0, dnorm(secuencia, media, desvi), 0)
           polygon(cord.x, cord.y, col='steelblue')
           shadowtext(x=percentil, y=0, round(percentil, 2), col="chartreuse", cex=2)
           title(sub=bquote(P(X<.(percentil))==.(proba)), cex.sub=2)

         }

         else {
           media <- input$Media
           desvi <- input$Sd
           percentil <- input$Percentil
           proba <- pnorm(percentil, media, desvi)

           k <- 5  # numero de desviaciones
           curve(dnorm(x, media, desvi), xlim=media+c(-k,k)*desvi, lwd=3,
                 main='Distribucion normal', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(media-k*desvi, media+k*desvi, desvi), pos=0)
           axis(2, las=1)
           if (percentil > media-k*desvi) {
             secuencia <- seq(media-k*desvi, percentil, length.out=10000)
             cord.x <- c(media-k*desvi, secuencia, percentil)
             cord.y <- c(0, dnorm(secuencia, media, desvi), 0)
             polygon(cord.x, cord.y, col='steelblue')
             altura <- dnorm(percentil, media, desvi)
             shadowtext(x=percentil, y=altura/2, round(proba, 2), col="orchid2", cex=2)
           }
           title(sub=bquote(P(X<.(percentil))==.(proba)), cex.sub=2)

         }}

#----------------------------- t-student ---------------------------------

       if(input$Distribucion == "t-student"){


         if(input$Propede == "Percentil"){
           df=input$grados
           proba <- input$Probabilidad
           percentil <- qt(p=proba, df=df, lower.tail=F)

           curve(dt(x, df), xlim=c(-5,5), lwd=3,
                 main='Distribucion t-student', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(-5, 5, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, 5, length.out=10000)
           cord.x <- c(percentil, secuencia, 5)
           cord.y <- c(0, dt(secuencia, df=df), 0)
           polygon(cord.x, cord.y, col='darkolivegreen3')
           shadowtext(x=percentil, y=0.01, round(percentil, 2), col="chartreuse", cex=2)
           title(sub=bquote(P(t>.(percentil))==.(proba)), cex.sub=2)

           output$perce <- renderText(percentil)
         }

         else {
           df=input$grados
           percentil=input$Percentil
           proba <- pt(q=percentil, df=df, lower.tail=F)

           curve(dt(x, df), xlim=c(-5,5), lwd=3,
                 main='Distribucion t-student', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(-5, 5, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, 5, length.out=10000)
           cord.x <- c(percentil, secuencia, 5)
           cord.y <- c(0, dt(secuencia, df=df), 0)
           polygon(cord.x, cord.y, col='darkolivegreen3')
           altura <- dt(x=percentil, df=df)
           shadowtext(x=percentil, y=altura/2, round(proba, 2), col="orchid2", cex=2)
           title(sub=bquote(P(t>.(percentil))==.(proba)), cex.sub=2)

         }

         }

#-----------------------------   F    ---------------------------------

       if(input$Distribucion == "F"){


         if(input$Propede == "Percentil"){

           proba <- input$Probabilidad
           df1=input$grados1
           df2=input$grados2
           percentil <- qf(p=proba, df1, df2, lower.tail=F)

           max.x <- 3 * percentil
           curve(df(x, df1, df2), xlim=c(0, max.x), lwd=3,
                 main='Distribucion F', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(0, max.x, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, max.x, length.out=10000)
           cord.x <- c(percentil, secuencia, max.x)
           cord.y <- c(0, df(secuencia, df1, df2), 0)
           polygon(cord.x, cord.y, col='lightsalmon3')
           shadowtext(x=percentil, y=0.01, round(percentil, 2), col="chartreuse", cex=2)
           title(sub=bquote(P(F>.(percentil))==.(proba)), cex.sub=2)

         }

         else {
           df1=input$grados1
           df2=input$grados2
           percentil=input$Percentil
           proba <- pf(q=percentil, df1, df2, lower.tail=F)

           max.x <- 3 * percentil
           curve(df(x, df1, df2), xlim=c(0, max.x), lwd=3,
                 main='Distribucion F', ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(0, max.x, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, max.x, length.out=10000)
           cord.x <- c(percentil, secuencia, max.x)
           cord.y <- c(0, df(secuencia, df1, df2), 0)
           polygon(cord.x, cord.y, col='lightsalmon3')
           altura <- df(x=percentil, df1, df2)
           shadowtext(x=percentil, y=altura/2, round(proba, 2), col="orchid2", cex=2)
           title(sub=bquote(P(F>.(percentil))==.(proba)), cex.sub=2)


         }}

#-----------------------------   chi    ---------------------------------

       if(input$Distribucion == "chi.cuadrada"){


         if(input$Propede == "Percentil"){
           proba <- input$Probabilidad
           df=input$Grados
           percentil <- qchisq(p=proba, df, lower.tail=F)

           max.x <- qchisq(p=0.99, df)
           curve(dchisq(x, df), xlim=c(0, max.x), lwd=3,
                 main=expression('Distribucion' ~ chi^2), ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(0, max.x, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, max.x, length.out=10000)
           cord.x <- c(percentil, secuencia, max.x)
           cord.y <- c(0, dchisq(secuencia, df), 0)
           polygon(cord.x, cord.y, col='yellow3')
           shadowtext(x=percentil, y=0, round(percentil, 2), col="chartreuse", cex=2)
           title(sub=bquote(P(chi^2>.(percentil))==.(proba)), cex.sub=2)


         }
         else {

           df=input$Grados
           percentil=input$Percentil
           proba <- pchisq(q=percentil, df, lower.tail=F)

           max.x <- qchisq(p=0.99, df)
           curve(dchisq(x, df), xlim=c(0, max.x), lwd=3,
                 main=expression('Distribucion' ~ chi^2), ylab="", xlab="", axes=FALSE)
           axis(1, at=seq(0, max.x, by=0.5), pos=0)
           axis(2, las=1)
           secuencia <- seq(percentil, max.x, length.out=10000)
           cord.x <- c(percentil, secuencia, max.x)
           cord.y <- c(0, dchisq(secuencia, df), 0)
           polygon(cord.x, cord.y, col='yellow3')
           altura <- dchisq(x=percentil, df)
           shadowtext(x=percentil, y=altura/2, round(proba, 2), col="orchid2", cex=2)
           title(sub=bquote(P(chi^2>.(percentil))==.(proba)), cex.sub=2)


         }}
          })
})
