#test
# test test 
# test test test 

# 1. Einheit ---------------------------------------------------------------

# R-Studio-Umgebung erklären
# R-Projekt erstellen
# Blanko Skript erstellen


#Wichtige weitere Inhalte: 
# Markdown-Vorlage herzeigen 
# Pakete allgemein erklären 
# Bookdown herzeigen 


# AUSWAHL GRUNDLEGENDER OPERATOREN

2+2 # Addition
5-3 # Subtraktion
5*8 # Multiplikation
8/2 # Division
3^2 # Potenz, Alternative: **
sqrt(9)

# DATENFORMATE

# SKALAR
# Numerische (numeric) Skalare
a = 100 
b = 3/100
c = a + b
d = (a + b) / b

# Character Skalare
e = "Psychologie"
f = "Zigarre"
g = "Haben Psychologen wirklich alle Bärte und rauchen Zigarre?"

# ACHTUNG: Anführungszeichen sind character-Variablen spezifisch

# VEKTOR
# Numerische Vektoren
j = c(1, 2, 3, 4, 5, 6, 7)
k = c(1:200)
k = c(1:7, seq(from = 20, to = 30, by = 2))

# ÜBUNG: Bitte erstellen Sie einen numerischen Vektor "CFH", welcher die Zahlenfolge von 12 bis 54 und jede dritte Zahl zwischen 100 bis 120 enthält
CFH = c(12:54, seq(from = 100, to = 120, by = 3))
CFH = c(12:54, seq(100, 120, 3)) # HINWEIS: Argumente "from", "to", "by" nicht namentlich notwendig

# Character Vektor
Psychologen = c("Freud", "Wundt", "Bandura")

class(Psychologen) # Objektklasse anzeigen lassen

Name = c("Max", "Maja", "Mia", "Moritz", "Markus")
Alter = c(20, 31, 25, 34, 51)
Diagnose = c("Depression", "Zwangsstörung", "Depression", "Soziale Phobie", "Depression")

# Datenmatrizen in R: data.frame
df = data.frame(Name = c("Max", "Maja", "Mia", "Moritz", "Markus"),
                Alter = c(20, 31, 25, 34, 51),
                Diagnose = c("Depression", "Zwangsstörung", "Depression", "Soziale Phobie", "Depression"))
df

nrow(df)
ncol(df)

# INDIZIERUNG
df$Alter # Möglichkeit, um Spalten (Variablen) in Data.Frames anzuwählen: "$"

df[1, 2] # Möglichkeit, einzelne Elemente aus Data.Frames anzuwählen: "[ , ]"
# Alles, was vor dem Komma steht: ZEILEN
# Alles, was nach dem Komma steht: SPALTEN

df[,1]
df[1,]

df[3,"Alter"]

# ÜBUNG: Welche Diagnose hat Person in zweiter Zeile?
df[2,"Diagnose"] # Anwahl über den genauen Variablennamen 
df[2,3] # Anwahl über Position der Variable

df[2,"Diagnose"]="Soziale Phobie"
df[2,"Diagnose"]="Zwangsstörung"

# FAKTOR-Variablen
geschlecht = c(1, 2, 2, 1, 2)
geschlecht = factor(geschlecht, levels = c(1,2), labels = c("männlich", "weiblich")) # KODIERUNG: Umwandlung in einen Faktor

# Arbeit mit "starwars" Datensatz aus Paket "dplyr"
# install.packages("dplyr")
library(dplyr)

starwars = as.data.frame(starwars[,1:11])

# Werte nach einer bestimmten LOGIK auswählen
# BOOL'SCHE OPERATOREN

gewicht = starwars$mass

gewicht[gewicht == 79] # Gleich ==
gewicht[which(gewicht == 79)] # Gleich ==

gewicht[which(gewicht != 79)] # NICHT !=
gewicht[which(gewicht >= 79)] # GRÖSSER GLEICH >=

haarfarbe = starwars$hair_color

haarfarbe[which(haarfarbe == "brown")]
length(haarfarbe[which(haarfarbe == "brown")]) # Genau Anzahl der Fälle, auf die unsere Logik zutrifft

table(starwars$hair_color)

head(starwars)
summary(starwars$mass)
dim(starwars)
nrow(starwars)
ncol(starwars)

# VERKNÜPFUNGSOPERATOREN und &, oder |

gewicht[which(gewicht == 79)]

# Gewicht von Charakteren, die mehr wiegen als 50 und weniger wiegen als 100
gewicht[which(gewicht > 50 & gewicht < 100)]

# Gewicht von Charakterren, die entweder weniger als 50 kg wiegen oder schwerer als 100 kg sind
gewicht[which(gewicht < 50 | gewicht > 100)]

filtered_starwars = starwars %>% filter(gewicht == 79)


#Zusammenfassung: 
# c()              Vektor erstellen
# seq()            Zahlenfolge erstellen
# class()          Objektklasse anzeigen
# factor()         Variable in Faktor umwandeln
# data.frame()     Data Frame erstellen
# as.data.frame()  in Data Frame umwandeln
# 
# nrow()           Anzahl Zeilen
# ncol()           Anzahl Spalten
# dim()            Dimensionen
# head()           erste Zeilen
# summary()        Zusammenfassung
# table()          Häufigkeiten
# length()         Anzahl Elemente
# 
# which()          Positionen einer Bedingung
# filter()         Fälle nach Bedingung auswählen
# library()        Paket laden
# 
# sqrt()           Quadratwurzel
# 
# Operatoren
# +  -  *  /       Rechnen
# ^                Potenz
# :                Zahlenfolge
# $                Variable aus Data Frame
# [ , ]             Indizierung
# ==               gleich
# !=               ungleich
# >  <  >=  <=     Vergleiche
# &                UND
# |                ODER
# %>%              Pipe
# =                Zuweisung



