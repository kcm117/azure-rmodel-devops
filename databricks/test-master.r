# Databricks notebook source
# MAGIC %python
# MAGIC # Repo Name
# MAGIC dbutils.widgets.text("repo_name","","")
# MAGIC 
# MAGIC # Build Number
# MAGIC dbutils.widgets.text("build_number","","")
# MAGIC 
# MAGIC # Test Data Path
# MAGIC dbutils.widgets.text("data_test_path","","")
# MAGIC 
# MAGIC # Training Data Path
# MAGIC dbutils.widgets.text("data_train_path","","")
# MAGIC 
# MAGIC # Notebook Path
# MAGIC dbutils.widgets.text("notebook_path","","")
# MAGIC 
# MAGIC # Get Parameters
# MAGIC repo_name = getArgument("repo_name")
# MAGIC build_number = getArgument("build_number")
# MAGIC data_test_path = getArgument("data_test_path")
# MAGIC data_train_path = getArgument("data_train_path")
# MAGIC notebook_path = getArgument("notebook_path")
# MAGIC 
# MAGIC print('Job Information:')
# MAGIC print('\tNotebook Path: ' + notebook_path)
# MAGIC print('\tRepo Name: ' + repo_name)
# MAGIC print('\tBuild Number: ' + build_number)
# MAGIC print('\tTest Data Path: ' + data_test_path)
# MAGIC print('\tTraining Data Path: ' + data_train_path)

# COMMAND ----------

# MAGIC %python
# MAGIC # Run the Test Notebook(s)
# MAGIC dbutils.notebook.run(notebook_path, 600,
# MAGIC                      {"build_number": build_number,
# MAGIC                       "data_test_path": data_test_path,
# MAGIC                       "data_train_path": data_train_path,
# MAGIC                       "repo_name": repo_name
# MAGIC                      })
