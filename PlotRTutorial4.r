install.packages("ggplot2")
library(ggplot2)

install.packages("car")
library(car)

library(dplyr)

tyre <- read.csv("Assignments/tyre.csv")
head(tyre)
View(tyre)

p <- ggplot(tyre, aes(x = Brands, y = Mileage, fill = Brands)) +
  geom_violin() +
  scale_fill_manual(values = c('pink', 'aquamarine2', 'lavender', 'skyblue')) +
  theme_classic() +
  labs(fill = "Brands", title = "Tires in Puerto Rico", x="Tire Brands", y="Mileage") +
  theme(plot.title = element_text(size = 18,
                                  face = "bold",
                                  hjust = 0.5,
                                  color = "lightpink4")) +
  theme(axis.title.y = element_text(size = 14,
                                    face = "bold",
                                    color = "lightpink3"),
        axis.text.y = element_text(size = 10,
                                   face = "plain",
                                   color = "black")) +
  theme(axis.title.x = element_text(size = 14,
                                    face = "bold",
                                    color = "lightpink3"),
        axis.text.x = element_text(size = 10,
                                   face = "plain",
                                   color = "black")) +
  theme(legend.position = "none") +
  ylim(25,45)

# ANOVA -------------------------------------------------------------------
mod <- aov(Mileage ~ Brands, data = tyre)
summary(mod)

#Hay diferencias y el pi value es bien pequeño, por lo tanto es significativo.

resid_anova <- resid(mod)
resid_anova

shapiro.test(resid_anova)
#Shapiro nos indica que hay una distribución normal de los residuales y por lo tanto se acepta la hipótesis nula de los residuos

car::leveneTest(Mileage ~ Brands, data = tyre)

TukeyHSD(mod)


# How to save plot --------------------------------------------------------
p
ggsave(filename = "plot.png",
       plot = p,
       width = 8, height = 6, dpi = 300)