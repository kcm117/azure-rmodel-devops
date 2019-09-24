# Databricks notebook source
library("testthat")
# library("SparkR")

context("Regression Tests Linear Regression Model with Dataset")

# test_env is the test environment global var

# Set model(s) path
if(is_testing()){
  # If testing, get input model directory from test env passed in to script
  base_dir <- test_env$base_dir
  inputmodel_path <- paste(base_dir,"models","model.rds",sep = "/")
  data_test_path <- test_env$data_test_path
  data_train_path <- test_env$data_train_path
} else{
  # else load path manually for interactive/dev test
  inputmodel_path <- "/dbfs/mnt/adls/build/RModel-Repo/454/models/model.rds"
  data_test_path <- "/dbfs/mnt/adls/data/build-test/r_input_file1.csv"
  data_train_path <- "/dbfs/mnt/adls/data/build-test/weight_data.csv"
}

# COMMAND ----------

# Load Input Data
data <- read.csv(data_test_path, header=TRUE)

# Load the Model from Blob Storage
model <- readRDS(inputmodel_path)

# Perform Scoring
x <- data.frame(x = data$height)
y <- predict(model,x) 
data$weight <- y

# Load Training Data
data_t <- read.csv(data_train_path, header=TRUE)

# Calculate Diff
dif <- data.frame(data_t, data)
r_sqr <- cor(dif$weight, dif$weight.1)^2

# COMMAND ----------

# Actual Test Case
# We know that in training the R_Squred is 0.007663
train_r_sqr <- 0.007663
testName <- "Dif R_Sqrs"
test_that(testName, {
  expect_lt(abs(r_sqr - train_r_sqr), 0.001)
})