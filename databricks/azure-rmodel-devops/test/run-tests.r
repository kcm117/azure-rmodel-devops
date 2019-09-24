# Databricks notebook source
# Get Input Parameters
# Example Path = "/dbfs/mnt/kcmunninstoragev2-databricks/input_files/r_input_file1.csv"

# Repo Name
dbutils.widgets.text("repo_name","","")
# dbutils.widgets.get("repo_name")

# Build Number
dbutils.widgets.text("build_number","","")
# dbutils.widgets.get("build_number")

# Test Data Path
dbutils.widgets.text("data_test_path","","")

# Training Data Path
dbutils.widgets.text("data_train_path","","")

# COMMAND ----------

library("testthat")

# Get Parameters
repo_name = getArgument("repo_name")
build_number = getArgument("build_number")
data_test_path = getArgument("data_test_path")
data_train_path = getArgument("data_train_path")

# Base Directory
base_dir = paste("/dbfs/mnt/adls/build",repo_name,build_number,sep = "/")

# Test Cases
test_case_dir_unit = paste(base_dir,"test","unit-test-cases",sep="/")
test_case_dir_model = paste(base_dir,"test","model-test-cases",sep="/")

# Test Output
test_output_file_unit = paste(base_dir,"test-result","unit_test_result.xml",sep="/")
test_output_file_model = paste(base_dir,"test-result","model_test_result.xml",sep="/")

# Model Directory
model_dir <- paste(base_dir,"models",sep = "/")

# COMMAND ----------

print("Logging Info:")
print("**********")
print("Repo Name and build number")
print(repo_name)
print(build_number)
print("Test and training data path")
print(data_test_path)
print(data_train_path)
print("Base Directory")
print(base_dir)
print("Unit Test Directory and Model Test Directory")
print(test_case_dir_unit)
print(test_case_dir_model)
print("Unit Test Output Path and Model Test Output Path")
print(test_output_file_unit)
print(test_output_file_model)
print("Model Directory")
print(model_dir)

# COMMAND ----------

# Set environment variables for test execution

# Create new test env
test_env <- new.env()

# Set variables for test environment
test_env$base_dir <- base_dir
test_env$model_dir <- model_dir
test_env$data_test_path <- data_test_path
test_env$data_train_path <- data_train_path

# RUN ALL TESTS

# Run unit tests
test_dir(test_case_dir_unit, env=test_env, reporter = JunitReporter$new(file = test_output_file_unit))

# Run model tests
test_dir(test_case_dir_model, env=test_env, reporter = JunitReporter$new(file = test_output_file_model))