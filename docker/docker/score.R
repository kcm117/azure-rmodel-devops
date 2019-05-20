# Load functions from "Model.R" file to be used in WS
print(paste("Working Directory: ",getwd(),sep=""))
source("/app/model.R")

# Load Model
model <- load_model("/app/model.rds")
print(model)

#* Predict weight based on height
#* @param height the user height
#* @get /weight
function(height=0){
  predict_weight(height)
}