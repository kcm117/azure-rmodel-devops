# Databricks notebook source
print(R.version.string)

# COMMAND ----------

mount_name = "adls" # Change this to the mount name in your Databricks workspace

# COMMAND ----------

# Load Training Data
path = paste("/dbfs/mnt/",mount_name,"/data/train/weight_data.csv",sep="")
print(paste("Reading file from",path))

data<-read.csv(path, header=TRUE)

# The predictor vector (height).
x <- data$height
# The response vector (weight).
y <- data$weight
# Apply the lm() function.
model <- lm(y~x)

# COMMAND ----------

data

# COMMAND ----------

# Make Predictions
df_test_heights <- data.frame(x = as.numeric(c(115,20)))
result <-  predict(model,df_test_heights)
print(result)

# COMMAND ----------

# Save the model to blob storage
model_path = paste("/dbfs/mnt/",mount_name,"/models/model.rds",sep="")
saveRDS(model, model_path)

# COMMAND ----------

# View model details
print(model)

# COMMAND ----------

print('Completed')