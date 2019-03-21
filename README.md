# rmodel-container-sample

This is an example project for an R model.  It contains:
- Databricks Notebooks
- Web Service (via Plumber in Docker Container)

**Databricks Notebooks**

There are separate training and scoring notebooks.  The training notebook leverages data stored in Azure Blob Storage and stores the trained, serialized model in Azure Blob Storage.  The scoring notebook loads the serialized model and scores data from a parameterized Azure Blob Storage location.  The notebook can be scheduled as a Databricks job or leveraged in a more expansive pipeline via Azure Data Factory.

**Web Service**

The service leverages the same model built in Azure Databricks, but exposes it as a REST API via Plumber.  All artifacts needed to build the container are in the /docker directory.  commits to this directory trigger a pipeline in Azure DevOps to build the container and store it in an Azure Container Registry.  From there, it can be manually pulled or deployed to various targets via a CD pipeline.

Test Case for the container web service:

Parameters are passed in the URL.  Below, height is the parameter and /weight is the endpoint.  Pass in a height value (x) to recieve a weight value (Y).

http://localhost:8000/weight?height=138

The response object is a JSON array with the format:

{
    "response": [
        161.8533
    ]
}

Please note that the model is created to demonstrate the deployment process, not to be a satisfactory or realistic weight prediction model.

**Links:**
- https://www.rplumber.io/docs/hosting.html#docker
- https://docs.azuredatabricks.net/api/latest/workspace.html#export
- https://docs.azuredatabricks.net/user-guide/notebooks/github-version-control.html#github-version-control



