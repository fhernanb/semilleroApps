
dt <- readxl::read_excel("BDempresas.xlsx")
dt <- subset(dt, ing < 55000000)

tabla <- table(dt$Sector)
tabla <- tabla[tabla >= 5]
sectores <- names(tabla)

