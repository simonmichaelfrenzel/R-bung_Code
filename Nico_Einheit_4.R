library(tidyverse)
library(psych)
library(ggplot2)

bipolar = read.csv("bipolar.csv")
bipolar$sum_YMRS = rowSums(select(bipolar, starts_with("YMRS")))

select(bipolar, starts_with("ISEL"))
summary(select(bipolar, starts_with("ISEL")))

# ISEL Items umkodieren: 1, 2, 7, 8, 11, 12
# Variante 1: Umgepolte Items werden als eigene Variable gekennzeichnet (Endung "_r", Primärdaten werden beibehalten)
bipolar$ISEL_1_r = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

bipolar[,c("ISEL_1", "ISEL_1_r")]

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

# Variante 3 Mathematisch
bipolar$ISEL_1 = 5 - bipolar$ISEL_1
bipolar$ISEL_2 = 5 - bipolar$ISEL_2
bipolar$ISEL_7 = 5 - bipolar$ISEL_7
bipolar$ISEL_8 = 5 - bipolar$ISEL_8
bipolar$ISEL_11 = 5 - bipolar$ISEL_11
bipolar$ISEL_12 = 5 - bipolar$ISEL_12

bipolar$mean_ISEL = rowMeans(select(bipolar, starts_with("ISEL")))

summary(bipolar$mean_ISEL)
describe(bipolar$mean_ISEL)
describeBy(bipolar$mean_ISEL, group = bipolar$groups)


saveRDS(bipolar, file = "bipolar_clean.rds")
write.csv(bipolar, file = "bipolar_clean.csv")

bipolar_clean = readRDS("bipolar_clean.rds")



# t-Test
?t.test

t.test(mean_ISEL ~ groups, data = bipolar, var.equal = FALSE, alternative = "two.sided")

# 1. Grundgerüst und Verknüfen der Variablen
  
ggplot(data = bipolar, aes(x = groups, y = mean_ISEL))

# 2. geom_ (geometrische Ebene); stat_ (Berechnungen im Hintergrund), jeweils verknüpft
  
ggplot(data = bipolar, aes(x = groups, y = mean_ISEL)) +
  geom_boxplot() 

ggplot(data = bipolar, aes(x = groups, y = mean_ISEL)) +
  geom_boxplot(width = 0.5) +
  stat_summary(fun = "mean", geom = "point", shape = 15, size = 4, color = "grey")

# 3 Beiden Gruppen in unterschiedlichen Farben und einzelne "Punkte"

ggplot(data = bipolar, aes(x = groups, y = mean_ISEL, fill = groups)) +
  geom_boxplot(width = 0.5, alpha = 0.6) +
  geom_jitter(width = 0.15, alpha = 0.5) +
  stat_summary(fun = "mean", geom = "point", shape = 18, size = 4, color = "red")

# 4 eigene Farben "green" oder "hexcodes" (CFH ) #61243F #D32D7D

ggplot(data = bipolar, aes(x = groups, y = mean_ISEL, fill = groups)) +
  geom_boxplot(width = 0.5, alpha = 0.8) +
  geom_jitter(width = 0.15, alpha = 0.5) +
  stat_summary(fun = "mean", geom = "point", shape = 18, size = 4, color = "grey") +
  scale_fill_manual(values = c("#61243F", "#D32D7D"))


# 5 Themes () und labs

ggplot(data = bipolar, aes(x = groups, y = mean_ISEL, fill = groups)) +
  geom_boxplot(width = 0.5, alpha = 0.8) +
  geom_jitter(width = 0.15, alpha = 0.5, color = "black") +
  stat_summary(fun = "mean", geom = "point", shape = 18, size = 4, color = "grey") +
  scale_fill_manual(values = c("#61243F", "#D32D7D")) +
  theme_minimal() +
  theme(legend.position = "right",
        plot.title = element_text(hjust = 0.5, vjust = 2)) +
  labs(x = "Gruppen", y = "ISEL Score", title = "Boxplot der ISEL Summenwerte nach Studiengruppe")
  

# Speichern 

jpeg(file = "Bipolar_ISEL.jpg", width = 15, height = 10, units = "cm", res = 300)

ggplot(data = bipolar, aes(x = groups, y = mean_ISEL, fill = groups)) +
  geom_boxplot(width = 0.5, alpha = 0.8) +
  geom_jitter(width = 0.15, alpha = 0.5, color = "black") +
  stat_summary(fun = "mean", geom = "point", shape = 18, size = 4, color = "grey") +
  scale_fill_manual(values = c("#61243F", "#D32D7D")) +
  theme_minimal() +
  theme(legend.position = "right",
        plot.title = element_text(hjust = 0.5, vjust = 2)) +
  labs(x = "Gruppen", y = "ISEL Score", title = "Boxplot der ISEL Summenwerte nach Studiengruppe")

dev.off()

# Korrelation 

?cor
cor(bipolar$sum_YMRS, bipolar$mean_ISEL)
Ergebnis = cor.test(bipolar$sum_YMRS, bipolar$mean_ISEL)


ggplot(data = bipolar, aes(x = mean_ISEL, y = sum_YMRS, color = groups)) + 
  geom_point() + 
  geom_smooth(method = "lm", linewidth = 0.5, alpha = .2) + 
  scale_color_manual(values = c("#61243F", "#D32D7D")) +
  labs(x = "ISEL", y = "YMRS", title = "Zusammenhang zwischen ISEl und YMRS je Gruppe") +
  theme_minimal() +
  theme(
    axis.title.x = element_text(face = "bold", color = "black"),
    axis.title.y = element_text(face = "bold"),
    plot.title = element_text(hjust = 0.5)
  )



str(Ergebnis)
Ergebnis$p.value
Ergebnis$statistic
Ergebnis$conf.int




