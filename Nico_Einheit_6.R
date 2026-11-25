## Einheit 6  18.11.26 ##

df = read.csv("https://raw.githubusercontent.com/stephangoerigk/WAF_Folien/master/therapy4groups.csv")

# 1. Variante wie letzte Stunde 

mod2 = lm(Symptoms ~ Therapy * Diagnosis , data = df)
anova(mod2)

# 2. Variante 
# install.packages("afex")
library(afex)

mod3 = aov_ez(dv = "Symptoms", between = c("Therapy", "Diagnosis"), id = "ID", data = df)


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

names(df)


# Berechnung 
mod2 = lm(Symptoms ~ Behandlungsversuche, data = df ) # analog zu Anova 
summary(reg) # neu, für die Regression

# Erster Eindruck über Streudiagramm 
ggplot( data = df, aes( x= Behandlungsversuche, y = Symptoms )) + 
  geom_point() +
  geom_smooth(method = "lm")

# Voraussetzungen

# NV der Residuen
shapiro.test(rstandard(reg))
qqnorm(rstandard(reg))
qqline(rstandard(reg))

plot(reg,2)

# Homoskedastizität
plot(reg2,1)


# multiple regression ?




# Koeffizienten 
str(summary(mod2))
tab = summary(mod2)$coefficients
tab = as.data.frame(tab)
ki = confint(mod2)
ki = as.data.frame(ki)

p = tab$`Pr(>|t|)`
p_wert = ifelse(p < .001, "< .001", round(p,3))

t = data.frame(Effekt = c("Intercept", "Behandlungsversuche"),
               b = round(tab$Estimate,2),
               SE = round(tab$`Std. Error`, 2),
               KI = paste0("[", round(ki$`2.5 %`,2), ", ", round(ki$`97.5 %`,2), "]"),
               t = round(tab$`t value`, 2),
               p = p_wert)

names(t) = c("Effekt", "b", "SE", "95% KI", "t-Wert", "p-Wert")
t

library(flextable)

ft = flextable(t)
ft = add_header_lines(ft, values = c("Tabelle 3",
                                     "Lineare Regression: Vorhersage der Symptomschwere durch die Anzahl der Behandlungsversuche"))
ft = add_footer_lines(ft, value = "Anmerkung. b = unastandardisierter Regressionskoeffizient, SE = Standardfehler, KI = 95% Konfidenzintervall")
ft = theme_apa(ft)
ft = align(ft, i = c(1,2), align = "left", part = "header")
ft = align(ft, j = 1, align = "left", part = "all")
ft = bold(ft, i = 1, part = "header")
ft = italic(ft, i = 2, part = "header")
ft = hline_top(ft, border = officer::fp_border(width = 0), part = "header")
ft = hline(ft, i = 1, border = officer::fp_border(width = 0), part = "header")
ft = autofit(ft)

save_as_docx(ft, path = "Tabelle3.docx")




