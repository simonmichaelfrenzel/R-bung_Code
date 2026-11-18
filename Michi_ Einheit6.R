## Einheit 6  18.11.26 ##


##### Multifaktorielle ANOVA: Mehrere UVs, eine AV #####

# library(afex)
# library(ggplot2)
# library(emmeans)
# library(see)
# library(patchwork)
# library(performance)
# 
# df$Sport = c(3.5, 4.0, 8.0, 4.0, 5.0, 6.0, 5.5, 7.0, 4.0, 3.5,
#                          7.5, 4.5, 5.0, 3.0, 1.0, 6.0, 0.0, 2.0, 3.0, 2.0,
#                          6.0, 5.0, 3.0, 5.0, 5.0, 5.0, 4.0, 4.0, 4.0, 4.5)

# Unser Datensatz: AV: Symptome, UV: Diagnose und Therapie -> 2. Haupteffekt 1. Interaktioneffekt 

# In unserem Beispiel könnte es interessant sein, zusätzlich zur erhaltenen Therapie 
# zu berücksichtigen, welche Diagnose die Patienten hatten.
# 
# Unsere Fragestellung würde sich um 2 weitere Aspekte erweitern:
#   
# Nach welcher Therapie haben die Patient:innen die schwächsten Symptome? (hatten wir bereits - Haupteffekt Therapie)
# Welche Diagnose hatte die schwächsten Symptome? (Haupteffekt Diagnose)
# Gibt es, je nachdem welche Diagnose die Patienten hatten, Unterschiede in der Wirksamkeit der Therapie? (Interaktionseffekt)


df = read.csv("https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fstephangoerigk%2FWAF_Folien%2Fmaster%2Ftherapy4groups.csv&data=05%7C02%7Csimon.frenzel%40charlotte-fresenius-uni.de%7C4783dfd844da4c5b6e6b08df40b197e6%7C2ed718a0fb7d466d9595cfef0d253184%7C0%7C0%7C639300803627207223%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8ubGXLB%2BVJAhXhaPlvexWqw10heujETYGGFtl%2FClizc%3D&reserved=0")

# 1. Variante wie letzte Stunde 

mod2 = lm(Symptoms ~ Therapy * Diagnosis , data = df)
anova(mod2)

# 2. Variante 
# install.packages("afex")
library(afex)

mod3 = aov_ez(dv = "Symptoms", between = c("Therapy", "Diagnosis"), id = "ID", data = df)
?aov_ez()

# grafisch: Wie zeigen sich die Effekte hier?
library(ggplot2)
ggplot(data = df, aes(x = Therapy, y = Symptoms, colour = Diagnosis)) +
  stat_summary(fun.data = mean_se,  geom = "errorbar") + #Mittelwert ± 1 Standardfehler
  stat_summary(geom = "point", fun = mean) 

# Post hoc Tests: "Verständnis der Effekte"
library(emmeans)
# Wir Gruppieren hier nach Diagnose 
# Erinnerungen: "estimate" Schätzwert in Original Einheit vs t-Ratio: /SE
# Erklären: $emeans vs $contrasts
emmeans(mod3, pairwise ~ Therapy|Diagnosis)


##### Regression #####
# Mittelwertsunterschiede --> T-test/Anova 
# Zusammenhänge --> Korrelation (ungerichtet) + heute: Regression (gerichtet)

# In unserem Beispiel: Zusätzlich Erhebung einer Variable: Stunden Sport pro Woche, 
# Annahme aus Literatur: Mehr Sport führt zu Symptomreduktion 
# Forschungsfrage: Lässt sich die Symptomeschwere durch Sport vorhersagen 
# Wichtig: Boebachtungsdaten ≠ Kauslaität

df$Sport = c(3.5, 4.0, 8.0, 4.0, 5.0, 6.0, 5.5, 7.0, 4.0, 3.5,
             7.5, 4.5, 5.0, 3.0, 1.0, 6.0, 0.0, 2.0, 3.0, 2.0,
             6.0, 5.0, 3.0, 5.0, 5.0, 5.0, 4.0, 4.0, 4.0, 4.5)

# Erster Eindruck über Streudiagramm 
 ggplot( data = df, aes( x= Sport, y = Symptoms )) + 
   geom_point() +
   geom_smooth(method = "lm")

 # Berechnung 
  reg = lm(Symptoms ~ Sport, data = df ) # analog zu Anova 
  summary(reg) # neu, für die Regression
  
  # Koeffizienten extrahieren
  summary(reg)$coefficients
  summary(reg)$r.squared
  reg$df.residual
  
  
  # Voraussetzungen 
  # 1. Linearität  (grafisch über Streudiagramm)
  ggplot( data = df, aes( x= Sport, y = Symptoms )) + 
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    geom_smooth(method = "loess", se = FALSE, colour = "red") 
  
# 2. NV der Resiuden
  #grafisch: qqnorm
  
  # stres =rstandard(reg) #standarditiserte Residuen 
  # qqnorm(stres)
  # qqline(stres)
  # einfacher: 
  ?plot.lm
  plot(reg,2) #macht alles automatisch
  
  # Idee. Werte nach Rangpositon sortieren, Berechnung Quantil: Welcher Anteil an wWerten liegt darunter + standardisieren
  # VGL mit theoretischen Wert an xter Stelle: Weicht ein Punkt nach oben 
  # von der Geraden ab, ist der echte Wert größer, als die Normalverteilung 
  # an dieser Rangposition erwarten würde. Weicht er nach unten ab, ist er kleiner.
  
  # statistisch: Shapiro-Wilk-Test
  
  shapiro.test(stres)
  
 # 3. Homoskedastiziät
  # Streuung der Residuen über den gesamten Wertebereich gleich groß ?
  #grafisch:
  plot(reg,1) # keine Systematik in den Punkten + rote Linie ungefägr horizontal 
  
  #test: Breusch-Pagan Test (= ähnliche idee wie Levene test der ANOVA, Gleicheit der Gruppenvarianzen)
  lmtest::bptest(reg)


  # Alternative: peformance-Paket (siehe ANOVA)
  library(performance)
  check_normality(reg) #NV der Residuen
  check_heteroscedasticity(reg) # =Variance der Residuen über den Wertebereich gleich?
  
  # Alle in einem/ Alternative 2: 
  library(see)
  library(patchwork)
  
  check_model(reg) # "linearity" & "Normality of resiudals"

