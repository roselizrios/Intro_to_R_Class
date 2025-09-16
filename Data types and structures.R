library(datasets)
data('mtcars')
head(mtcars, 3)
View(mtcars)
mtcars


# To examine --------------------------------------------------------------
tail(mtcars, 3)
class(mtcars)
length(mtcars)
nrow(mtcars)
ncol(mtcars)
attributes(mtcars)
str(mtcars)

summary(mtcars)

# Data manipulation -------------------------------------------------------
four <- 4
class(four)


# Vectors -----------------------------------------------------------------
vector()
x <- c(1, 2, 3)
x
class(x)

z <- c("Nataly", "Natalia", "Ariana")
z
class(z)

z <- c(z, "Alan")
z
z <- sort(c(z, "Diana"))
z

# Coercion ----------------------------------------------------------------
y <- c(1, 2, "Edgardo")
y
class(y)

# Create your own vector --------------------------------------------------
a <- seq(1:50)
seq(1, 50, by = 2)
seq(from = 2, to=20, by = 0.2)

a[40]
z[5]

z[-2]
z1 <- z[-2]
z1

series <- 0:100
series

sample(series, 1)
sample(series, 5)
sample(series, 20)
sample(series, 20, replace=TRUE)
sample(series, 20, replace=FALSE)

# Missing values ----------------------------------------------------------
v <- c (1, 2, NA, 4, 5)
mean(v)
mean(v, na.rm = TRUE)

# Matrices ----------------------------------------------------------------
m <- matrix(1:20, nrow = 4, ncol = 5)
m
m <- matrix(1:20, nrow = 4, ncol = 5, byrow = TRUE)
m

x <- c(1, 2, 3, 4, 5)
y <- c(6, 7, 8, 9, 10)
z <- c(11, 12, 13, 14, 15)

matriz <- cbind(x, y, z)
matriz

dim(matriz)

cor(matriz)


# 09/11/2025
df <- data.frame(
  Name= c("Yoda", "R2_D2","Chewbacca", "Obi-Wan Kenobi", "Luke Skywalker"),
  Age= c(900, 36, 235, 57, 53),
  Weight= c(130, 180, 150, 170, 160)
)
df

df[1,]
df[,2]
df[1:3,]
df[1:3, 1]

# Subconjuntos ------------------------------------------------------------
subset <- df[df$Age >234,]
subset

subset(df, Age > 100 & Weight < 200)
subset

df1 <- df[, c("Name", "Age")]
df1

# New Column --------------------------------------------------------------
df$Height <- c (66, 109, 228, 182, 172)
df

df$Jedi <- c(TRUE, FALSE, FALSE, T, T)
df

# New Rows ----------------------------------------------------------------
new_row <- data.frame(Name= "Darth Vader", Age = 45, Weight = 120, Height = 202, Jedi = FALSE)
df <- rbind(df, new_row)
df

# Names -------------------------------------------------------------------

colnames(df) <- c("Character", "Age (yrs)", "Weight (kgs)", "Height (m)", "Jedi")
df

str(df)

df[order(-df$Weight), ]

# Create another small data frame
# Add Darth Vader to df2 with his planet
df2 <- data.frame(
  Character = c("Yoda", "Luke Skywalker", "Chewbacca", "R2_D2", "Obi-Wan Kenobi", "Darth Vader"),
  
  Planet = c("Dragobah", "Tatooine", "Kashyyyk", "Naboo", "Stewjon", "Tatooine")
)
merged_df <- merge(df, df2, by = "Character")
merged_df


# Real World Example ------------------------------------------------------

# Import data to R Studio
devtools::install_github("rstudio/addinexamples", type = "source")

codon_usage <- read.csv("codon_usage.csv")
head(codon_usage)

str(codon_usage) #structure of the data frame

viral <- codon_usage [codon_usage$Kingdom == "vrl", ]
head(viral, 3)

viral_bacteria <- codon_usage [codon_usage$Kingdom %in% c ("vrl", "bct"), ]
viral_bacteria