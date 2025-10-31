data("DNase")
head(DNase, 3)
mean_density <- aggregate(density ~ conc, data = DNase, FUN = mean)
barplot(
  height = mean_density$density,
  names.arg = mean_density$conc,
  col = "lightblue",
  border = "gray30",
  main = "Mean DNase I Activity by Concentration",
  xlab = "Concentration (mg/mL)",
  ylab = "Mean Optical Density",
  las = 2,
  cex.names = 0.8,
  horiz = TRUE
)

data("co2")
head(co2, 3)
plot(
  co2 ~ time(co2),
  type = "l",
  col = "turquoise",
  lwd = 2,
  xlab = "Year",
  ylab = "CO2 Concentration (ppm)",
  main = "Atmospheric CO2 Concentration (1958 - 1998)"
)

co2_data <- data.frame(
  time = as.numeric(time(co2)),
  co2 = as.numeric(co2)
)

spearman_result <- cor.test(
  co2_data$time,
  co2_data$co2,
  method = "spearman",
  exact = FALSE
)

spearman_result

shapiro.test(co2_data$co2)

plot(
  co2 ~ time(co2),
  type = "l",
  col = "lightgreen",
  lwd = 2,
  xlab = "Year",
  ylab = "CO2 Concentration (ppm)",
  main = "Atmospheric CO2 Concentration (1958 - 1998)"
)

abline(lm(co2_data$co2 ~ co2_data$time), col = "deeppink", lwd = 2, lty = 2)
