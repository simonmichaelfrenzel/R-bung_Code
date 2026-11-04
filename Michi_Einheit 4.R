### Sitzung 4 ###

# Wdh: letztes Mal: 
# 1. Daten simulieren  
# 2. Read and Write 
# 3. Bipolar Datensatz gruppenvariable bilden 

# Heute: deskriptive Daten ausgeben + T-test und Darstellung + Korrelation und Darstellung 

# Pakete 
install.packages("tidyverse") 
install.packages("psych")
install.packages("report")
install.packages("ggplot2")


library(tidyverse)
library(psych)
library(report)
library(ggplot2)

### Dekriptive Daten ###
# Nochmal einlesen & Gruppenvariable
bipolar = read.csv(file = "bipolar.csv")
bipolar$Sum_YMRS = rowSums(select(bipolar, starts_with("YMRS_")))

table(bipolar$groups) 

mean(bipolar$Sum_YMRS)
quantile(bipolar$Sum_YMRS)
var(bipolar$Sum_YMRS) ## /n-1 als Schäter für die wahre Varianz 
sd(bipolar$Sum_YMRS)

# Einfacher: describe() im "psych" Paket 
describe(bipolar)
describeBy(bipolar, group = "groups")
# Alternative: "report" paket
report_sample(bipolar, by = "groups") 


#### Neuer Fragebogen: ISEL ####
#Scoring:
#Items 1, 2, 7, 8, 11, 12 are reverse scored.
#Items 2, 4, 6, 11 make up the Appraisal Support subscale 
#Items 1, 5, 7, 9 make up the Belonging Support subscale 
#Items, 3, 8, 10, 12 make up the Tangible Support subscale.

sum(is.na(select(bipolar, starts_with("ISEl"))))
range(select(bipolar, starts_with("ISEl")))

# Inverse Items umkodieren
# Formel:  umgepolter Wert = (Minimum + Maximum) - alter Wert
# Für eine Skala von 1 bis 4:  (1 + 4) - x = 5 - x
#
#   alter Wert:   1   2   3   4
#   5 - x:        4   3   2   1    -> genau die gewünschte Umpolung

bipolar$ISEL_1_r  = 5 - bipolar$ISEL_1
bipolar$ISEL_2_r  = 5 - bipolar$ISEL_2
bipolar$ISEL_7_r  = 5 - bipolar$ISEL_7
bipolar$ISEL_8_r  = 5 - bipolar$ISEL_8
bipolar$ISEL_11_r = 5 - bipolar$ISEL_11
bipolar$ISEL_12_r = 5 - bipolar$ISEL_12

# KONTROLLE: Kreuztabelle aus Original und umgepoltem Item.
# Es dürfen nur Einträge auf der "Gegendiagonale" stehen (1-4, 2-3, 3-2, 4-1).
# Diese Kontrolle sollte man sich bei jedem Umpolen angewöhnen!
table(bipolar$ISEL_1, bipolar$ISEL_1_r)

# Weiterer Wege: recod() aus dplyr
bipolar$ISEL_1_r = dplyr::recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# mehrere recode-Funktion je nach Paket 


### Test und induktive Statistik ###
# Frage: Unterschieden sich die beiden Gruppen in ihrem YMRS Score?

?t.test()
t.test(bipolar$Sum_YMRS ~ bipolar$groups)

str(bipolar)
t.test(bipolar$Sum_YMRS ~ bipolar$groups, var.equal = F,  alternative = "less") 
# wenn, char-var --> alphabetische reihenfolge: EW < noEW
# standard bei var.equal = F --> dh Welch-test, T --> Student-T-test
# car::leveneTest(Sum_YMRS ~ groups, data = bipolar)
# effsize::cohen.d(Sum_YMRS ~ groups, data = bipolar)

#t.test(bipolar$Sum_YMRS ~ bipolar$groups)$statistic -> t
#$parameter -> df
#$p.value -> pvalue

#Darstellung der Ergebnisse --> ggplot 

# Grammatik ggplot() => 
# data: Daten 
# asthetics : Achsen und Farben, Größe Form der Punkte
# geometry: Art der Grafik 

ggplot(data=bipolar) # leeres
ggplot(data=bipolar, aes(x = groups, y= Sum_YMRS)) # Achsen definieren

# Für unseren Datensatz: Histogram für die Zweigruppen
ggplot(data = bipolar, aes(x = groups, y= Sum_YMRS)) + 
    geom_boxplot() 

#Hintergrund: 
ggplot(data = bipolar, aes(x = groups, y= Sum_YMRS)) + 
  geom_boxplot(width = 0.4)  +  # Breite der Boxplots
  theme(panel.background = element_blank() ,#Hintergrund weiß
        panel.grid.major = element_line(color = "grey", linewidth = 0.3)) # Linien grau

#Titel & Legende
   + ggtitle("Abb 1: Boxplot für EG und KG")

#Farben und Punkte
  +  geom_jitter(width = 0.05, alpha = 0.3, size = 1) 
# width: seitliche Streuung
# alpha: transparent

# Farben: 
+ geom_boxplot(width = 0.4, alpha = 0.3, fill = "lightblue", color = "black")


### Korrelation & Streudiagramm
#Frage: Zsh YMRs mit ISEl 

# 1. Gruppenscore für ISEL berechnen 
bipolar$Sum_Isel = rowSums(select(bipolar, starts_with("ISEL_") & ends_with("r")))

#2. Correlation
?cor.test
cor.test(bipolar$Sum_Isel, bipolar$Sum_YMRS, method= "pearson")

#3. Streudiagramm mit ggplot 
ggplot(bipolar, aes(x = Sum_Isel, y=Sum_YMRS)) +
  geom_point(size = 0.8, alpha =0.7) + # Streudiagramm
  geom_smooth(method = "lm", color = "black", linewidth = 0.4, fullrange = TRUE) +# Linie zeichnen
  expand_limits(x = c(10, 27), y = c(10, 40)) + # Linie erweitern
  coord_cartesian(xlim = c(10, 27), ylim = c(10, 40)) #Skalen anpassen

# Nach Gruppen aufteilen 
#1 in aes()  --> color = groups
#2 in geemo_smooth "color entfernen 
# ausführen
#3  + scale_color_manual(values = c("steelblue", "orange"))


ggplot(bipolar, aes(x = Sum_Isel, y = Sum_YMRS, color = groups)) +
  geom_point(size = 0.8, alpha = 0.7) +                          # Streudiagramm
  geom_smooth(method = "lm", linewidth = 0.4, fullrange = TRUE) + # Linien pro Gruppe, ganzer Bereich
  expand_limits(x = c(10, 27), y = c(10, 40)) +                   # Skala erweitern
  coord_cartesian(xlim = c(10, 27), ylim = c(10, 40), expand = FALSE) +  # Ausschnitt, + nicht vergessen!
  scale_color_manual(values = c("steelblue", "orange"))


## Speichern einer Grafik

png(file = "Figure1.png", width = 15, height = 10, units = "cm", res = 300)

ggplot(bipolar, aes(x = Sum_Isel, y = Sum_YMRS, color = groups)) +
  geom_point(size = 0.8, alpha = 0.7) +                          # Streudiagramm
  geom_smooth(method = "lm", linewidth = 0.4, fullrange = TRUE) + # Linien pro Gruppe, ganzer Bereich
  expand_limits(x = c(10, 27), y = c(10, 40)) +                   # Skala erweitern
  coord_cartesian(xlim = c(10, 27), ylim = c(10, 40), expand = FALSE) +  # Ausschnitt, + nicht vergessen!
  scale_color_manual(values = c("steelblue", "orange"))


dev.off() # gibt an, dass Figur fertig und ready fürs Speichern durch png ist


