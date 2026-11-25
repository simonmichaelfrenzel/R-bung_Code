### Einheit 7 25.11.26 ####

## Multiple Regression ## 
# Letzte Woche:
reg = lm(Symptoms ~ Sport, data = df )
summary(reg)
#Heute, wie bei Mehrfaktorieller-ANOVA zwei Prädiktoren: z.B. Sport und Diagnose

reg2 = lm(Symptoms ~ Sport * Diagnosis , data = df )
summary(reg2)
# D.h. man kann auch kategoriale Variablen benutzen!

reg2 = lm(Symptoms ~ Sport + Behandlungsversuche, data = df )
summary(reg2)
# * für Interaktion


## Poweranlayse ##
# Siehe auch VL Folien 6, Heute am Beispiel: Lineare Regression
install.packages("pwr")
library(pwr)

?pwr.f2.test() 
# u = Zählerfreiheitgrade = Anzahl an Prädiktoren
# v -- freilassen, wird dann ausgegeben -- zuürckrechnen auf N = k + v +1
# f^2: Konventionen .02 (klein), .15 (mittel) und .35 (groß).
# a priori vs sensitivität 8wir haben so viele und schauen, was die power ist)
pwr.f2.test(u = 2, f2= .35 , sig.level = 0.05, power = 0.8)

?pwr.r.test()

pwr.r.test(n = NULL, r= 0.3, sig.level = 0.05, power =0.8 , alternative =  "greater")
# hier wieder erklären, was was ist, und warum 


## Flextable Tabelle ##

# Koeffizienten 

# auf Whiteboard schreiben, wie es aussehen soll
str(summary(reg))

tab = summary(reg)$coefficients
tab = as.data.frame(tab)

ki = confint(reg)
ki = as.data.frame(ki)

p = tab$`Pr(>|t|)`
#ifelse(test, ja, nein)
p_wert = ifelse(p < .001, "< .001", sub( "^0", "", formatC(p, format = "f", digits = 3))) 
# Ende führende 0 entfernen, FormatC -- in Format x.xxx


t = data.frame(Effekt = c("Intercept", "Behandlungsversuche"),
               b = round(tab$Estimate,2),
               SE = round(tab$`Std. Error`, 2),
               # paste0 = ZShängen ohne Trennzeichen
               KI = paste0("[", round(ki$`2.5 %`,2), ", ", round(ki$`97.5 %`,2), "]"),
               t = round(tab$`t value`, 2),
               p = p_wert)

names(t) = c("Effekt", "b", "SE", "95% KI", "t", "p")
t
# Tabelle erstellen mit flextable
library(flextable)

ft = flextable(t)
ft = add_header_lines(ft, values = c("Tabelle 3",
                                     "Lineare Regression: Vorhersage der Symptomschwere durch die Sportstunden pro Woche"))
ft = add_footer_lines(ft, value = "Anmerkung. b = unastandardisierter Regressionskoeffizient, SE = Standardfehler, KI = 95% Konfidenzintervall")
ft = theme_apa(ft)
ft = align(ft, i = c(1,2), align = "left", part = "header") # row
ft = align(ft, j = 1, align = "left", part = "all")
ft = bold(ft, i = 1, part = "header")
ft = italic(ft, i = 2, part = "header")
ft = hline_top(ft, border = officer::fp_border(width = 0), part = "header")
ft = hline(ft, i = 1, border = officer::fp_border(width = 0), part = "header")
ft = italic(ft, i = 3,  j = c(2,3,5,6 ) , part = "header") # p-value in italic
ft = autofit(ft) # Zeilengröße an Inhalt fitten


save_as_docx(ft, path = "Tabelle3.docx")
























