# Abfrage und Festlegung Arbeitsverzeichnis (engl. Working Directory)

getwd() # Abfrage des aktuellen Arbeitsverzeichnisses

# ACHTUNG: WD ist aufgrund der Ordnerstruktur des verwendeten Geräts PERSONENSPEZIFISCH
# Manuelle Auswahl des Arbeitsverzeichnisses
# "Session", "Set Working Directory", "Choose Directory .." + Auswahl eines präferierten Ordners 
# Kopieren Sie nun die in der Konsole angezeigte Funktion inkl. Pfadnamen in RStudio

setwd("/Users/studierende/Desktop/Gruppe C")
getwd() # Überprüfung der "setwd()" Funktion

# ACHTUNG: WD muss bei jeder neuen R-Sitzung gesetzt werden


# 1. Einheit ---------------------------------------------------------------

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


# 2. Einheit --------------------------------------------------------------

# Data.Frame aus letzter Einheit
df = data.frame(Name = c("Max", "Maja", "Mia", "Moritz", "Markus"),
                Alter = c(20, 31, 25, 34, 51),
                Diagnose = c("Depression", "Zwangsstörung", "Depression", "Soziale Phobie", "Depression"))

# ZIEL: Data.Frame speichern

# HIER WICHTIG: WORKING DIRECTORY (siehe Anfang dieses RSkripts!)


# "df" als csv-Datei speichern
write.csv(df, file = "df.csv") # Datei erscheint nach Ausführen dieser Zeile im WD

# ARBEIT MIT (EXTERNEM) DATENSATZ
# Datensatz "Bipolar.csv" (Verfügbar auf studynet)
# Speichern Sie den Datensatz bitte in Ihrem Working Directory ab. Anschließend können Sie den Datensatz importieren:
bipolar = read.csv(file = "Bipolar.csv", header = TRUE)

# MANUELLES ANWÄHLEN: "Files" (rechts unteres RStudio-Fenster:, Klick auf Datensatz, "Import Dataset..", Code kopieren und in Sourve einfügen oder "Import" drücken)


# Erste Übersicht über den Datensatz
head(bipolar) # Erste sechs Zeilen des Datensatzes
head(bipolar, 20) # Erste 20 Zeilen des Datensatzes

str(bipolar) # "Structure": Übersicht Variablen
dim(bipolar) # Anzahl Zeilen (Fälle) und Spalten (Variablen)
names(bipolar) # Anzeige der Variablen


# Auswertung: Young Mania Rating Scale (YMRS)
# ZIEL: Berechnung eines Summenscores (YMRS als Screening-Instrument)
bipolar$YMRS_1 # Anwählen des 1. Items des YMRS
bipolar$YMRS_2 # Anwählen des 2. Items des YMRS

bipolar$YMRS_1 + bipolar$YMRS_2 # Addition der Variablen
# Einzelnes Auswählen sehr zeitaufwändig, wir suchen nach Möglichkeit eines automatisierteren Vorgehens

rowSums(bipolar[, c("YMRS_1", "YMRS_2")]) # Auch hier: Variablennamen müssen einzeln eingegeben werden >> Zeitaufwand

# Möglichkeit, Variablen nach gewisser Logik auszuwählen: Funktion "select()" aus Paket "dplyr" (ist Teil des Pakets "tidyverse")
# install.packages("tidyverse")
library(tidyverse)

?select()
help(select)

select(bipolar, starts_with("YMRS"))
rowSums(select(bipolar, starts_with("YMRS")))

bipolar$YMRS_sum = rowSums(select(bipolar, starts_with("YMRS")))
names(bipolar)

# DESKRIPTIVE STATISTIK 
# Differenziert an Gruppenzuordnung

table(bipolar$groups)
# "EW": Intervention erhalten, "noEW": Intervention nicht erhalten

bipolar$YMRS_sum[bipolar$groups == "noEW"] # Indizierung: Personen, die keine Intervention erhalten haben
bipolar$YMRS_sum[bipolar$groups == "EW"] # Indizierung: Personen, die Intervention erhalten haben


# DESKRIPTIVE STATISTIK

# MAßE DER ZENTRALEN TENDENZ
# Mittelwert, Median, Modalwert

mean(bipolar$YMRS_sum[bipolar$groups == "noEW"])
mean(bipolar$YMRS_sum[bipolar$groups == "EW"])
round(mean(bipolar$YMRS_sum[bipolar$groups == "noEW"]), 2) # Runden auf zwei Nachkommastellen
round(mean(bipolar$YMRS_sum[bipolar$groups == "EW"]), 2) # Runden auf zwei Nachkommastellen


median(bipolar$YMRS_sum[bipolar$groups == "noEW"])
median(bipolar$YMRS_sum[bipolar$groups == "EW"])

# install.packages("modeest") # Paket "modeest" installieren
library(modeest) # Paket laden

# Funktion "mfv()" aus Paket "modeest" zur Berechnung des Modalwerts
mfv(bipolar$YMRS_sum[bipolar$groups == "noEW"]) 
mfv(bipolar$YMRS_sum[bipolar$groups == "EW"])


# STREUUNGSMASSE
# Varianz, Standardabweichung, Range, Quartilsabstand

var(bipolar$YMRS_sum[bipolar$groups == "noEW"])
var(bipolar$YMRS_sum[bipolar$groups == "EW"])

round(var(bipolar$YMRS_sum[bipolar$groups == "noEW"]), 2) # Runden auf zwei Nachkommastellen
round(var(bipolar$YMRS_sum[bipolar$groups == "EW"]), 2) # Runden auf zwei Nachkommastellen

# Standardabweichung ist Wurzel aus Varianz
sqrt(var(bipolar$YMRS_sum[bipolar$groups == "noEW"]))
sqrt(var(bipolar$YMRS_sum[bipolar$groups == "EW"]))

round(sqrt(var(bipolar$YMRS_sum[bipolar$groups == "noEW"])), 2) # Runden auf zwei Nachkommastellen
round(sqrt(var(bipolar$YMRS_sum[bipolar$groups == "EW"])), 2) # Runden auf zwei Nachkommastellen

# Eigene Funktion für Standardabweichung: "sd()"
sd(bipolar$YMRS_sum[bipolar$groups == "noEW"])
sd(bipolar$YMRS_sum[bipolar$groups == "EW"])

round(sd(bipolar$YMRS_sum[bipolar$groups == "noEW"]), 2) # Runden auf zwei Nachkommastellen
round(sd(bipolar$YMRS_sum[bipolar$groups == "EW"]), 2) # Runden auf zwei Nachkommastellen

# Funktion "IQR()" aus Paket "stats" zur Berechnung des Interquartilsabstands
# install.packages("stats")
library(stats)

IQR(bipolar$YMRS_sum[bipolar$groups == "noEW"])
IQR(bipolar$YMRS_sum[bipolar$groups == "EW"])

round(sd(bipolar$YMRS_sum[bipolar$groups == "noEW"]), 2) # Runden auf zwei Nachkommastellen
round(sd(bipolar$YMRS_sum[bipolar$groups == "EW"]), 2) # Runden auf zwei Nachkommastellen


# Auswertung: Interpersonal Support Evaluation List (ISEL)

# Hinweis: Bei Datensimulation scheint Fehler passiert zu sein
# Im Datensatz existieren Werte, die über die Möglichkeiten der Skala (von 1 bis 4) hinausgehen
bipolar$ISEL_1[bipolar$ISEL_1 > 4] = 4
bipolar$ISEL_2[bipolar$ISEL_2 > 4] = 4
bipolar$ISEL_3[bipolar$ISEL_3 > 4] = 4
bipolar$ISEL_4[bipolar$ISEL_4 > 4] = 4
bipolar$ISEL_5[bipolar$ISEL_5 > 4] = 4
bipolar$ISEL_6[bipolar$ISEL_6 > 4] = 4
bipolar$ISEL_7[bipolar$ISEL_7 > 4] = 4
bipolar$ISEL_8[bipolar$ISEL_8 > 4] = 4
bipolar$ISEL_9[bipolar$ISEL_9 > 4] = 4
bipolar$ISEL_10[bipolar$ISEL_10 > 4] = 4
bipolar$ISEL_11[bipolar$ISEL_11 > 4] = 4
bipolar$ISEL_12[bipolar$ISEL_12 > 4] = 4

# ZIEL: Berechnung eines Summenscores 
# ACHTUNG: Items 1, 2, 7, 8, 11, 12 müssen UMGEPOLT werden
# Funktion "recode()"

# Variante 1: Umgepolte Items werden als eigene Variable gekennzeichnet (Endung "_r", Primärdaten werden beibehalten)
# bipolar$ISEL_1_r = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# bipolar$ISEL_2_r = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# bipolar$ISEL_7_r = recode(bipolar$ISEL_7, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# bipolar$ISEL_8_r = recode(bipolar$ISEL_8, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# bipolar$ISEL_11_r = recode(bipolar$ISEL_11, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# bipolar$ISEL_12_r = recode(bipolar$ISEL_12, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

# Variante 2: Umgepolte Items werden überschrieben
# Einfacher, um später Summenscore zu bilden: Logik "starts_with("ISEL" kann beibehalten werden
bipolar$ISEL_1 = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_2 = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_7 = recode(bipolar$ISEL_7, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_8 = recode(bipolar$ISEL_8, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_11 = recode(bipolar$ISEL_11, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_12 = recode(bipolar$ISEL_12, "1" = 4, "2" = 3, "3" = 2, "4" = 1)


# 3. Einheit --------------------------------------------------------------

bipolar$ISEL_sum = rowSums(select(bipolar, starts_with("ISEL")))

# Alternative bei Wahl der erste Variante (siehe Code-Zeile 280-286)
# bipolar$ISEL_sum_r = rowSums(bipolar[, c("ISEL_1_r", "ISEL_2_r", "ISEL_7_r", "ISEL_8_r", "ISEL_11_r", "ISEL_12_r", "ISEL_3", "ISEL_4", "ISEL_5", "ISEL_6", "ISEL_9", "ISEL_10")])


# DATENVISUALISIERUNG

# install.packages("ggplot")
library(ggplot2)

jpeg(file = "Bipolar_Streudiagramm.jpg", width = 5, height = 5, units = "in", res = 300)

ggplot(data = bipolar, aes(x = ISEL_sum, y = YMRS_sum, colour = groups)) +
  geom_point(size = 1.0) +
  geom_smooth(aes(group = groups), method = "lm", color = "black", size = 0.5) + 
  labs(x = "Sozialer Support", y = "Symptomschwere Manie", colour = "Gruppen") +
  scale_colour_manual(values = c("#c51b7d", "#4d9221"), labels = c("Intervention", "Keine Intervention")) +  
  theme_bw()

dev.off()

jpeg(file = "Bipolar_Streudiagramm_2.jpg", width = 5, height = 5, units = "in", res = 300)

ggplot(data = bipolar, aes(x = ISEL_sum, y = YMRS_sum, shape = groups)) + 
  geom_point(size = 1.0) +
  geom_smooth(aes(group = groups), method = "lm", color = "black", size = 0.5) + 
  labs(x = "Sozialer Support", y = "Symptomschwere Manie", shape = "Gruppen") +
  scale_shape_manual(values = c(1, 2), labels = c("Intervention", "Keine Intervention")) +
  theme_bw() +
  theme(
    legend.position = "bottom", # LEGENDE UNTER PLOT SETZEN
    legend.box = "horizontal", # ANORDNUNG LEGENDE 
    panel.grid.major = element_blank(), # ENTFERNE GITTERNETZ
    panel.grid.minor = element_blank(), # ENTFERNE GITTERNETZ
    panel.border = element_blank(), # ENTFERNE PANEL GRENZEN
    axis.line = element_line(), # ZEIGE NUR DIE ACHSENLINIEN
    axis.title.x = element_text(face = "bold"), # X-ACHSE BESCHRIFTUNG BOLD
    axis.title.y = element_text(face = "bold") # Y-ACHSE BESCHRIFTUNG BOLD
  ) + 
  guides(shape = guide_legend(title.position = "top", title.hjust = 0.5)) # LEGENDE TITEL ÜBER LEGENDE


dev.off()


####


therapy4groups = read.csv("https://raw.githubusercontent.com/stephangoerigk/WAF_Folien/master/therapy4groups.csv")

names(therapy4groups)
table(therapy4groups$Therapy)
table(therapy4groups$Diagnosis)

View(therapy4groups)

png("Therapy4Groups_Streudiagramm.png", width = 6, height = 3, units = "in", res = 300)

ggplot(data = therapy4groups, aes(x = Behandlungsversuche, y = Symptoms)) +
  geom_point(size = 2, alpha = 0.4, color = "#555555") +  
  geom_smooth(method = "lm", color = "#473C8B", fill = "#E6E6FA", se = TRUE, size = 0.5) +  
  facet_grid(. ~ Diagnosis) +  # DIFFERENZIERTE BETRACHTUNG DER DIAGNOSEN
  labs(
    x = "Anzahl Behandlungsversuche",
    y = "Symptomschwere",
    title = "Streudiagramm") +
  theme_bw() +  
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 11),  # TITEL ZENTRIERT UND BOLD
    panel.grid.major = element_blank(), # ENTFERNE GITTERNETZ
    panel.grid.minor = element_blank(), # ENTFERNE GITTERNETZ
    strip.background = element_blank(), # ENTFERNE FACETTENHINTERGRUND
    strip.text.x = element_text(face = "bold", size = 11),  
    axis.title.x = element_text(face = "bold", size = 11), # X-ACHSE BESCHRIFTUNG BOLD
    axis.title.y = element_text(face = "bold", size = 11), # Y-ACHSE BESCHRIFTUNG BOLD
    legend.position = "bottom"  
  )

dev.off()


# barplot = ggplot(data = therapy4groups, aes(y = Symptoms, x = Therapy, fill = Diagnosis)) +
#  stat_summary(fun = "mean", geom = "bar", position = position_dodge())

barplot = ggplot(data = therapy4groups, aes(x = Therapy, y = Symptoms, fill = Diagnosis)) +
  stat_summary(fun = "mean", geom = "bar", position = position_dodge(), color = "black", width = 0.5) +
  labs(
    x = "Therapy",
    y = "Symptoms"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.background = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(face = "bold", size = 11),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.title = element_text(face = "bold", size = 11, hjust = 0.5),
    legend.text = element_text(size = 11, hjust = 0.5)
  ) +
  guides(fill = guide_legend(title = "Diagnosis", title.position = "top")) +
  scale_fill_manual(values = c("#F7F7F7", "#c51b7d"), labels = c("Anxiety", "Depression"))  

# boxplot = ggplot(data = therapy4groups, aes(y = Symptoms, x = Therapy, fill = Diagnosis)) +
#   geom_boxplot()

boxplot = ggplot(data = therapy4groups, aes(y = Symptoms, x = Therapy, fill = Diagnosis)) +
  geom_boxplot(outlier.colour = "black", outlier.shape = 16, outlier.size = 2) +
  labs(
    x = "Therapy",
    y = "Symptoms"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.background = element_blank(),
    axis.title.x = element_text(face = "bold", size = 11),
    axis.title.y = element_text(face = "bold", size = 11),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.title = element_text(face = "bold", size = 11, hjust = 0.5),
    legend.text = element_text(size = 11, hjust = 0.5)
  ) +
  guides(fill = guide_legend(title = "Diagnosis", title.position = "top")) +
  scale_fill_manual(values = c("#F7F7F7", "#c51b7d"), labels = c("Anxiety", "Depression"))  


# install.packages("ggpubr")
library(ggpubr)

jpeg("Barplot_Boxplot.jpeg", width = 4, height = 5, units = "in", res = 300)

ggarrange(barplot, boxplot, ncol = 1, nrow = 2, common.legend = TRUE, legend = "bottom")

dev.off()

# https://bjoernwalther.com/farben-in-r-der-col-befehl/#google_vignette
# https://colorbrewer2.org/#type=diverging&scheme=PRGn&n=11


# 4. Einheit --------------------------------------------------------------

# HYPOTHESENTESTS, SIGNIFIKANZTESTS

# Mögliche Fragestellung: Gibt es einen Zusammenhang zwischen den Behandlungsversuchen und den Restsymptomen bei Personen mit Depression oder Angststörung?
# KORRELATION
names(therapy4groups)
ggplot(data = therapy4groups, aes(x = Symptoms, y = Behandlungsversuche)) +
  geom_point() +
  geom_smooth(method = "lm")

help(cor)
?cor()

round(cor(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche), 2)
cor.test(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche, method = "pearson")

# cor.test(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche, method = "kendall")
# cor.test(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche, method = "spearman")

# ZUSATZARGUMENT "method = pearson vs. kendall vs. spearman"
# ZUSATZARGUMENT "alternative = two.sided vs. greater vs. less


# Mögliche Fragestellung: Unterscheiden sich Personen mit der Diagnose einer Depression in der Symptomschwere von Personen mit der Diagnose einer Angststörung?
# T-TEST

mean(therapy4groups$Symptoms[therapy4groups$Diagnosis == "Depression"])
mean(therapy4groups$Symptoms[therapy4groups$Diagnosis == "Angst"])

names(therapy4groups)
table(therapy4groups$Diagnosis)

t.test(Symptoms ~ Diagnosis, data = therapy4groups)
t.test(Symptoms ~ Diagnosis, data = therapy4groups, var.equal = TRUE)

# GERICHTET vs. UNGERICHTET
ttest = t.test(Symptoms ~ Diagnosis, data = therapy4groups, var.equal = TRUE, alternative = "two.sided")
ttest

# t.test(Symptoms ~ Diagnosis, data = therapy4groups, var.equal = TRUE, alternative = "less")
# t.test(Symptoms ~ Diagnosis, data = therapy4groups, var.equal = TRUE, alternative = "greater")

# ABHÄNGIG vs. UNABHÄNGIG
# t.test(Symptoms ~ Diagnosis, data = therapy4groups, paired = TRUE)

# t.test(x = therapy4groups$Symptoms[therapy4groups$Diagnosis == "Depression"],
#       y = therapy4groups$Symptoms[therapy4groups$Diagnosis == "Angst"],
#       paired = TRUE)


# Zugriff auf einzelne Objekte aus Signifikanztests 
str(ttest)
str(t.test(Symptoms ~ Diagnosis, data = therapy4groups, var.equal = TRUE, alternative = "two.sided"))
round(ttest$statistic, 2)

# Objekte mit mehr als zwei Einträge: Zugriff auf zweite Zahl
ttest$conf.int[2]


# 5. Einheit --------------------------------------------------------------

# install.packages("effsize")
library(effsize)

effsize::cohen.d(Symptoms ~ Diagnosis, data = therapy4groups)
# EINORDNUNG DER EFFEKTE WICHTIG
# z.B. nach Cohen (1992): ≥ .02 kleiner Effekt, ≥ .05 mittlerer Effekt, ≥ .08 großer Effekt

# Alternative zu Cohen's d: Hedges' g
# VORTEIL: Korrigiert statistisch für besonders kleine Gruppen (N < 20; Hedges & Olkin, 2014)
effsize::cohen.d(Symptoms ~ Diagnosis, data = therapy4groups, hedges.correction = TRUE)


# ERGEBNISDARSTELLUNG IN TABELLENFORM

# install.packages("report")
library(report)

ttest = t.test(Symptoms ~ Diagnosis, data = therapy4groups)
report(ttest)

tab = as.data.frame(report(ttest)) # Konvertieren in Data.Frame
names(tab)

# Paket flextable:: 
flextable::flextable(tab)


# Spalten LÖSCHEN
# install.packages("BBmisc")
library(BBmisc)

tab = BBmisc::dropNamed(tab, drop = c("Parameter", "Groups", "Difference", "df_error", "Method", "Alternative", "d_CI_low", "d_CI_high"))
flextable::flextable(tab) # Überprüfen der Anpassung


# Spalten VERÄNDERN (z.B. KOMBINIEREN)
tab$ConfidenceInterval = paste0(tab$CI, " (", round(tab$CI_low, 2), " to ", round(tab$CI_high, 2), ")")
flextable::flextable(tab) # Überprüfen der Anpassung


# Spalten HINZUFÜGEN
tab = add_column(tab, Model = "Model 1", .before = 1)
flextable::flextable(tab) # Überprüfen der Anpassung

help(add_column)
tab = BBmisc::dropNamed(tab, drop = c("CI", "CI_low", "CI_high"))
flextable::flextable(tab) # Überprüfen der Anpassung


# Zeilen HINZUFÜGEN
tab = rbind(tab, tab, tab)
flextable::flextable(tab) # Überprüfen der Anpassung


# NAMEN dfer Spalten VERÄNDERN
names(tab)[3:4] = c("M Symptomausprägung Diagnose Angst", "M Symptomausprägung Diagnose Depression")
flextable::flextable(tab) # Überprüfen der Anpassung


# Achtung: Mittelwert(e) IMMER MIT Standardabweichung(en) angeben!
sd_sympt_angst = round(sd(therapy4groups$Symptoms[therapy4groups$Diagnosis == "Angst"]), 2)
sd_sympt_depression = round(sd(therapy4groups$Symptoms[therapy4groups$Diagnosis == "Depression"]), 2)

tab = add_column(tab, "SD Symptomausprägung Diagnose Angst" = sd_sympt_angst, .before = 4)
tab = add_column(tab, "SD Symptomausprägung Diagnose Depression" = sd_sympt_depression, .before = 6)
flextable::flextable(tab) # Überprüfen der Anpassung

# siehe Cheatsheet Flextable
# https://ardata-fr.github.io/flextable-book/static/pdf/cheat_sheet_flextable.pdf


# ANOVA, Varianzanalyse
# EINFAKTORIELLE vs. MEHRFAKTORIELLE ANOVA

# EINFAKTORIELLE ANOVA
# Möglicher Anwendungsfall: Vergleich der Symptomausprägungen, die Pat. nach einer Therapie haben
# Mögliche Fragestellung: Nach welcher Therapieh weisen die Pat. die geringste Symptomausprägung auf?

# ANOVA in R: ZWEI Schritte
mod = lm(Symptoms ~ Therapy, data = therapy4groups) # 1. Definition des grundlegenden linearen Modells
anova(mod) # 2. Anwendung der ANOVA auf das Modell

# ALTERNATIVE: aov_ez-Funktion aus dem "afex" Paket
# install.packages("afex")
library(afex)

aov_ez(dv = "Symptoms", between = c("Therapy"), id = "ID", data = therapy4groups)
# Lediglich eine Zeile Code; Definition des linearen Modells wird übersprungen

# Bei aov_ez-Funktion: EINDEUTIGE ID jeder Zeile notwendig
# Falls nicht vorhanden, kann diese wie folgt erstellt werden:
therapy4groups$id = rownames(therapy4groups)
therapy4groups$id = NULL # Spalte kann wieder gelöscht werden, ID-Spalte in aktuellem Beispiel bereits vorhanden


# POST-HOC Testverfahren
# install.packages("emmeans")
library(emmeans)

emmeans(mod, pairwise ~ Therapy)

# KORREKTUR FÜR MULTIPLES TESTEN (Stichwort ALPHA-FEHLER KUMULIERUNG)
# BONFERRONI KORREKTUR
emmeans(mod, pairwise ~ Therapy, adjust = "bonferroni")

# Eine (von vielen möglichen) Alternative(n): BENJAMINI-HOCHBERG KORREKTUR
# Anpassungen sind weniger streng
emmeans(mod, pairwise ~ Therapy, adjust = "fdr")


# ZWEIFAKTORIELLE ANOVA
# Mögliche Fragestellung: Gibt es, je nachdem, welche Diagnose ein Pat. hat, Unterschiede in der Wirksamkeit der Therapie?

mod2 = lm(Symptoms ~ Therapy * Diagnosis, data = therapy4groups)
anova(mod2)

aov_ez(dv = "Symptoms", between = c("Therapy", "Diagnosis"), id = "ID", data = therapy4groups) # Alternative

# NUN: POST-HOC Testverfahren
emmeans(mod2, pairwise ~ Therapy|Diagnosis)


# 6. Einheit --------------------------------------------------------------

# EINFACHE LINEAREN REGRESSION
reg = lm(Symptoms ~ Behandlungsversuche, data = therapy4groups)
summary(reg)

options(scipen = 999)

# MULTIPLEN REGRESSION
# Ergänzung weiterer UVn mittels "+" im Modell

therapy4groups$std_Symptoms = scale(therapy4groups$Symptoms)
therapy4groups$std_Behandlungsversuche = scale(therapy4groups$Behandlungsversuche)

reg_std = lm(std_Symptoms ~ std_Behandlungsversuche, data = therapy4groups)
summary(reg_std)

cor(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche)

# MULTIPLE REGRESSION MIT INTERAKTION 
reg2 = lm(Symptoms ~ Behandlungsversuche * Diagnosis, data = therapy4groups)
summary(reg2)

# emtrends(reg2, pairwise ~ Diagnosis, var = "Behandlungsversuche")


# PRÜFUNG VON VORAUSSETZUNG

cor.test(therapy4groups$Symptoms, therapy4groups$Behandlungsversuche)

# NORMALVERTEILUNG
# install.packages("psych")
library(psych)

describe(therapy4groups$Symptoms) # Skewness und Kurtosis

shapiro.test(therapy4groups$Symptoms) # Shapiro-Wilk Test
# n.s. bedeutet: Normalverteilung ist gegeben bzw. "Variable weicht nicht signifikant von NV ab"

ks.test(therapy4groups$Symptoms, "pnorm", mean(therapy4groups$Symptoms), sd(therapy4groups$Symptoms)) # Kolmogorov-Smirnov Test
# n.s. bedeutet: Normalverteilung ist gegeben bzw. "Variable weicht nicht signifikant von NV ab"


# LINEARITÄT
ggplot(therapy4groups, aes(x = Symptoms, y = Behandlungsversuche)) +
  geom_point() +
  geom_smooth(method = "lm")


# VARIANZHOMOGENITÄT
# install.packages("car")
library(car)

t.test(Symptoms ~ Diagnosis, data = therapy4groups)
leveneTest(Symptoms ~ Diagnosis, data = therapy4groups)


# HOMOSKEDASTIZITÄT
# install.packages("lmtest")
library(lmtest)

reg = lm(Symptoms ~ Diagnosis, data = therapy4groups)
bptest(reg) # BREUSCH-PAGAN Test


# SPHÄRIZITÄT BEI MESSWIEDERHOLUNGEN
# check_sphericity(model)


# BEI REGRESSION UND ANOVA
install.packages("patchwork")
library(patchwork)

# install.packages("easystats")
library(easystats)

reg = lm(Symptoms ~ Diagnosis, data = therapy4groups)
check_model(reg)


# FALLWEISER AUSSCHLUSS AUF BASIS FEHLENDER WERTE
# dat = na.omit(dat)


# APA-TABLES

# install.packages("apaTables")
library(apaTables)

data("mtcars")
names(mtcars)

cor.variables = mtcars[, c("hp", "mpg", "wt")]
apa.cor.table(cor.variables)

cor_results = corr.test(cor.variables)
cor_results$p # Exact p Values

options(scipen = 999)