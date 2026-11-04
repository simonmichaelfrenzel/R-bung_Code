

df = data.frame(ID = 1:10,
                age = rnorm(10, 22, 8),
                likert = sample(x = c(1:4, NA), size = 10, replace = T),
                group = rep(c("IG", "KG"), each = 5))

df$likert
mean(df$likert, na.rm = T)

saveRDS(df, file = "daten.rds")
write.csv(df, file = "daten.csv")
df_neu = read.csv("daten.csv")
df_rds = readRDS("daten.rds")

haven::read_sav()
haven::write_sav()


# install.packages("haven")
# install.packages("readxl")

df_neu = read.csv("daten.csv")
df_rds = readRDS("daten.rds")

df_neu = df_neu[,-1]



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

library(tidyverse)

?select
select(bipolar, starts_with("YMRS"))
rowSums(select(bipolar, starts_with("YMRS")))
rowMeans(select(bipolar, starts_with("YMRS")))

# Frage, wenn wir neue Variable erstellen wollen, die die Summe enthält? 

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

library(psych)
describe(bipolar)
describeBy(bipolar, group = bipolar$group)


# ZIEL: Berechnung eines Summenscores 
# ACHTUNG: Items 1, 2, 7, 8, 11, 12 müssen UMGEPOLT werden
# Funktion "recode()"

# Variante 1: Umgepolte Items werden als eigene Variable gekennzeichnet (Endung "_r", Primärdaten werden beibehalten)
bipolar$ISEL_1_r = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_2_r = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_7_r = recode(bipolar$ISEL_7, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_8_r = recode(bipolar$ISEL_8, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_11_r = recode(bipolar$ISEL_11, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_12_r = recode(bipolar$ISEL_12, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

# Variante 2: Umgepolte Items werden überschrieben
# Einfacher, um später Summenscore zu bilden: Logik "starts_with("ISEL" kann beibehalten werden
bipolar$ISEL_1 = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_2 = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_7 = recode(bipolar$ISEL_7, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_8 = recode(bipolar$ISEL_8, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_11 = recode(bipolar$ISEL_11, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_12 = recode(bipolar$ISEL_12, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

# Variante 3 Mathematisch
bipolar$ISEL_1 = 5 - bipolar$ISEL_1
bipolar$ISEL_2 = 5 - bipolar$ISEL_2
bipolar$ISEL_7 = 5 - bipolar$ISEL_7
bipolar$ISEL_8 = 5 - bipolar$ISEL_8
bipolar$ISEL_11 = 5 - bipolar$ISEL_11
bipolar$ISEL_12 = 5 - bipolar$ISEL_12


bipolar$sum_ISEL = rowMeans(select(bipolar, starts_with("ISEL")))

summary(bipolar$sum_ISEL)
describe(bipolar$sum_ISEL)
describeBy(bipolar$sum_ISEL, group = bipolar$groups)





library(report)
vars = bipolar[, c("Age", "Gender", "Employed", "Comorbidities", "Previous_Ep", "Education_years", "Onset_age", "sum_YMRS", "groups")]
table1 = report_sample(vars, by = "groups")

table1$Variable[2] = "Geschlecht_m"

library(flextable)
flextable(table1)

library(apaTables)



# t-test

shapiro.test(bipolar$YMRS_sum[bipolar$groups == "noEW"])
shapiro.test(bipolar$YMRS_sum[bipolar$groups == "EW"])
by(bipolar$sum_YMRS, bipolar$groups, shapiro.test)

qqnorm(bipolar$YMRS_sum[bipolar$groups == "EW"])
qqline(bipolar$YMRS_sum[bipolar$groups == "EW"])

hist(bipolar$YMRS_sum[bipolar$groups == "EW"])

library(car)
leveneTest(sum_YMRS ~ groups, data = bipolar, center ="mean") #mean = normale levene test, median ist etwas robuster

t.test(sum_YMRS ~ groups, data = bipolar)






