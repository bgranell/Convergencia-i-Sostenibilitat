install.packages("readxl")
library(readxl)
library(dplyr)
library(ggplot2)

#___________________________________________________________________________________________________

#                                   PIBpc

#Filtrem dades de PIBpc entre 1970 i 2018.

PIBpc_històric_paisos <- read_excel("C:/Users/admin/Desktop/Inquietuds Programació/Emissións/Històric PIBpc Països.xls", 2)
PIBpc_històric_paisos

PIBpc_històric_paisos <- rename(PIBpc_històric_paisos, Year = Country)
PIBpc_històric_paisos

PIBpc_històric1970_paisos <- PIBpc_històric_paisos[PIBpc_històric_paisos$Year > 1969,]
PIBpc_paisos_net <- PIBpc_històric1970_paisos[PIBpc_històric1970_paisos$Year <2019,]

#Filtrem dades de PIBpc de la Xina entre 1970 i 2018.

PIBpc_Xina <- PIBpc_paisos_net[ , c("Year", "China")]
PIBpc_Xina

# Canviem tipus de dades de chr a dbl per poder ajuntar els dos data frames.

PIBpc_Xina$Year <- as.numeric(PIBpc_Xina$Year)

#____________________________________________________________________________________________

#                                   EMISSIONS

#Filtrem les dades d'emissions de la Xina.

contaminació_anual_paisos <- read_excel("C:/Users/admin/Desktop/Inquietuds Programació/Emissións/EDGARv6.0_FT2020_fossil_CO2_GHG_booklet2021.xls", 6)
contaminació_anual_paisos

dades_contaminació_China <- contaminació_anual_paisos[, c("Year", "China")]
dades_contaminació_China

#Obtenim els increments percentuals anuals de les emissions.

Increment_percentual <- function(x) {
  ((x-lag(x))/lag(x))*100
}

EMISSIONS_Xina <- mutate(dades_contaminació_China, Increm_Emissions = Increment_percentual(dades_contaminació_China$China))
print(EMISSIONS_Xina)


# AJUNTEM TAULA de PIBpc amb taula d'EMISSIONS.
DADES_XINA <- EMISSIONS_Xina %>%
  left_join(PIBpc_Xina, by = "Year", suffix = c("_emissions", "_PIBpc"))

#Creem Increment percentual del PIBpc.

DADES_XINA <- mutate(DADES_XINA, Increm_PIBpc = Increment_percentual(DADES_XINA$China_PIBpc))
print(DADES_XINA)

#Creem Emissió per unitat de PIBpc

DADES_XINA <- mutate(DADES_XINA, Emissió_unitat_PIBpc = DADES_XINA$China_emissions/DADES_XINA$China_PIBpc)
print(DADES_XINA, n=49)

# Creem increment percentual Emissió x unitat de PIB/pc

DADES_XINA <- mutate(DADES_XINA, Increm_Eficiència = Increment_percentual(DADES_XINA$Emissió_unitat_PIBpc))
DADES_XINA

# cALCULEM LA PREDICCIÓ D'INCREMENT DE LES EMISSIONS segons els increments en PIBpc i els increments en eficiència.

DADES_XINA <- mutate(DADES_XINA, PREDICCIÓ = DADES_XINA$Increm_PIBpc+DADES_XINA$Increm_Eficiència)
DADES_XINA

# cALCULEM l'ERROR entre la PREDICCIÓ i l'INCREMENT de les EMISSIONS REAL.

DADES_XINA <- mutate(DADES_XINA, ERROR = DADES_XINA$Increm_PIBpc+DADES_XINA$Increm_Eficiència-DADES_XINA$Increm_Emissions)
DADES_XINA

#CALCULEM el pes de la predicció sobre l'increment real

DADES_XINA <- mutate(DADES_XINA, VALIDESA = 1-(DADES_XINA$Increm_PIBpc+DADES_XINA$Increm_Eficiència-DADES_XINA$Increm_Emissions)/DADES_XINA$Increm_Emissions)
DADES_XINA

DADES_XINA <- rename(DADES_XINA, Emissions = China_emissions)
DADES_XINA

DADES_XINA <- rename(DADES_XINA,  PIBpc = China_PIBpc)
DADES_XINA


#REPRESENTACIÓ DADES DE LA XINA

GRÀFIC_EMISSIONS_HISTÒRIQUES_XINA <- ggplot(DADES_XINA, aes(x=Year, y= Emissions/1000))+
  geom_point() +
  ggtitle("Emissions de GEH xineses (MT)") +
  scale_y_continuous(breaks = seq(0,15,1)) +
  theme(plot.title = element_text(size = rel(1.0), vjust=0.5,
                                  hjust = 0.5, face = "italic")) +
  labs(x = NULL, y="Emissions")

GRÀFIC_EMISSIONS_HISTÒRIQUES_XINA


GRÀFIC_PIBpc_HISTÒRIC_XINA <- ggplot(DADES_XINA, aes(x=Year, y= PIBpc))+
  geom_point()+
  ggtitle("PIB per càpita xinès (USD)") +
  scale_y_continuous(breaks = seq(0,10000,500)) +
  theme(plot.title = element_text(size = rel(1.0), vjust=0.5,
                                  hjust = 0.5, face = "italic")) +
  labs(x = NULL, y="PIBpc")

GRÀFIC_PIBpc_HISTÒRIC_XINA


GRÀFIC_EFICIÈNCIA_HISTÒRICA_XINA <- ggplot(DADES_XINA, aes(x=Year, y= Emissió_unitat_PIBpc))+
  geom_point()+
  ggtitle("Emissió per unitat de PIBpc (MT)") +
  scale_y_continuous(breaks = seq(0,20,2)) +
  theme(plot.title = element_text(size = rel(1.0), vjust=0.5,
                                  hjust = 0.5, face = "italic")) +
  labs(x = NULL, y="Emissió unitària")

GRÀFIC_EFICIÈNCIA_HISTÒRICA_XINA




