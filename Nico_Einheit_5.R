df = read.csv("https://raw.githubusercontent.com/stephangoerigk/WAF_Folien/master/therapy4groups.csv")
head(df)
str(df)
df$Therapy
df$Symptoms

df$Therapy = factor(df$Therapy)
df$Diagnosis = factor(df$Diagnosis)

mod1 = lm(Symptoms ~ Therapy, data = df)
av = anova(mod1)
# summary(mod1)

str(av)
av$`F value`[-2]
av$Df

library(effectsize)
eff = omega_squared(mod1)
interpret_omega_squared(eff)
report::report(av)

shapiro.test(df$Symptoms[df$Therapy == "VT"])

by(df$Symptoms, df$Therapy, shapiro.test)
by(df$Symptoms, df$Therapy, hist)
qqnorm(df$Symptoms[df$Therapy == "VT"])
qqline(df$Symptoms[df$Therapy == "VT"])

library(car)

leveneTest(Symptoms ~ Therapy, data = df, center = "mean")

library(performance)
check_model(mod1)
check_homogeneity(mod1)


library(emmeans)
post = emmeans(mod1, pairwise ~ Therapy)

post$emmeans
d = as.data.frame(post$emmeans)
d$KI = paste0("[", round(d$lower.CL,2), ", ", round(d$upper.CL,2), "]")
d$emmean = round(d$emmean,2)
d$SE = round(d$SE, 2)
d = d[,c("Therapy", "emmean", "SE", "df", "KI")]
names(d) = c("Therapieform", "MW", "SE", "df", "95%-KI")
d$Therapieform = c("Kontrollgruppe", "Psychoanalyse", "SSRI", "Verhaltenstherapie")

library(flextable)

flextable(d)
tab = theme_apa(flextable(d))

ft = add_header_lines(tab, values = "Tabelle 3. Symptomschwere nach Therapieende")
ft = add_footer_lines(ft, values = "Anmerkung. MW = Mittelwert, SE = Standardfehler
                      df = Freiheitsgrade, 95%KI = 95% Konfidenzintervall")
ft = font(ft, fontname = "Times New Roman", part = "all")
ft = align(ft, i = c(1,2), align = "left", part = "header")

save_as_docx(ft, path = "emmeans.docx")



