saludame <- function(name){
message <- paste("que es la que?, Bienvenidos", name)
return(message)
}
saludame('Roseliz')




x <- 10
x



a <- c(1,2,3,4,5)
b <- c(6,7,8,9,10)
c <- a + b
c


i <- c(3,520,30,5,20)
i



my_list <- list(
  names= c('Diana', 'Alan', 'Gustavo', 'Edgardo', 'Ariana'),
  favorite_numberw = c(1,2,3,4,5))

my_list



my_matrix <- matrix(
  data = 1:9,
  nrow = 3,
  ncol= 3,
  byrow = F)
my_matrix


intro_r <- data.frame(names = c('A','B','C','D'),
           age = c(25,30,35,40),
           weight = c(60,70,80,90))

class(my_matrix)
#Create data frame

getwd()
setwd("/Users/roseliz")
