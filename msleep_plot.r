install.packages("xaringanExtra")
install.packages("ggpubr")
install.packages("ggpmisc")
install.packages("ggbeeswarm")
install.packages("broom")
install.packages("ggstatsplot")

library(ggplot2)
library(dplyr)
library(ggpubr)
library(ggpmisc)
library(ggbeeswarm)
library(broom)
library(ggstatsplot)

head(msleep)

ggplot(msleep,
       aes(x=log(bodywt),
           y=sleep_total,
           color=vore)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE) +
  scale_color_manual( values = c("herbi" = "#CBD3AD",
                                 "carni" = "#F9C5C7",
                                 "omni" = "#C4DFE5",
                                 "insecti" = "#FFC697",
                                 "NA" = "#C8CEEE"))
unique(msleep$vore)
my.formula = y ~ x
ggplot(msleep,
       aes(x = log(bodywt),
           y = sleep_total,
           color = vore)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE) +
  stat_poly_eq(formula = my.formula,
               parse = TRUE,
               label.y = "top",
               label.x = "left",
               use_label(c("eq", "R2", "P"))) +
  facet_wrap(. ~ vore, ncol = 3, scales ="free") +
  theme_bw(16) +
  theme(
    strip.background = element_rec
  )
