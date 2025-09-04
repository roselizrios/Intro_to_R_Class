#Intro to R Lesson
#August 2025 Material

#Interacting with R

#This is a comment explaining the next line...
#Link to something in GitHub
3 + 4 #Anything written on the code editor is shown in the console after you use command enter (mac)

3 + 3 #Added 3 to prevent errors but it was meant to show only 3 +
#The console always shows ">" when ready for a new command, but if you type something incomplete like the equation above, it will show "+" as it is waiting for instructions
#To cancel "+', you need to go into the console and do "Esc" right next to the "+"
#A new ">" is going to be generated

#This "#" is a comment used to explain what the code does

#R Grammar
greet <- function(name) {
  message <- paste("Hello,", name) #paste
  return(message)
}
#Call the function using = for the argument
greet(name = "Roseliz")

#<- vs = in R
#<- is used to assign values to VARIABLES
x <- 10
x  
  #It is important to hit run and/or command enter!!
#= is used to assign values to ARGUMENTS
mean(x = c(1,2,3))

#There are 5 types of R objects
  #Vectors - sequence of elements of the same type
    a <- c(1,2,3,4,5)
    b <- c(6,7,8,9,10)
      
    c <- (a+b)
    c
    c <- (a*b)
    c
    
    e <- c(3,2,20,25,5)
    sort(e)
  
  #Factors
    f <- factor(c("low", "medium", "high", "very high"))
  #Lists
    my_list <- list(
      Numbers = c(1, 2, 3, 4, 5), #A numeric vector
      Words =c("apple", "banana", "cherry"))
  #Matrices
    my_matrix <- matrix(
      data = 1:9,
      nrow = 3,
      ncol = 3,
      byrow = TRUE)
  #Data frames
    data.frame(name = c("A", "B"), age = c(30, 25))