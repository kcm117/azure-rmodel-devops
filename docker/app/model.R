load_model <- function(path=""){
model <- readRDS(path)
return(model)
}

predict_weight <- function(height=0,model){
  a <- data.frame(x = as.numeric(height))
  result <-  predict(model,a)
  response <- list(response = result)
  
  # Intentional Error
  return(c(1,2,3,4,5,6,7,8,9,10))
  # Correct Code
  #return(response)
}