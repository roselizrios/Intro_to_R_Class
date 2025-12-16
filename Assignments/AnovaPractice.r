#ANOVA Example with RTutor
library(tidyverse)

data <- read.csv("ANOVA_Data.csv")
head(data)

p <- ggplot(data, aes(x = songType, y = NsongsPre, fill = songType)) + 
  geom_boxplot(alpha = 0.7) + 
  geom_jitter(width = 0.1, size = 3) + 
  theme_minimal(base_size = 14) + 
  labs( x = "Treatment", y = "Songs (Post – Pre)", title = "Song Response by Treatment" ) + 
  theme(legend.position = "none")
p

anova <- aov(NsongsPre ~ songType, data)
anova
summary(anova)