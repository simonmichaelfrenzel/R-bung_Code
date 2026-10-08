# =============================================================================
# 2. EINHEIT: DATEN SPEICHERN & IMPORTIEREN, SUMMENSCORES, DESKRIPTIVE STATISTIK,
#             DATENBEREINIGUNG UND UMPOLEN
# =============================================================================

# Pakete für diese Einheit laden.
# Tipp: Pakete IMMER am Anfang des Skripts laden. So sieht man auf einen Blick,
# was das Skript benötigt, und es läuft von oben nach unten ohne Fehler durch.
# install.packages("tidyverse")   # einmalig, falls noch nicht installiert
# install.packages("modeest")     # einmalig, falls noch nicht installiert
library(tidyverse)   # enthält u. a. dplyr (select, filter, ...) und ggplot2
library(modeest)     # für den Modalwert


# 1 | DATA FRAME SPEICHERN -----------------------------------------------------

# Data Frame aus der letzten Einheit
df = data.frame(Name = c("Max", "Maja", "Mia", "Moritz", "Markus"),
                Alter = c(20, 31, 25, 34, 51),
                Diagnose = c("Depression", "Zwangsstörung", "Depression",
                             "Soziale Phobie", "Depression"))

# WORKING DIRECTORY: der Ordner, in dem R Dateien sucht und speichert.
# Weil wir in einem R-Projekt arbeiten, ist das automatisch der Projektordner.
getwd()   # zeigt das aktuelle Working Directory

# Als CSV-Datei speichern. CSV = "comma separated values": eine einfache
# Textdatei, die jedes Programm (Excel, SPSS, R, ...) öffnen kann.
write.csv(df, file = "df.csv", row.names = FALSE)
# Die Datei erscheint jetzt rechts unten unter "Files".
#
# Warum row.names = FALSE? Sonst schreibt R die Zeilennummern (1, 2, 3, ...) als
# zusätzliche, namenlose erste Spalte in die Datei. Beim erneuten Einlesen
# taucht dann eine überflüssige Spalte "X" auf.

# Kontrolle: wieder einlesen
df_neu = read.csv("df.csv")
df_neu

# HINWEIS FÜR DEUTSCHES EXCEL: Excel erwartet bei deutscher Spracheinstellung
# ein Semikolon als Trennzeichen und ein Komma als Dezimalzeichen (3,5 statt 3.5).
# Dafür gibt es die Varianten mit "2":
# write.csv2(df, file = "df_excel.csv", row.names = FALSE)
# read.csv2("df_excel.csv")
# Faustregel: Steht nach dem Einlesen alles in EINER Spalte, wurde das falsche
# Trennzeichen verwendet. Dann einfach die andere Variante probieren.


# 2 | EXTERNEN DATENSATZ IMPORTIEREN -------------------------------------------

# Datensatz "Bipolar.csv" (verfügbar auf studynet).
# Speichern Sie ihn in Ihrem PROJEKTORDNER. Dann genügt der Dateiname:
bipolar = read.csv(file = "Bipolar.csv")
# header = TRUE (erste Zeile enthält die Variablennamen) ist die Voreinstellung
# und muss nicht angegeben werden.
# Typischer Fehler: "cannot open file 'Bipolar.csv': No such file or directory"
# -> Die Datei liegt nicht im Working Directory oder ist anders benannt
#    (Groß-/Kleinschreibung beachten!).

# ALTERNATIVE PER MAUS: rechts unten "Files" -> Klick auf die Datei ->
# "Import Dataset..." -> den angezeigten Code kopieren und ins Skript (Source) einfügen.
# Achtung: RStudio verwendet dafür read_csv() aus dem Paket readr (mit Unterstrich).
# Das Ergebnis ist ein "tibble", eine moderne Form des Data Frames.
# Es funktioniert genauso, sieht in der Konsole aber etwas anders aus.
# Den Code ins Skript kopieren ist wichtig, damit der Import beim nächsten Mal
# reproduzierbar ist.


# 3 | ERSTER ÜBERBLICK ---------------------------------------------------------

# Bevor wir rechnen, schauen wir uns IMMER zuerst die Daten an.
head(bipolar)       # erste 6 Zeilen
head(bipolar, 20)   # erste 20 Zeilen
dim(bipolar)        # Anzahl Zeilen (Personen) und Spalten (Variablen)
names(bipolar)      # alle Variablennamen
str(bipolar)        # Variablen und ihre Typen. Sind Zahlen auch wirklich numeric?
summary(bipolar)    # Min, Max, Mittelwert, NAs je Variable
# summary() ist die schnellste Plausibilitätsprüfung: Liegen Minimum und Maximum
# im möglichen Antwortbereich? (Darauf kommen wir bei der ISEL zurück.)


# 4 | SUMMENSCORE: Young Mania Rating Scale (YMRS) -----------------------------

# ZIEL: Für jede Person die Summe aller YMRS-Items berechnen (Screening-Instrument).

bipolar$YMRS_1   # 1. Item der YMRS
bipolar$YMRS_2   # 2. Item der YMRS

# Variante 1: Items einzeln addieren. Das funktioniert, ist bei vielen Items
# aber mühsam und fehleranfällig (ein Item vergessen oder doppelt erwischt).
bipolar$YMRS_1 + bipolar$YMRS_2

# Variante 2: rowSums() = Summe pro ZEILE (also pro Person)
rowSums(bipolar[, c("YMRS_1", "YMRS_2")])
# Besser, aber alle Variablennamen müssen immer noch einzeln getippt werden.

# Variante 3: Variablen nach einem MUSTER auswählen mit select() aus dplyr
?select       # Hilfe öffnen (ohne Klammern hinter dem Funktionsnamen)

select(bipolar, starts_with("YMRS"))             # alle Spalten, die mit "YMRS" beginnen
rowSums(select(bipolar, starts_with("YMRS")))    # und davon die Zeilensumme

# Summenscore als neue Variable speichern
bipolar$sum_YMRS = rowSums(select(bipolar, starts_with("YMRS")))

# WARUM "sum_YMRS" und nicht "YMRS_sum"?
# "YMRS_sum" würde selbst mit "YMRS" beginnen. Führt man die Zeile ein zweites Mal
# aus, würde starts_with("YMRS") die alte Summe mitzählen und der Score wäre plötzlich
# doppelt so hoch. Eine kleine Namenswahl verhindert hier einen schwer zu
# findenden Fehler. Allgemein gilt: Code so schreiben, dass mehrfaches Ausführen
# immer zum selben Ergebnis führt.

names(bipolar)
summary(bipolar$sum_YMRS)

# HINWEIS: Fehlt bei einer Person auch nur EIN Item (NA), ist ihre Summe ebenfalls NA.
# Das ist bei Summenscores meist gewünscht: Eine Summe aus weniger Items wäre
# mit den anderen nicht vergleichbar.
sum(is.na(bipolar$sum_YMRS))   # bei wie vielen Personen fehlt der Score?


# 5 | DESKRIPTIVE STATISTIK NACH GRUPPE ----------------------------------------

table(bipolar$groups)
# "EW": Intervention erhalten, "noEW": Intervention nicht erhalten

# Werte einer Gruppe auswählen: logische Indizierung aus Einheit 1
bipolar$sum_YMRS[bipolar$groups == "noEW"]
bipolar$sum_YMRS[bipolar$groups == "EW"]

# Diese langen Ausdrücke brauchen wir gleich sehr oft. Statt sie immer wieder zu
# tippen, speichern wir sie einmal als eigene Objekte. Das spart Tipparbeit und
# verhindert Tippfehler.
ymrs_noEW = bipolar$sum_YMRS[bipolar$groups == "noEW"]
ymrs_EW   = bipolar$sum_YMRS[bipolar$groups == "EW"]

length(ymrs_noEW)   # Gruppengrößen
length(ymrs_EW)

# Falls im Summenscore NAs vorkommen, bei allen Funktionen unten na.rm = TRUE ergänzen.


# 5.1 | Maße der zentralen Tendenz ---------------------------------------------

# MITTELWERT
mean(ymrs_noEW)
mean(ymrs_EW)
round(mean(ymrs_noEW), 2)   # auf zwei Nachkommastellen runden
round(mean(ymrs_EW), 2)

# MEDIAN: robuster gegenüber Ausreißern als der Mittelwert
median(ymrs_noEW)
median(ymrs_EW)

# MODALWERT: In R gibt es dafür keine eingebaute Funktion.
# Achtung: mode() gibt es zwar, es zeigt aber den Speichertyp an, nicht den Modalwert!
# Wir verwenden mfv() ("most frequent value") aus dem Paket modeest:
mfv(ymrs_noEW)
mfv(ymrs_EW)
# Gibt es mehrere gleich häufige Werte, gibt mfv() alle aus (multimodal).
# Zur Kontrolle sieht man den Modalwert auch in der Häufigkeitstabelle:
table(ymrs_noEW)


# 5.2 | Streuungsmaße -----------------------------------------------------------

# SPANNWEITE (Range)
min(ymrs_noEW); max(ymrs_noEW)
range(ymrs_noEW)         # Minimum und Maximum zusammen
diff(range(ymrs_noEW))   # Spannweite = Maximum - Minimum
diff(range(ymrs_EW))

# VARIANZ
var(ymrs_noEW)
var(ymrs_EW)
round(var(ymrs_noEW), 2)
round(var(ymrs_EW), 2)

# WICHTIG: var() und sd() teilen durch n - 1, nicht durch n!
# Das ist die Stichprobenschätzung der Populationsvarianz (aus der Statistikvorlesung).
# Zum Nachvollziehen von Hand:
sum((ymrs_noEW - mean(ymrs_noEW))^2) / (length(ymrs_noEW) - 1)   # = var(ymrs_noEW)

# STANDARDABWEICHUNG = Wurzel aus der Varianz
sqrt(var(ymrs_noEW))
sd(ymrs_noEW)        # eigene Funktion, gleiches Ergebnis
sd(ymrs_EW)
round(sd(ymrs_noEW), 2)
round(sd(ymrs_EW), 2)

# QUARTILE UND INTERQUARTILSABSTAND (IQR)
quantile(ymrs_noEW)   # 0 %, 25 %, 50 % (= Median), 75 %, 100 %
IQR(ymrs_noEW)        # IQR = 75 %-Quartil - 25 %-Quartil
IQR(ymrs_EW)
round(IQR(ymrs_noEW), 2)
round(IQR(ymrs_EW), 2)
# IQR(), var(), sd(), quantile() stammen aus dem Paket "stats". Dieses gehört zu R
# und ist immer schon geladen. Kein install.packages() oder library() nötig!


# 5.3 | Ausblick: alle Gruppen auf einmal ---------------------------------------

# Bisher haben wir jede Kennzahl für jede Gruppe einzeln berechnet. Das geht kürzer:

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


# 6 | Interpersonal Support Evaluation List (ISEL) -----------------------------

# ZIEL: Summenscore der ISEL (12 Items, Antwortskala von 1 bis 4).
# Davor: (1) Daten auf Plausibilität prüfen, (2) negativ formulierte Items umpolen.


# 6.1 | Plausibilitätsprüfung ---------------------------------------------------

# Liegen alle Antworten im möglichen Bereich von 1 bis 4?
summary(select(bipolar, starts_with("ISEL")))
table(bipolar$ISEL_1, useNA = "ifany")

# Ergebnis: Es gibt Werte über 4. Die Skala geht aber nur bis 4. Das sind also
# ungültige Werte (z. B. Eingabefehler). In echten Daten passiert das ständig.
#
# Was tun? Wir setzen ungültige Werte auf NA (fehlend).
# Warum nicht einfach auf 4? Weil wir den wahren Wert NICHT kennen. Eine 5 kann
# ein Tippfehler für 4 gewesen sein, aber genauso für 1 oder 2. Würden wir eine 4
# eintragen, erfinden wir Daten und verzerren Mittelwert und Streuung.
# Ehrlicher ist: "Dieser Wert ist unbekannt." -> NA

bipolar$ISEL_1[bipolar$ISEL_1 > 4] = NA
bipolar$ISEL_2[bipolar$ISEL_2 > 4] = NA
bipolar$ISEL_3[bipolar$ISEL_3 > 4] = NA
bipolar$ISEL_4[bipolar$ISEL_4 > 4] = NA
bipolar$ISEL_5[bipolar$ISEL_5 > 4] = NA
bipolar$ISEL_6[bipolar$ISEL_6 > 4] = NA
bipolar$ISEL_7[bipolar$ISEL_7 > 4] = NA
bipolar$ISEL_8[bipolar$ISEL_8 > 4] = NA
bipolar$ISEL_9[bipolar$ISEL_9 > 4] = NA
bipolar$ISEL_10[bipolar$ISEL_10 > 4] = NA
bipolar$ISEL_11[bipolar$ISEL_11 > 4] = NA
bipolar$ISEL_12[bipolar$ISEL_12 > 4] = NA
# Lesen Sie eine Zeile so: "Nimm ISEL_1, und zwar nur dort, wo ISEL_1 größer als 4 ist,
# und setze diese Werte auf NA."

# Kontrolle: Jetzt dürfen Maximalwerte höchstens 4 sein
summary(select(bipolar, starts_with("ISEL")))

# PROFI-TIPP (optional): Dasselbe in einer einzigen Anweisung für alle 12 Items.
# across() wendet eine Funktion auf mehrere Spalten an. ifelse(Bedingung, dann, sonst):
# bipolar = bipolar %>%
#   mutate(across(starts_with("ISEL"), ~ ifelse(.x > 4, NA, .x)))


# 6.2 | Items umpolen (Rekodieren) ---------------------------------------------

# Die ISEL enthält positiv und negativ formulierte Items. Bei den Items
# 1, 2, 7, 8, 11 und 12 bedeutet ein HOHER Wert WENIG soziale Unterstützung.
# Damit alle Items in dieselbe Richtung zeigen ("hoch = viel Unterstützung"),
# müssen diese Items UMGEPOLT werden: 1 -> 4, 2 -> 3, 3 -> 2, 4 -> 1.
#
# GRUNDREGEL: Umgepolte Items speichern wir als NEUE Variable mit der Endung "_r"
# (für "reversed"). Die Originalvariable bleibt unverändert. Warum?
#   1) Rohdaten bleiben erhalten, man kann jederzeit nachprüfen.
#   2) Überschreibt man die Originalvariable und führt die Zeile versehentlich
#      ZWEIMAL aus, wird das Item wieder zurückgepolt: 1 -> 4 -> 1.
#      Das sieht man nirgends und der Summenscore ist falsch.
#      Mit einer neuen Variable passiert das nicht: Sie wird bei jedem Ausführen
#      wieder aus dem unveränderten Original berechnet.


# VARIANTE A: Umpolen mit recode() aus dplyr --------------------------------
# Jeder alte Wert wird einzeln einem neuen Wert zugeordnet: "alt" = neu
bipolar$ISEL_1_r = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_2_r = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
# ... usw. für Item 7, 8, 11 und 12
#
# Vorteil: sehr anschaulich, man sieht jede Zuordnung.
# Nachteile:
#   - Viel Tipparbeit: 4 Zuordnungen x 6 Items = 24 Stellen, an denen man sich
#     vertippen kann (z. B. "2" = 2 statt "2" = 3). Das fällt nicht auf!
#   - Bei einer 7-stufigen Skala wären es schon 7 Zuordnungen pro Item.
#   - Die alten Werte stehen in Anführungszeichen, obwohl es Zahlen sind.
#     Das verwirrt Anfänger*innen.
#   - Es gibt mehrere Pakete mit einer Funktion namens recode() (z. B. auch "car",
#     das man für den Levene-Test lädt). Je nach Lade-Reihenfolge wird die
#     falsche Funktion verwendet und es kommt eine Fehlermeldung.
#     Sicher ist die Schreibweise dplyr::recode(...).


# VARIANTE B: Umpolen mathematisch (EMPFOHLEN) ------------------------------
# Formel:  umgepolter Wert = (Minimum + Maximum) - alter Wert
# Für eine Skala von 1 bis 4:  (1 + 4) - x = 5 - x
#
#   alter Wert:   1   2   3   4
#   5 - x:        4   3   2   1    -> genau die gewünschte Umpolung
#
# Warum ist das oft besser?
#   - EINE kurze Rechnung statt vier Zuordnungen pro Item -> weniger Tippfehler.
#   - Funktioniert für JEDE Skala, man muss nur Min und Max kennen:
#       Skala 0 bis 3:  3 - x
#       Skala 1 bis 5:  6 - x
#       Skala 1 bis 7:  8 - x
#   - Fehlende Werte bleiben automatisch fehlend (5 - NA = NA).
#   - Kein Zusatzpaket nötig und keine Verwechslung mit gleichnamigen Funktionen.
#   - Man versteht, WAS beim Umpolen passiert: Die Skala wird gespiegelt.
# Wann ist recode() trotzdem sinnvoll? Wenn die Zuordnung KEINE einfache Spiegelung
# ist, z. B. Kategorien zusammenfassen (1 und 2 -> "niedrig", 3 und 4 -> "hoch").

bipolar$ISEL_1_r  = 5 - bipolar$ISEL_1
bipolar$ISEL_2_r  = 5 - bipolar$ISEL_2
bipolar$ISEL_7_r  = 5 - bipolar$ISEL_7
bipolar$ISEL_8_r  = 5 - bipolar$ISEL_8
bipolar$ISEL_11_r = 5 - bipolar$ISEL_11
bipolar$ISEL_12_r = 5 - bipolar$ISEL_12
# (ISEL_1_r und ISEL_2_r aus Variante A werden hier einfach überschrieben,
#  das Ergebnis ist identisch.)

# KONTROLLE: Kreuztabelle aus Original und umgepoltem Item.
# Es dürfen nur Einträge auf der "Gegendiagonale" stehen (1-4, 2-3, 3-2, 4-1).
# Diese Kontrolle sollte man sich bei jedem Umpolen angewöhnen!
table(bipolar$ISEL_1, bipolar$ISEL_1_r)


# 6.3 | Summenscore ISEL ------------------------------------------------------

# ACHTUNG: starts_with("ISEL") würde jetzt NICHT mehr funktionieren. Es würde die
# Original-Items 1, 2, 7, 8, 11, 12 UND ihre umgepolten Versionen erwischen
# (18 statt 12 Items). Deshalb legen wir die 12 richtigen Items ausdrücklich fest:
isel_items = c("ISEL_1_r", "ISEL_2_r", "ISEL_3", "ISEL_4", "ISEL_5", "ISEL_6",
               "ISEL_7_r", "ISEL_8_r", "ISEL_9", "ISEL_10", "ISEL_11_r", "ISEL_12_r")
length(isel_items)   # Kontrolle: genau 12?

bipolar$sum_ISEL = rowSums(bipolar[, isel_items])
summary(bipolar$sum_ISEL)
# Möglicher Bereich: 12 (12 x 1) bis 48 (12 x 4). Liegt alles darin?

# Durch die Bereinigung in 6.1 haben manche Personen NAs, ihr Summenscore ist daher NA.
sum(is.na(bipolar$sum_ISEL))
# Alternative für die Praxis: der MITTELWERT der beantworteten Items.
# Er liegt wieder auf der Skala 1 bis 4 und ist auch bei einzelnen fehlenden Items
# interpretierbar (viele Manuale erlauben das bis zu einer bestimmten Anzahl fehlender Items).
bipolar$mean_ISEL = rowMeans(bipolar[, isel_items], na.rm = TRUE)


# 6.4 | Deskriptive Statistik ISEL nach Gruppe -------------------------------

bipolar %>%
  group_by(groups) %>%
  summarise(n_gueltig = sum(!is.na(sum_ISEL)),
            M         = mean(sum_ISEL, na.rm = TRUE),
            SD        = sd(sum_ISEL, na.rm = TRUE),
            Median    = median(sum_ISEL, na.rm = TRUE),
            IQR       = IQR(sum_ISEL, na.rm = TRUE))

# ÜBUNG: Berechnen Sie Mittelwert und Standardabweichung des ISEL-Summenscores
# getrennt nach Gruppe, und zwar so wie in Abschnitt 5 mit eckigen Klammern.
# Denken Sie an na.rm = TRUE!
mean(bipolar$sum_ISEL[bipolar$groups == "EW"], na.rm = TRUE)
sd(bipolar$sum_ISEL[bipolar$groups == "EW"], na.rm = TRUE)
mean(bipolar$sum_ISEL[bipolar$groups == "noEW"], na.rm = TRUE)
sd(bipolar$sum_ISEL[bipolar$groups == "noEW"], na.rm = TRUE)


# ZUSAMMENFASSUNG --------------------------------------------------------------

# getwd()                 aktuelles Working Directory
# write.csv(), read.csv() CSV speichern / einlesen (row.names = FALSE!)
# write.csv2(), read.csv2()  Variante für deutsches Excel (Semikolon)
# str(), summary()        Überblick und Plausibilitätsprüfung
# select()                Spalten auswählen, z. B. mit starts_with() (dplyr)
# rowSums(), rowMeans()   Summe / Mittelwert pro Person
# mean(), median()        zentrale Tendenz
# mfv()                   Modalwert (Paket modeest)
# range(), min(), max()   Spannweite
# var(), sd()             Varianz, Standardabweichung (Nenner n - 1)
# quantile(), IQR()       Quartile, Interquartilsabstand
# round(x, 2)             auf 2 Nachkommastellen runden
# tapply()                Funktion getrennt nach Gruppen anwenden
# group_by() + summarise() Kennwerte-Tabelle nach Gruppen (dplyr)
# recode()                Werte einzeln neu zuordnen (dplyr)
# (Min + Max) - x         Items mathematisch umpolen
# is.na(), na.rm = TRUE   fehlende Werte finden bzw. ignorieren
