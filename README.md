# azure-rmodel-devops

This is an example project for an operationalized R model on Azure.  It contains:
- Databricks Notebooks (Training and Batch Scoring)
- Azure Data Factory (Event Based Batch Scoring)
- Request/Response Web Service (via Plumber in Docker Container)
- Azure DevOps Build and Release Pipelines (CI/CD)

Services Used:
- Azure DevOps
- Azure Databricks
- Azure Data Lake Gen2 (referred to as ADLS Gen2)
- Azure Data Factory (referred to as ADF)
- Azure Container Registry (referred to as ACR)
- Azure Kubernetes Service (referred to as AKS)
- Azure Key Vault

For a more detailed walkthrough, please see the associated blog post on my website at [https://www.kcmunnings.com/azure-rmodel-devops-1/](https://www.kcmunnings.com/azure-rmodel-devops-1/).  The goal of this repo is to demonstrate some capabilities for operationalizing a R model on Azure (Source Control + Testing + CI + CD).

# **Databricks Notebooks**

There are separate training and inference notebooks.  The inference notebooks have associated test notebooks (not model testing such as calculating accuracy on a test data set, but unit and model evaluation tests).

## Training

The training notebook is focused on interactive development.  It represents a notebook in which a data scientist is actively creating a model against a set of data.  Once a model with satisfactory is created, the output of this notebook is a serialized model (.rds) file which is stored in ADLS Gen2 and the git repo.

## Inference

The inference notebook loads the serialized model and scores data from a file at a parameterized ADLS Gen2 location.  The notebook can be scheduled as a Databricks job or leveraged externally by another service such as Azure Data Factory.  In this repo, we use the parameterized inference notebook which loads a .csv file from storage, predicts a value stored in an additional column, and writes the results to a .csv file in ADLS Gen2.  This notebook, along with a trained model are the artifacts which are "deployed" to another environment.

The inference notebook has associated testing notebooks.  These notebooks use the [testthat](https://testthat.r-lib.org/) library to perform unit testing (and any other testing the data scientist determines as criteria for pass/fail to higher environments).  In this case, we do some simple tests on the output of the scoring function and verify that the R-squared of the model is within an acceptable, arbitrary range

## Git integration

Databricks does have native integration with GitHub, BitBucket and Azure DevOps as of the time of this writing.  However, I have chosen to use the Databricks cli tool to import/export notebooks to my local machine and perform commits and pushes from there to have more control.  One area where this was more convenient was with including the serialized model.rds file in the repo, as I could manually import it into the repo locally and commit/push since arbitrary files cannot be managed in a Databricks workspace.  After the model.rds file was produced in Databricks by the training notebook, I copied it from ADLS Gen2 using the Azure Storage Explorer tool into the /models directory repo locally.

# **Azure Data Factory**

Azure Data Factory is used to operationalize the inference notebook in Azure Databricks as a batch job.  The goal is for an end user or application to simply upload a file into ADLS Gen2, and have the inference process (parameterized Databricks notebook) trigger automatically and output a file with predictions into another directory.  This functionality is achieved in ADF using a pipeline with a parameterized Databricks execute notebook step, which is triggered by a storage event.


# **Web Service (Container)**

- **/docker** - contains all files needed to build container image
- **/docker/Dockerfile** - Container build instructions
- **/docker/kubernetes-deployment.yaml** (contains service definition for Kubernetes deployments)
- **/docker/app/** - contains all files that will be copied into the container image.  Scoring scripts using [plumber](https://www.rplumber.io/) were written to expose the model as a rest API.


Containers are built and stored in Azure Container Registry, then they are deployed to Azure Kubernetes Service to run as a web service.

## Unit Testing

Unit tests for the containerized R model are located in **/docker/test/tests_1.r**.  Tests are performed with the [testthat](https://testthat.r-lib.org/) package.  Unit tests are ran inside the container environment and test results are written in the JUnit format (compatible with Azure DevOps reporting) to the **/app/test-result/junit_result.xml** path in the container.  The unit tests are simply check the model type and output format.

## Post-Deployment Testing (Manual)

Test Case for the container web service:

Parameters are passed in the URL.  Below, height is the parameter and /weight is the endpoint.  Pass in a height value (x) to receive a weight value (Y).

http://localhost:8000/weight?height=138

The response object is a JSON array with the format:
```
{
    "response": [
        161.8533
    ]
}
```

Please note that the model is created to demonstrate the deployment and CI/CD process, not to be a satisfactory or realistic weight prediction model.

# **CI/CD Process - Azure DevOps**

Build and release pipelines are created in Azure DevOps.  There are separate build and release pipelines for Databricks (which includes ADF components) and Container components.  These pipelines all have different triggers based on different pull requests which include changes in corresponding subdirectories (/docker, /databricks, /adf, etc).

More detailed descriptions of the pipelines can be found in the blog posts.  They are included in the /devops directory of the repo and can be imported into Azure DevOps, but they will have to be heavily edited as they contain references to resources in my Azure subscription.

**Reference Links:**

Azure DevOps
- https://docs.microsoft.com/en-us/azure/devops/user-guide/what-is-azure-devops?view=azure-devops

Containers
- https://www.rplumber.io/docs/hosting.html#docker
- https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro
- https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes

Databricks
- https://docs.azuredatabricks.net/
- https://docs.azuredatabricks.net/api/latest/workspace.html#export
- https://docs.azuredatabricks.net/user-guide/notebooks/github-version-control.html#github-version-control

ADF
- https://docs.microsoft.com/en-us/azure/data-factory/
- https://docs.microsoft.com/en-us/azure/data-factory/transform-data-using-databricks-notebook



