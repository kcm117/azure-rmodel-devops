# Databricks notebook source
# Git Update Test
print(R.version.string)

# COMMAND ----------

mount_name = "adlsv2-databricks" # Change this to the mount name in your Databricks workspace

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

# Create Paths
model_dir = paste("/dbfs/mnt/",mount_name,"/models",sep="")
model_name = "model.rds"
model_path = paste(model_dir,"/",model_name,sep="")

dir.create(model_dir) # Directory must be created first if it does not exist, or saveRDS will fail

# Save the model to blob storage
model_path = paste("/dbfs/mnt/",mount_name,"/models/model.rds",sep="")

saveRDS(model, model_path)

# COMMAND ----------

# View model details
print(model)

# COMMAND ----------

print('Completed')