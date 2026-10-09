# =============================================================================
# 1. EINHEIT: R-GRUNDLAGEN
# Datentypen, Skalenniveaus, Vektoren, Data Frames, Indizierung, Logik,
# einfache Datensimulation
# =============================================================================

# ORGANISATORISCHES (live in RStudio zeigen) ----------------------------------

# 1) RStudio-Oberfläche erklären (vier Fenster):
#    - Links oben:  SOURCE   -> hier schreiben wir unser Skript (wird gespeichert)
#    - Links unten: CONSOLE  -> hier wird Code ausgeführt (wird NICHT gespeichert)
#    - Rechts oben: ENVIRONMENT -> alle Objekte, die wir erstellt haben  = "Gedächtnis"
#    - Rechts unten: FILES / PLOTS / PACKAGES / HELP
#    Merksatz: Alles, was wir später nochmal brauchen, gehört ins Skript,
#    nicht in die Konsole.
#
# 2) R-Projekt erstellen: File -> New Project -> New Directory
#    Warum? Das Projekt legt automatisch fest, in welchem Ordner R Dateien sucht
#    und speichert (das "Working Directory"). Wir müssen dann nie mit langen
#    Dateipfaden oder setwd() arbeiten. Prüfen kann man das mit getwd().
#
# 3) Leeres Skript erstellen: File -> New File -> R Script, sofort speichern.
#
# 4) Code ausführen: Cursor in die Zeile setzen und
#    Cmd + Enter (Mac) bzw. Strg + Enter (Windows) drücken.
#    Alles mit "#" davor ist ein KOMMENTAR und wird von R ignoriert.
#    Kommentare schreiben wir für unser zukünftiges Ich und für andere.
#
# Weitere Inhalte zum Herzeigen: Markdown-Vorlage, Pakete allgemein, Bookdown, Onlineübungen


# 1 | R ALS TASCHENRECHNER -----------------------------------------------------

2 + 2       # Addition
5 - 3       # Subtraktion
5 * 8       # Multiplikation
8 / 2       # Division
3^2         # Potenz (Alternative: 3**2, ist aber unüblich)
sqrt(9)     # Quadratwurzel: unsere erste FUNKTION

# Was ist eine Funktion? Ein Befehl mit runden Klammern: name(argumente).
# In die Klammern kommt, womit die Funktion arbeiten soll.
# Hilfe zu jeder Funktion: ?sqrt  (öffnet die Hilfe rechts unten)

# Es gilt Punkt vor Strich, Klammern wie in der Mathematik:
2 + 3 * 4     # = 14
(2 + 3) * 4   # = 20


# 2 | OBJEKTE UND ZUWEISUNG ----------------------------------------------------

# Ergebnisse können wir unter einem Namen speichern = ein OBJEKT erstellen.
# Das Objekt erscheint danach rechts oben im Environment.

a = 100
b = 3 / 100
summe = a + b          # Mit Objekten kann man weiterrechnen
quotient = (a + b) / b

summe       # Objektname ausführen = Inhalt anzeigen

# HINWEIS ZUR ZUWEISUNG: Wir verwenden in diesem Kurs "=".
# In vielen Büchern und Foren sieht man stattdessen "<-":
#    a <- 100   macht genau dasselbe wie   a = 100
# Tastenkürzel für "<-": Option + Minus (Mac) bzw. Alt + Minus (Windows).
# WICHTIG: Ein "=" weist zu, ein doppeltes "==" VERGLEICHT (kommt später).

# Regeln für Objektnamen:
# - Groß-/Kleinschreibung zählt: Alter und alter sind zwei verschiedene Objekte
# - Keine Leerzeichen, nicht mit einer Zahl beginnen
# - Keine Namen bestehender Funktionen verwenden (z. B. nicht "c", "mean", "sum"),
#   das verwirrt uns selbst und andere.
# - Ein Objekt mit gleichem Namen wird ohne Nachfrage ÜBERSCHRIEBEN.


# 3 | DATENTYPEN ---------------------------------------------------------------

# R unterscheidet verschiedene Arten von Werten. Die drei wichtigsten:

# (a) NUMERIC: Zahlen
zahl = 42.5

# (b) CHARACTER: Text, steht IMMER in Anführungszeichen
fach = "Psychologie"
frage = "Haben Psychologen wirklich alle Bärte und rauchen Zigarre?"

# Ohne Anführungszeichen sucht R nach einem OBJEKT mit diesem Namen:
# Psychologie   # -> Fehler: Objekt 'Psychologie' nicht gefunden

# (c) LOGICAL: Wahrheitswerte, nur TRUE oder FALSE (ohne Anführungszeichen!)
raucht = FALSE
5 > 3          # Vergleiche liefern immer TRUE oder FALSE

# Welcher Typ ist ein Objekt? -> class()
class(zahl)
class(fach)
class(raucht)

# Rechnen geht nur mit Zahlen:
# fach + 1   # -> Fehler: nicht-numerisches Argument für binären Operator

# SKALAR: Ein einzelner Wert wie oben (zahl, fach, raucht).
# Hintergrundwissen: In R ist ein Skalar eigentlich ein Vektor der Länge 1.
length(zahl)   # = 1


# 4 | VEKTOREN -----------------------------------------------------------------

# Ein VEKTOR ist eine Reihe von Werten DESSELBEN Typs.
# In der Psychologie: eine Variable, also z. B. das Alter aller Versuchspersonen.
# Erstellt wird er mit c() = "combine".

# Numerische Vektoren
j = c(1, 2, 3, 4, 5, 6, 7)
k = 1:200                                    # ":" erzeugt ganzzahlige Folgen
l = c(1:7, seq(from = 20, to = 30, by = 2))  # seq() für Folgen mit Schrittweite

# Bei seq() müssen die Argumentnamen nicht ausgeschrieben werden, wenn die
# Reihenfolge stimmt (from, to, by). Beides ist identisch:
seq(from = 20, to = 30, by = 2)
seq(20, 30, 2)
# Ausgeschrieben ist es für Anfänger*innen aber lesbarer.

# ÜBUNG: Erstellen Sie einen numerischen Vektor "CFH", der die Zahlen von 12 bis 54
# und jede dritte Zahl von 100 bis 120 (also 100, 103, 106, ...) enthält.
CFH = c(12:54, seq(from = 100, to = 120, by = 3))
CFH

# Character-Vektoren
Psychologen = c("Freud", "Wundt", "Bandura")
class(Psychologen)

# ACHTUNG: Ein Vektor kann nur EINEN Typ enthalten. Mischt man Typen,
# wandelt R alles in den "allgemeinsten" Typ um, meist character:
gemischt = c(1, 2, "drei")
gemischt          # Die Zahlen stehen jetzt in Anführungszeichen
class(gemischt)   # "character" -> damit kann man nicht mehr rechnen!
# Das passiert in echten Datensätzen oft, wenn z. B. jemand "k.A." in eine
# Zahlenspalte schreibt. Deshalb immer den Typ prüfen.

# Nützliche Funktionen für Vektoren
length(CFH)   # Anzahl der Elemente
sum(j)        # Summe
mean(j)       # Mittelwert
min(j); max(j)


# 4.1 | Elemente aus Vektoren auswählen (INDIZIERUNG) --------------------------

# Eckige Klammern [ ] wählen Elemente nach ihrer POSITION aus.
# R beginnt bei 1 zu zählen (nicht bei 0 wie manche andere Programmiersprachen).

Psychologen[1]          # erstes Element
Psychologen[2:3]        # zweites bis drittes Element
Psychologen[c(1, 3)]    # erstes und drittes Element
Psychologen[-1]         # alle AUSSER dem ersten (Minus = ausschließen)

# Merke: runde Klammern ( ) gehören zu Funktionen,
#        eckige Klammern [ ] wählen etwas aus.

# ÜBUNG: Wählen Sie aus dem Vektor CFH das 10. bis 15. Element aus.
CFH[10:15]


# 5 | SKALENNIVEAUS UND IHRE UMSETZUNG IN R ------------------------------------

# Aus der Methodenlehre kennen wir vier Skalenniveaus. R muss wissen, welches
# Niveau eine Variable hat, denn davon hängt ab, welche Berechnungen sinnvoll
# sind (z. B. ist ein Mittelwert für "Diagnose" sinnlos).
#
#   Skalenniveau     | Beispiel                     | In R
#   -----------------|------------------------------|----------------------------
#   Nominal          | Diagnose, Geschlecht         | factor()
#   Ordinal          | Schulabschluss, Likert-Item* | factor(..., ordered = TRUE)
#   Intervall        | IQ, Temperatur in °C         | numeric
#   Verhältnis       | Reaktionszeit, Alter         | numeric
#
#   * Likert-Items werden in der Praxis oft als numeric behandelt
#     (z. B. für Summenscores). Streng genommen sind sie ordinal.
#
# R unterscheidet NICHT zwischen Intervall- und Verhältnisskala, beides ist
# numeric. Welche Rechenoperationen inhaltlich sinnvoll sind, müssen wir
# selbst wissen.

# 5.1 | NOMINAL: Faktor ------------------------------------------------------

# Kategoriale Variablen werden oft als Zahlen kodiert (1 = männlich, 2 = weiblich).
# Für R sind das aber erst einmal ganz normale Zahlen:
geschlecht = c(1, 2, 2, 1, 2)
mean(geschlecht)   # R rechnet brav einen Mittelwert aus, der inhaltlich Unsinn ist

# Mit factor() sagen wir R: Das sind Kategorien, keine Zahlen.
#   levels = welche Kodierungen gibt es?
#   labels = welche Bedeutung haben sie? (gleiche Reihenfolge wie levels!)
geschlecht = factor(geschlecht, levels = c(1, 2), labels = c("männlich", "weiblich"))
geschlecht
class(geschlecht)
levels(geschlecht)   # vorhandene Kategorien
table(geschlecht)    # Häufigkeiten: die passende Statistik für Nominaldaten
# mean(geschlecht)   # -> Warnung + NA. Gut so: R schützt uns jetzt vor Unsinn.

# 5.2 | ORDINAL: geordneter Faktor -------------------------------------------

# Bei ordinalen Daten gibt es eine Rangfolge. Mit ordered = TRUE weiß R das.
# Die Reihenfolge der levels bestimmt die Rangfolge (von niedrig nach hoch).
abschluss = c("Abitur", "Mittlere Reife", "Abitur", "Hauptschule", "Mittlere Reife")
abschluss = factor(abschluss,
                   levels = c("Hauptschule", "Mittlere Reife", "Abitur"),
                   ordered = TRUE)
abschluss
abschluss > "Hauptschule"   # Größer/kleiner-Vergleiche sind jetzt erlaubt
table(abschluss)            # Tabelle erscheint in der richtigen Reihenfolge
# Ohne die levels-Angabe würde R alphabetisch sortieren.
# "Abitur" stünde dann fälschlich an erster Stelle.

# 5.3 | INTERVALL / VERHÄLTNIS: numeric --------------------------------------

alter = c(20, 31, 25, 34, 51)
class(alter)
mean(alter)   # Mittelwert ist hier sinnvoll


# 6 | DATA FRAMES --------------------------------------------------------------

# Ein DATA FRAME ist eine Tabelle, genau so, wie wir Daten aus SPSS oder Excel kennen:
#   - jede ZEILE   = eine Person (ein Fall)
#   - jede SPALTE  = eine Variable (ein Vektor)
# Unterschied zum Vektor: Spalten dürfen verschiedene Typen haben.

# Wir erstellen zuerst drei Vektoren ...
Name = c("Max", "Maja", "Mia", "Moritz", "Markus")
Alter = c(20, 31, 25, 34, 51)
Diagnose = c("Depression", "Zwangsstörung", "Depression", "Soziale Phobie", "Depression")

# ... und fügen sie zu einem Data Frame zusammen. Jeder Vektor wird eine Spalte.
# Voraussetzung: Alle Vektoren sind gleich lang (hier: 5 Personen).
df = data.frame(Name, Alter, Diagnose)
df

# Übersicht über einen Data Frame
nrow(df)   # Anzahl Zeilen   = Anzahl Personen
ncol(df)   # Anzahl Spalten  = Anzahl Variablen
dim(df)    # beides zusammen
str(df)    # "structure": welche Variablen, welcher Typ? SEHR wichtig!
names(df)  # Variablennamen
# Tipp: Im Environment auf den Data Frame klicken öffnet eine Tabellenansicht.

# Neue Variable hinzufügen: einfach mit $ einen neuen Namen vergeben
df$Geschlecht = factor(c(1, 2, 2, 1, 2), levels = c(1, 2),
                       labels = c("männlich", "weiblich"))
df$Diagnose = factor(df$Diagnose)   # Diagnose ist nominal -> Faktor
str(df)


# 6.1 | Spalten, Zeilen und Zellen auswählen ---------------------------------

# Möglichkeit 1: Spalte über "$"
df$Alter

# Möglichkeit 2: eckige Klammern mit [ZEILE, SPALTE]
#   Alles VOR dem Komma bezieht sich auf ZEILEN (Personen),
#   alles NACH dem Komma auf SPALTEN (Variablen).
#   Bleibt eine Seite leer, heißt das: "alle".

df[1, 2]                     # Zeile 1, Spalte 2 -> eine Zelle
df[1, ]                      # Zeile 1, alle Spalten -> eine Person
df[, 1]                      # alle Zeilen, Spalte 1 -> eine Variable
df[3, "Alter"]               # Spalten auch über den Namen ansprechbar
df[1:3, c("Name", "Alter")]  # mehrere Zeilen und Spalten

# Spalten über den NAMEN anzusprechen ist sicherer als über die Position:
# Fügt man eine Spalte hinzu, verschieben sich die Positionen, die Namen nicht.

# ÜBUNG: Welche Diagnose hat die Person in der zweiten Zeile?
df[2, "Diagnose"]   # über den Variablennamen
df[2, 3]            # über die Position der Variable


# 6.2 | Werte verändern ------------------------------------------------------

# Auswahl + Zuweisung = Wert ÜBERSCHREIBEN. So korrigiert man z. B. Eingabefehler.
df[2, "Alter"] = 32
df
df[2, "Alter"] = 31   # und wieder zurück
# ACHTUNG: R fragt nicht nach! Der alte Wert ist danach weg.
# Darum verändern wir nie die Originaldatei, sondern nur das Objekt in R.


# 7 | LOGISCHE OPERATOREN UND FILTERN ------------------------------------------

# Statt über Positionen können wir Werte nach einer BEDINGUNG auswählen.
#   ==  gleich           !=  ungleich
#   >   größer           <   kleiner
#   >=  größer gleich    <=  kleiner gleich
#   &   UND (beide Bedingungen müssen stimmen)
#   |   ODER (mindestens eine Bedingung muss stimmen)
#   %in% "ist enthalten in" (Abkürzung für viele ODER-Vergleiche)

# Schritt 1: Eine Bedingung liefert für JEDES Element TRUE oder FALSE
df$Alter > 30

# Schritt 2: Diesen TRUE/FALSE-Vektor in eckige Klammern stecken.
# R behält genau die Elemente, bei denen TRUE steht.
df$Alter[df$Alter > 30]

# Das funktioniert genauso für ZEILEN eines Data Frames (Bedingung VOR das Komma!):
df[df$Alter > 30, ]                          # alle Personen über 30
df[df$Diagnose == "Depression", ]            # alle Personen mit Depression
df[df$Diagnose == "Depression" & df$Alter > 22, ]   # beides zusammen (UND)
df[df$Alter < 22 | df$Alter > 50, ]          # jünger als 22 ODER älter als 50
df[df$Diagnose %in% c("Zwangsstörung", "Soziale Phobie"), ]  # Liste von Werten

# Tricks mit TRUE/FALSE: R zählt TRUE als 1 und FALSE als 0
sum(df$Alter > 30)    # WIE VIELE Personen sind über 30?
mean(df$Alter > 30)   # welcher ANTEIL ist über 30?

# ÜBUNG: Wählen Sie alle Frauen aus, die jünger als 35 sind.
df[df$Geschlecht == "weiblich" & df$Alter < 35, ]


# 8 | ARBEIT MIT EINEM GRÖSSEREN DATENSATZ: starwars ---------------------------

# PAKETE: R kann durch Pakete erweitert werden (wie Apps auf dem Handy).
#   install.packages("name")  -> einmalig herunterladen (wie App installieren)
#   library(name)             -> in JEDER Sitzung laden (wie App öffnen)
# install.packages("dplyr")   # nur einmal nötig, danach auskommentieren
library(dplyr)

# Beim Laden erscheint eine Meldung, dass Funktionen "maskiert" werden
# (u. a. filter). Das ist KEIN Fehler: dplyr bringt eine eigene Funktion
# filter() mit, die nun Vorrang vor der gleichnamigen Funktion aus R hat.

# dplyr enthält den Übungsdatensatz "starwars".
# Die Spalten 12 bis 14 sind Listen (z. B. alle Filme pro Figur). Damit können
# wir noch nicht arbeiten, daher behalten wir nur die Spalten 1 bis 11.
starwars = as.data.frame(starwars[, 1:11])

head(starwars)      # erste 6 Zeilen
dim(starwars)       # 87 Figuren, 11 Variablen
str(starwars)
summary(starwars$mass)   # Achtung: "NA's" in der Ausgabe!


# 8.1 | Fehlende Werte: NA -----------------------------------------------------

# NA = "Not Available" = fehlender Wert. Das kennen wir aus jedem Fragebogen:
# Nicht alle Personen beantworten alle Fragen.
gewicht = starwars$mass

mean(gewicht)                # Ergebnis: NA
# Warum? Wenn auch nur EIN Wert unbekannt ist, ist auch der Mittelwert unbekannt.
mean(gewicht, na.rm = TRUE)  # na.rm = "NA remove": fehlende Werte ignorieren

is.na(gewicht)               # TRUE, wo ein Wert fehlt
sum(is.na(gewicht))          # Anzahl fehlender Werte


# 8.2 | Logische Auswahl mit fehlenden Werten -----------------------------------

gewicht[gewicht == 79]
# Überraschung: Neben 79 erscheinen auch NAs! Warum?
# Ist "unbekannt == 79"? Das weiß R nicht, also ist das Ergebnis NA statt TRUE/FALSE.
# Und ein NA in den eckigen Klammern liefert ein NA im Ergebnis.

# Lösung: which() gibt nur die POSITIONEN zurück, an denen wirklich TRUE steht.
which(gewicht == 79)            # an welchen Stellen?
gewicht[which(gewicht == 79)]   # jetzt ohne NAs

gewicht[which(gewicht != 79)]   # ungleich
gewicht[which(gewicht >= 79)]   # größer gleich

# Verknüpfungen
gewicht[which(gewicht > 50 & gewicht < 100)]   # zwischen 50 und 100 kg
gewicht[which(gewicht < 50 | gewicht > 100)]   # unter 50 ODER über 100 kg

# Mit Text funktioniert es genauso
haarfarbe = starwars$hair_color
haarfarbe[which(haarfarbe == "brown")]
length(which(haarfarbe == "brown"))   # Wie viele Figuren haben braune Haare?

table(starwars$hair_color)                  # Häufigkeiten aller Haarfarben
table(starwars$hair_color, useNA = "ifany") # inklusive fehlender Werte
# table() lässt NAs standardmäßig WEG. Das sollte man wissen!


# 8.3 | Komfortabler filtern mit filter() aus dplyr --------------------------------

# filter(Datensatz, Bedingung) macht dasselbe wie df[Bedingung, ], ist aber
# lesbarer: Innerhalb von filter() können wir Spaltennamen direkt verwenden,
# ohne jedes Mal starwars$ davor zu schreiben.
# Außerdem lässt filter() Zeilen mit NA in der Bedingung automatisch weg.

filter(starwars, mass == 79)
filter(starwars, mass > 50 & mass < 100)
filter(starwars, hair_color == "brown", sex == "male")   # Komma = UND

# WICHTIG: Innerhalb von filter() immer den SPALTENNAMEN des Datensatzes
# verwenden (mass), nicht ein Objekt aus dem Environment (gewicht).

# Die PIPE %>% bedeutet: "Nimm das Ergebnis links und gib es an die Funktion rechts weiter."
# Lies sie als "und dann". Die beiden Zeilen sind identisch:
filter(starwars, mass == 79)
starwars %>% filter(mass == 79)
# Vorteil: Mehrere Schritte lassen sich von oben nach unten lesbar verketten.
# Tastenkürzel: Cmd + Shift + M (Mac) bzw. Strg + Shift + M (Windows).
# In neueren R-Versionen gibt es auch die eingebaute Pipe |>, sie funktioniert hier gleich.

schwere_figuren = starwars %>% filter(mass > 100)
nrow(schwere_figuren)

# ÜBUNG: Wie viele Figuren sind größer als 180 cm (height) UND haben blaue Augen
# (eye_color == "blue")?
starwars %>% filter(height > 180, eye_color == "blue") %>% nrow()


# 9 | DATEN SIMULIEREN ---------------------------------------------------------

# Warum Daten simulieren?
# - Wir können üben, ohne echte (sensible) Daten zu benötigen.
# - Wir wissen, wie die "Wahrheit" aussieht, und können prüfen,
#   ob unsere Auswertung sie wiederfindet.
# - So kann man Stichprobenvariation sichtbar machen (-> Statistikvorlesung).

# set.seed(): Zufallszahlen sind in R nur "pseudo-zufällig". Mit derselben
# Startzahl erhalten alle im Raum exakt dieselben Zufallszahlen.
# Ohne set.seed() sieht bei jeder Person (und bei jedem Ausführen) alles anders aus.
set.seed(42)

# 9.1 | Normalverteilte Werte: rnorm() ---------------------------------------

# rnorm(n, mean, sd): n Werte aus einer Normalverteilung
# Beispiel: IQ ist normiert auf M = 100, SD = 15
iq = rnorm(n = 100, mean = 100, sd = 15)
head(iq)
round(head(iq), 1)   # round() rundet auf die angegebene Zahl von Nachkommastellen
mean(iq)             # nicht genau 100!
sd(iq)               # nicht genau 15!
# Warum? Wir haben eine STICHPROBE von 100 Personen gezogen. Stichprobenkennwerte
# schwanken um die Populationswerte. Mit n = 10000 lägen sie viel näher dran.
hist(iq)             # Histogramm als erster Blick (ausführlich später mit ggplot)

# 9.2 | Zufälliges Ziehen: sample() ------------------------------------------

# sample(x, size, replace): zieht zufällig "size" Werte aus "x"
# Beispiel: Antworten auf einem 5-stufigen Likert-Item
likert = sample(x = 1:5, size = 100, replace = TRUE)
table(likert)
# replace = TRUE: "mit Zurücklegen", jeder Wert kann mehrfach gezogen werden.
# Ohne replace = TRUE könnten wir aus 1:5 höchstens 5 Werte ziehen.

# 9.3 | Wiederholen: rep() ---------------------------------------------------

# rep() wiederholt Werte, ideal für Gruppenvariablen
rep(c("KG", "EG"), times = 3)    # KG EG KG EG KG EG
rep(c("KG", "EG"), each = 3)     # KG KG KG EG EG EG
gruppe = rep(c("KG", "EG"), each = 50)   # 50 Kontroll- und 50 Experimentalpersonen

# 9.4 | Alles zusammen: ein simulierter Datensatz ------------------------------

studie = data.frame(
  id         = 1:100,                    # fortlaufende Personennummer
  gruppe     = factor(gruppe),           # nominal
  iq         = round(iq),                # numeric (intervallskaliert)
  zufrieden  = likert                    # Likert-Item (eigentlich ordinal)
)
head(studie)
str(studie)

# Alles, was wir heute gelernt haben, funktioniert jetzt auch hier:
studie[studie$gruppe == "EG", ]
mean(studie$iq[studie$gruppe == "EG"])
studie %>% filter(iq > 115)

# ÜBUNG: Simulieren Sie für 60 Personen eine Reaktionszeit in Millisekunden
# (M = 450, SD = 80). Wie viele Personen sind langsamer als 550 ms?
set.seed(1)
rt = rnorm(60, mean = 450, sd = 80)
sum(rt > 550)


# ZUSAMMENFASSUNG --------------------------------------------------------------

# Funktionen
# c()               Vektor erstellen ("combine")
# seq()             Zahlenfolge mit Schrittweite
# rep()             Werte wiederholen
# class()           Datentyp anzeigen
# length()          Anzahl Elemente
# factor()          in (geordneten) Faktor umwandeln; levels, labels, ordered
# levels()          Kategorien eines Faktors
# data.frame()      Data Frame erstellen
# as.data.frame()   in Data Frame umwandeln
# nrow(), ncol(), dim()   Anzahl Zeilen, Spalten, beides
# str()             Struktur: Variablen und ihre Typen
# names()           Variablennamen
# head()            erste Zeilen
# summary()         Zusammenfassung
# table()           Häufigkeiten (useNA = "ifany" zeigt auch NAs)
# sum(), mean(), min(), max(), sd()   Kennwerte (na.rm = TRUE ignoriert NAs)
# is.na()           fehlende Werte finden
# which()           Positionen, an denen eine Bedingung TRUE ist
# round()           runden
# sqrt()            Quadratwurzel
# library()         Paket laden
# filter()          Zeilen nach Bedingung auswählen (dplyr)
# set.seed()        Zufallszahlen reproduzierbar machen
# rnorm()           normalverteilte Zufallswerte
# sample()          zufällig ziehen
# hist()            Histogramm
#
# Operatoren
# +  -  *  /  ^     Rechnen
# =  (bzw. <-)      Zuweisung
# :                 ganzzahlige Folge
# $                 Variable aus Data Frame
# [ ]               Auswahl im Vektor
# [ , ]             Auswahl im Data Frame: [Zeilen, Spalten]
# ==  !=            gleich, ungleich
# >  <  >=  <=      Größenvergleiche
# &  |              UND, ODER
# %in%              ist enthalten in
# %>%               Pipe: "und dann"
# #                 Kommentar
