# Databricks notebook source


# COMMAND ----------

# Get Input Parameters

# Scoring Data Input
# Example Input Path = "/dbfs/mnt/kcmunninstoragev2-databricks/input_files/r_input_file1.csv"
dbutils.widgets.text("inputdata_path", "","")
dbutils.widgets.get("inputdata_path")
inputdata_path = getArgument("inputdata_path")

# Model Input
# dbutils.widgets.text("inputmodel_path","","")
# dbutils.widgets.get("inputmodel_path","inputmodel_path")
# inputmodel_path = getArgument("inputmodel_path")

# Scored File Output
dbutils.widgets.text("outputdata_path", "","")
dbutils.widgets.get("outputdata_path")
outputdata_path = getArgument("outputdata_path")

print(c(inputdata_path, outputdata_path))

# COMMAND ----------

# The command below will remove all databricks notebook widgets, if needed.
# dbutils.widgets.removeAll()

# COMMAND ----------

# Load Input Data
print(inputdata_path)
data <- read.csv(inputdata_path, header=TRUE)
print(data)

# COMMAND ----------

# Load the Model from Blob Storage
inputmodel_path = "/dbfs/mnt/adls/models/model.rds"
model <- readRDS(inputmodel_path)

# COMMAND ----------

# Perform Scoring
x <- data.frame(x = data$height)
y <-  predict(model,x) 
data$weight <- y
print(data)

# COMMAND ----------

# Save output to location
# Example Input Path = "/dbfs/mnt/kcmunninstoragev2-databricks/output_files/r_output_file1.csv"
write.csv(data, file=outputdata_path, row.names=F)