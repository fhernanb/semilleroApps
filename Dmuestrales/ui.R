shinyUI(fluidPage(
  titlePanel(h1("Distribuciones muestrales",align="center", style="color:steelblue")),
  h4(p("Esta aplicacion te ayudara a calcular probabilidades y percentiles de distribuciones asociadas al muestreo"),align="center"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId="Distribucion",
                  label="Elige la distribucion:",
                  choices=c("Normal", "t-student", "chi.cuadrada", "F"),
                  selected="Normal"),


      conditionalPanel(condition="input.Distribucion=='Normal'",
                       numericInput(inputId="Media",
                                    label=HTML("Ingrese la media &mu;:"),
                                    value="0",
                                    step=0.1),

                       numericInput(inputId="Sd",
                                    label=HTML("Ingrese la desviacion &sigma;:"),
                                    min=0.1,
                                    value="1",
                                    step=0.1) ),

      conditionalPanel(condition="input.Distribucion=='t-student'",
                       numericInput(inputId="grados",
                                    label="Ingrese grados de libertad",
                                    min=0.1,
                                    step=0.1,
                                    value="1")),


      conditionalPanel(condition="input.Distribucion=='F'",
                       numericInput(inputId="grados1",
                                    label="Ingrese  los grados de libertad del numerador",
                                    value="10"),

                       numericInput(inputId="grados2",
                                    label="Ingrese los grados de libertad del denominador",
                                    value="20")),

      conditionalPanel(condition="input.Distribucion=='chi.cuadrada'",
                       numericInput(inputId="Grados",
                                    label="Ingrese los grados de libertad",
                                    value="3")),

            selectInput(inputId="Propede",
                  label="Opciones para calcular:",
                  choices=c("Probabilidad","Percentil"),
                  selected="Percentil"),

      conditionalPanel(condition="input.Propede=='Probabilidad'",
                       numericInput(inputId="Percentil",
                                    label="Ingrese percentil",
                                    value=1, step=0.01)),

      conditionalPanel(condition="input.Propede=='Percentil'",
                       numericInput(inputId="Probabilidad",
                                    label="Ingrese probabilidad",
                                    value=0.70, step=0.001,
                                    min=0.001, max=0.999)),

      img(src="udea.png", height = 72, width = 64),
      img(src="logo.png", height = 56, width = 136)

    ),


    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Grafica", plotOutput(outputId="miplot"))


      )
    )
  )))
