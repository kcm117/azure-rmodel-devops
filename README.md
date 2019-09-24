# azure-rmodel-devops

This is an example project for an operationalized R model on Azure.  It contains:
- Databricks Notebooks (Training and Batch Scoring)
- Azure Data Factory (Event Based Batch Scoring)
- Request/Response Web Service (via Plumber in Docker Container)
- Azure DevOps Build and Release Pipelines (CI/CD)

# **Databricks Notebooks**

There are separate training and scoring notebooks.  The training notebook leverages data stored in Azure Blob Storage and stores the trained, serialized model in Azure Blob Storage.  The scoring notebook loads the serialized model and scores data from a parameterized Azure Blob Storage location.  The notebook can be scheduled as a Databricks job or leveraged in a more expansive pipeline via Azure Data Factory.

//todo - Write description of how to run the model in a batch process (parameterized Databricks notebook via ADF) or ad-hoc scoring.

# **Web Service**

## Build

The serialized R Model is manually copied from Azure Blob Storage to a local directory to be included in the git repo. The following files and directories are used to build the container image:

- **/docker** - contains all files needed to build container image
- **/docker/Dockerfile** - Container build instructions
- **/docker/sample-service-deployment-kubernetes.yaml** (contains service definition for Kubernetes deployments)
- **/docker/app/** - contains all files that will be copied into the container image.  Scoring scripts using [plumber](https://www.rplumber.io/) were written to expose the model as a rest API.

Commits/changes to the **/docker** directory trigger a pipeline in Azure DevOps to build the container and store it in an Azure Container Registry.  From there, it can be manually pulled or deployed to various targets via a CD pipeline.

## Unit Testing

Unit tests for the containerized R model are located in **/docker/test/tests_1.r**.  Tests are performed with the [testthat](https://testthat.r-lib.org/) package.  Unit tests are ran inside the container environment and test results are written in the JUnit format (compatible with Azure DevOps reporting) to the **/app/test-result/junit_result.xml** path in the container.  The unit tests are simply check the model type and output format.

## Post-Deployment Testing

Test Case for the container web service:

Parameters are passed in the URL.  Below, height is the parameter and /weight is the endpoint.  Pass in a height value (x) to recieve a weight value (Y).

http://localhost:8000/weight?height=138

The response object is a JSON array with the format:
```
{
    "response": [
        161.8533
    ]
}
```

Please note that the model is created to demonstrate the deployment process, not to be a satisfactory or realistic weight prediction model.

# **CI/CD Process - Azure DevOps**

//todo - Write description, with screenshots.

**Links:**
- https://www.rplumber.io/docs/hosting.html#docker
- https://docs.azuredatabricks.net/api/latest/workspace.html#export
- https://docs.azuredatabricks.net/user-guide/notebooks/github-version-control.html#github-version-control



