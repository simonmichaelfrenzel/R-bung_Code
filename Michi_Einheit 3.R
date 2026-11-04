### Wdh ###
# Wo stehen wir? - Dataframes und aswählen filtern + Wie umgehen mit N.A.?
# Heute: "einfacher filtern", "Daten simulieren", "einlesen von realen Datensätzen"


## filter() - Funktion ##

#install.packages("tidyverse")
#library(tidyverse)
starwars = as.data.frame(starwars[, 1:11])

filter(.data, ..., .by, .preserve)
#.by = Gruppierung. d.h. bei uns: "mean" wird für jede Spezies berechnet 
#. preserve = True --> leere Gruppen bleiben erhalten/ default = F

filter(starwars, height > mean(height, na.rm=TRUE), .by= species)


## Daten simulieren ##

# Wozu: Üben ohne sensible Daten; ABER auch: Zufällige Ziehungen für manche stat. Methoden 

# set.seed(): Zufallszahlen sind in R nur "pseudo-zufällig". Mit derselben
# Startzahl erhalten alle im Raum exakt dieselben Zufallszahlen.
# Anwendung: gleiche Ergebnisse für zb Bachelorarbeit 

set.seed(11)

# Widerholung von Werte 
rep(c("KG", "EG"), times = 20)
gruppe = rep(c("KG", "EG"), each = 50)

# Ziehung von Werten aus einer Stichprobe --> zb Zufällige Werte einer Antwortskala ("Likert")
likert = sample(c(1,2,3), 100, replace = T, prob= c(0.2, 0.3, 0.5)) #replace = T -> mit Zurücklegen
# "re-place = wieder zurücklegen"

#Normalverteilte Daten
#rnorm(n, mean = 0, sd = 1)
iq = rnorm(100, mean = 100, sd=15 )
iq = round(iq, 0)
mean(iq)

# z.B einen großen Datensatz simulieren 
studie = data.frame(
  id = 1:100,
  gruppe = factor(gruppe),
  iq = round(iq),
  belastung = likert 
)

## Speichern und einlesen von Datensätzen ##

install.packages("tidyverse")   # einmalig, falls noch nicht installiert
install.packages("modeest")     # einmalig, falls noch nicht installiert
install.packages("haven")

library(tidyverse)   # enthält u. a. dplyr (select, filter, ...) und ggplot2
library(modeest)     # für den Modalwert
library(haven)



# erstmal schaun, wo wir hinspeichern 
getwd()


write.csv(studie, "studie.csv", row.names = F) 
# Warum row.names = FALSE? Sonst schreibt R die Zeilennummern (1, 2, 3, ...) als
# zusätzliche, namenlose erste Spalte in die Datei.

# Deutsches Excel: Semicolon als trennzeichen, Komma als Dezimalzeichen --> 
# write.csv2()

read.csv("studie.csv")

# andere Formate 
write_sav() # spss Files aus haven-Paket
read_sav()


saveRDS() # R intern, lädt schnell 
readRDS()

writexl::write_xlsx(studie, "studie.xlsx") #Excel 
readxl::read_excel("studie.xlsx")


## Mit echten Daten arbeiten ## 

# 1. Fragebogen bipolar herzeigen 
# 2. Daten herzeigen 
# 3. einlesen
bipolar = read.csv(file = "bipolar.csv")
head(bipolar) # ersten Zeilen 
str(bipolar) # Variablen 
summary(bipolar) # Übersicht für jede Variable 

## Summenscore bilden ##
# ZIEL: Für jede Person die Summe aller YMRS-Items berechnen (Screening-Instrument).

# Wie könnte das gehen: 
#Variante1: einfach addieren: 
bipolar$Sum_YMRS = bipolar$YMRS_1 + bipolar$YMRS_2 # ... dauert lange
#Variante2: rowSums() -> Summer pro Ziel/ etwas schneller 
rowSums(bipolar[, c("YMRS_1", "YMRS_2")])

# Variante 3: select()
bipolar$Sum_YMRS = rowSums(select(bipolar, starts_with("YMRS_")))

# Frage: Warum Sum_YMRS und nicht YMRS_Sum?

#Hinweis: N.A. in Items --> gesamte Summe ist N.A.
sum(is.na(bipolar$sum_YMRS)) # wie viele n.A. sind drinnen?

### bis hier geschaftt ####


