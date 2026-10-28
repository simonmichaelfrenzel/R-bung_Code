library(tidyverse)

head(starwars)
starwars$mass
mean(starwars$mass)
mean(starwars$mass, na.rm = T)


# Normalverteilung
IQ = rnorm(100, 100, 15)

# round!!!

# Daten simulieren bsp likert items
likert = sample(x = 1:5, size = 100, replace = TRUE)
table(likert)
Buchstabe = sample(x = c("a", "b", "c"), size = 100, replace = TRUE, prob = c(0.5,0.25,0.25))
table(Buchstabe)

# Wiederholen rep()
Gruppe = rep(c("Kontrollgruppe", "Interventionsgruppe"), each = 10)
Gruppe = rep(c("Kontrollgruppe", "Interventionsgruppe"), times = 10)

# Aufgabe: Simuliert folgenden Datensatz, der "df" heißen soll
# Setze einen Seed (123) für Reproduzierbarkeit
# N = 100
# Erste Variable: ID = ab 101 fortlaufend
# Zweite Variable: sex: 49% male, 49% female, 2% diverse
# Dritte Variable: age: normalverteilte variable, MW = 40, SD = 10, gerundet auf ganze zahlen
# vierte Variable: Item1 = Variable eines Likert-Fragebogens (Wertebereich 1 - 7), gleichverteilte Antworten
# fünfte variable: population = die ersten 50 "clinical", die zweiten 50 "non_clinical"

# schaue dir mit head() die ersten 6 Zeilen des Datensatzes an

set.seed(123)
df = data.frame(ID = 101:200,
                sex = sample(x = c("male", "female", "diverse"), size = 100, replace = T, prob = c(.49, .49, .02)),
                age = round(rnorm(100, 40, 10),0),
                Item1 = sample(x = 1:5, size = 100, replace = T),
                population = rep(c("clinical", "non_clinical"), each = 50))

head(df)

saveRDS(df, file = "simulation.rds")
write.csv(df, file = "simulation.csv")

# install.packages("haven")
# install.packages("writexl")
library(haven)
library(writexl)

write_sav(df, "df.sav")

#test

df_neu = read.csv("simulation.csv")

# ersten richtigen df einlesen 

bipolar = read.csv("bipolar.csv")

View(bipolar)
anyNA(starwars)
summary(starwars$mass)







