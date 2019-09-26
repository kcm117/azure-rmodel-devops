# Databricks notebook source
# MAGIC %md The notebook reads in the model and does some simple tests and write out the results to a file.

# COMMAND ----------

library("testthat")
context("Unit Tests Linear Regression Model")

# test_env is the test environment global var

# Set model(s) path
if(is_testing()){
  # If testing, get input model directory from test env passed in to script
  base_dir <- test_env$base_dir
  inputmodel_path <- paste(base_dir,"models","model.rds",sep = "/")
} else{
  # else load path manually for interactive/dev test
  inputmodel_path <- "/dbfs/mnt/adlsv2-databricks/build/RModel-Repo/454/models/model.rds"
}

# COMMAND ----------

# Load Model from mounted storage
model <- readRDS(inputmodel_path)

# Create Test Data Frame and Test Prediction
p <- data.frame(height = c(79), weight = c(0))
x <- data.frame(x = p$height)
y <- predict(model, x)
y

# COMMAND ----------

# Unit Test 1
test_that("Output Shape", {
    expect_that(length(y), equals(1))
    expect_that(class(y), equals("numeric"))
})

# COMMAND ----------

# Unit Test 2
test_that("Output Value Two Sides", {
    expect_gt(y[1], 192)
    expect_lt(y[1], 193)
})