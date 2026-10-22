Studiengang = c("Psychologie", "Mathematik", "Biologie", "Psychologie", "Psychologie","Biologie" )
levels(Studiengang)
Studiengang = factor(Studiengang, levels = c("Psychologie", "Mathematik", "Biologie" ))

Geschlecht = c(1, 2, 1, 3, 2, 1, 2, 1)
mean(Geschlecht)
Geschlecht = factor(Geschlecht, levels = c(1, 2, 3), labels = c("männlich", "weiblich", "divers"))
table(Geschlecht)

Schulabschluss = c("Hauptschule", "Abitur", "Realschule", "Abitur", "Realschule", "Hauptschule")
Schulabschluss = factor(Schulabschluss, levels = c("Hauptschule", "Realschule", "Abitur"), ordered = TRUE)
Schulabschluss > "Hauptschule"
Schulabschluss[Schulabschluss > "Hauptschule"]

df = data.frame(Studiencode = 100:105,
                Diagnose = c("Depression", "Angststörung", "Depression", "Angststörung", "Bipolar", "Depression"),
                Klinik = c("LMU", "LMU", "LMU", "MPI", "MPI", "MPI"),
                BDI = rnorm(6, mean = 25, sd = 7), 
                Alter = c(22, 34, 54, 19, 84, 23))
df
str(df)
ncol(df)
nrow(df)
names(df)
View(df)
df$Alter
df$Diagnose = factor(df$Diagnose)

#Aufgabe Wandle Klinik in einen Faktor um, dabei soll "MPI" die erste Stufe (nicht geordnet)

df$Geschlecht = factor(c(1,2,1,2,3,1), levels = c(1,2,3), labels = c("männlich", "weiblich", "divers"))

df[3,]
df[3:5,]
df[1:3, "Klinik"]
df[,c("Diagnose", "Klinik")]

#Aufgabe: Welche Diagnose hat die 3. Person? - es gibt (mindestens) zwei Optionen
df[3, "Diagnose"]
df[3, 2]

df$Klinik[3] = "MPI"
df[3, "Klinik"] = "LMU"

# 7 | LOGISCHE OPERATOREN UND FILTERN ------------------------------------------

# Statt über Positionen können wir Werte nach einer BEDINGUNG auswählen.
#   ==  gleich           !=  ungleich
#   >   größer           <   kleiner
#   >=  größer gleich    <=  kleiner gleich
#   &   UND (beide Bedingungen müssen stimmen)
#   |   ODER (mindestens eine Bedingung muss stimmen)

df$Alter > 30
df[df$Alter > 30,]
df[df$Alter != 34,]
bereinigt = df[df$Alter < 80, ]
bereinigt
df[df$Alter > 30 & df$Klinik == "LMU",]
LMU = df[df$Klinik == "LMU",]
LMU
MPI = df[df$Klinik == "MPI",]
MPI

# Aufgabe: Alle Frauen, die 30 oder älter sind und speichere sie in das Objekt Frauen_ü30
Frauen_ü30 = df[df$Geschlecht == "weiblich" & df$Alter >= 30,]
Frauen_ü30

# tidyverse Package
install.packages("tidyverse")
library(tidyverse)

starwars

# Aufgabe erstelle einen neuen datensatz starwars, der nur die ersten 11 Spalten von starwars enthält
starwars = starwars[,1:11]

str(starwars)
View(starwars)
head(starwars)
summary(starwars)
summary(starwars$mass)

mean(starwars$mass)
mean(starwars$mass, na.rm = T) #NA remove

starwars[starwars$mass == 79,] # NAs werden mit angezeigt, weil sie weder TRUE noch FALSE sind
starwars[which(starwars$mass == 79),]

# Filter aus dplyr (in tidyverse enthalten)
filter(starwars, mass == 79)
filter(starwars, height < 100)

# Pipe Operator
starwars %>% filter(mass < 80)
starwars %>% filter(mass < 80, eye_color == "blue")

# Daten simulieren bsp likert items
likert = sample(x = 1:5, size = 100, replace = TRUE)

# Wiederholen rep()

Gruppe = rep(c("Kontrollgruppe", "Interventionsgruppe"), each = 10)
Gruppe = rep(c("Kontrollgruppe", "Interventionsgruppe"), times = 10)








