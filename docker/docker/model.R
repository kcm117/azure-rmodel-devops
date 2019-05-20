load_model <- function(path=""){
model <- readRDS(path)
return(model)
}

predict_weight <- function(height=0,model){
  a <- data.frame(x = as.numeric(height))
  result <-  predict(model,a)
  response <- list(response = result)
  return(response)
}