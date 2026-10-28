library(tidyverse)

head(starwars)
starwars$mass
mean(starwars$mass)
mean(starwars$mass, na.rm = T)


# Normalverteilung
IQ = rnorm(100, 100, 15)

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

head(bipolar)
str(bipolar)
View(bipolar)
anyNA(bipolar)
summary(bipolar)

# alle YMRS Items checken, passt die range in den Daten? Plausibel?
# Aggregieren 

bipolar$YMRS_1 + bipolar$YMRS_2
rowSums(bipolar[,c("YMRS_1", "YMRS_2", "YMRS_2")])

library(dplyr)
?select
select(bipolar, starts_with("YMRS"))
rowSums(select(bipolar, starts_with("YMRS")))
rowMeans(select(bipolar, starts_with("YMRS")))

bipolar$sum_YMRS = rowSums(select(bipolar, starts_with("YMRS")))
head(bipolar)
summary(bipolar$sum_YMRS)

# Warum sum_YMRS?
bipolar$YMRS_sum = rowSums(select(bipolar, starts_with("YMRS")))

sum(is.na(bipolar$sum_YMRS))

table(bipolar$groups)
# "EW": Intervention erhalten, "noEW": Intervention nicht erhalten

# Werte einer Gruppe auswählen: logische Indizierung aus Einheit 1
bipolar$sum_YMRS[bipolar$groups == "noEW"]
bipolar$sum_YMRS[bipolar$groups == "EW"]

mean(bipolar$sum_YMRS[bipolar$groups == "noEW"])
mean(bipolar$sum_YMRS[bipolar$groups == "EW"])

ymrs_EG = bipolar$sum_YMRS[bipolar$groups == "EW"]
ymrs_KG = bipolar$sum_YMRS[bipolar$groups == "noEW"]

length(ymrs_EG)
length(ymrs_KG)
table(bipolar$groups)

mean(bipolar$sum_YMRS)
round(mean(bipolar$sum_YMRS), 2)
sd(bipolar$sum_YMRS)
var(bipolar$sum_YMRS) # / n-1


# Modalwert
library(modeest)
mfv(ymrs_EG)

#Kontrolle
table(ymrs_EG)
range(ymrs_EG)


# Base R: tapply(Variable, Gruppierung, Funktion)
tapply(bipolar$sum_YMRS, bipolar$groups, mean)
tapply(bipolar$sum_YMRS, bipolar$groups, sd)

# tidyverse: group_by() + summarise() erzeugt eine übersichtliche Tabelle
# (Pipe %>% lesen als "und dann"):
bipolar %>%
  group_by(groups) %>%
  summarise(n       = n(),
            M       = mean(sum_YMRS, na.rm = TRUE),
            SD      = sd(sum_YMRS, na.rm = TRUE),
            Median  = median(sum_YMRS, na.rm = TRUE),
            IQR     = IQR(sum_YMRS, na.rm = TRUE),
            Min     = min(sum_YMRS, na.rm = TRUE),
            Max     = max(sum_YMRS, na.rm = TRUE))



