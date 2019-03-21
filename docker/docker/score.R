# Load Model
print(getwd())
print('Loading Model')
model <- readRDS("/app/model.rds")
print(model)

#* Predict weight based on height
#* @param height the user height
#* @get /weight
function(height=0){
  a <- data.frame(x = as.numeric(height))
  result <-  predict(model,a)
  list(response = result)
}