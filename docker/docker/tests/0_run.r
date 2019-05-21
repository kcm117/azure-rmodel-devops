list.of.packages <- c("xml2", "testthat")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages,quiet=TRUE)

library(testthat)
library(xml2)
pinrt('***** Begin Tests *****')
test_dir('/app/tests', reporter = JunitReporter$new(file = '/app/test-result/junit_result.xml'))
pinrt('***** Test Completed *****')