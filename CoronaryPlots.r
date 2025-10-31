library(readxl)

coronary <- read_excel("Assignments/coronary.xlsx")
head(coronary, 3)

plot(
  coronary$dbp ~ coronary$chol,
  type = 'p',
  col = "skyblue",
  lwd = 2,
  xlab = "Total Cholesterol (mmol/L)",
  ylab = "Diastolic Blood Pressure (mmHg)",
  main = "Relationship between Cholesterol and Diastolic BP"
)

spearman_result <- cor.test(
  coronary$chol,
  coronary$dbp,
  method = "spearman",
  exact = FALSE
)

spearman_result

shapiro.test(coronary$chol)

shapiro.test(coronary$dbp)

plot(
  coronary$dbp ~ coronary$chol,
  type = "p",
  col = "blue4",
  lwd = 2,
  xlab = "Total Cholesterol (mmol/L)",
  ylab = "Diastolic Blood Pressure (mmHg)",
  main = "Relationship between Cholesterol and Diastolic BP"
)

abline(lm(dbp ~ chol, data = coronary), col = "turquoise", lwd =2, lty = 2)

coronary <- coronary[order(coronary$age), ]

plot(coronary$age, coronary$chol,
     type = "l",
     col = "deeppink4",
     lwd = 2,
     xlab = "Age (years)",
     ylab = "Cholesterol (mmol/L)",
     main = "Cholesterol vs Age"
     )

hist(coronary$chol,
     main = "Distribution of Cholesterol",
     xlab = "Cholesterol (mmol/L)",
     col = "lightblue1",
     border = "white",
     )

boxplot(coronary$chol,
         main = "Cholesterol Levels",
         ylab = "Cholesterol (mmol/L)",
         col = "lightgreen",
         border = "darkgreen"
         )

boxplot(sbp ~ gender,
        data = coronary,
        main = "Systolic Blood Pressure by Age Group",
        xlab = "Age Group (years)",
        ylab = "Systolic BP (mmHg)",
        col = "lightblue",
        border = "darkblue"
        )
anova_model <- aov (sbp ~ gender, data = coronary)
summary(anova_model)

shapiro.test(residuals(anova_model))

bartlett.test(sbp ~ gender, data = coronary)
