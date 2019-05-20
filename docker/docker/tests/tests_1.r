# NOTES
# Run this locally to run a test from the /docker/docker directory"
# test_dir("tests", reporter = JunitReporter$new(file = "junit_result.xml"))

# Load ttestthat
library(testthat)

context("Linear Regression Model")

# Load functions to test
source("../model.R")

# Loading Model
test_that("Load Model", {
    model <- load_model("../model.rds")
    expect_that(class(model), equals("lm"))
})

# Shape of response
test_that("Output Shape of response", {
    result<- predict_weight(height=22, model)
    expect_equal(length(result), 1)
})