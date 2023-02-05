
the_functions <- ls("package:gamlss.dist")
distributions <- grep("^[A-Z ]+$", the_functions, value = TRUE)

input <- NULL
input$distribution <- "LO"
input$distribution <- "GA"
input$distribution <- "BE"
input$distribution <- "ZAGA"
input$distribution <- "PO"

d <- gamlss.family(input$distribution)
names(d)

regions <- c(d$y.valid(-0.5), d$y.valid(0.0), d$y.valid(0.5), d$y.valid(1.5))



case_when(
  identical(regions, c( TRUE,  TRUE, TRUE, TRUE))  ~ "realline",
  identical(regions, c(FALSE, FALSE, TRUE, TRUE))  ~ "realplus",
  identical(regions, c(FALSE, FALSE, TRUE, FALSE)) ~ "real0to1"
)


type <- ifelse(identical(regions, c( TRUE,  TRUE, TRUE, TRUE), "realline", 0))

if (identical(regions, c(TRUE, TRUE, TRUE, TRUE))) type <- "realline"

texto <- eval(paste0("curve(d", input$distribution, "(x), from=input$minimo, to=input$maximo)"))
eval(parse(text=texto))


input <- NULL
input$distribution <- "BE"
input$distribution <- "ZAGA"
input$distribution <- "PO"




mu <- 5
texto <- eval("dnorm(x=1, mean=mu)")
eval(parse(text=texto))




