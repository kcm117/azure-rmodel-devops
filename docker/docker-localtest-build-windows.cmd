rem Copy the model from the model directory to the /docker/app folder
copy "..\models\model.rds" ".\app"

rem build the docker container
docker build -t azure-rmodel-devops .

rem Delete the model.rds file from the local /docker/app directory
rem We don't want a copy of our model file to be source controlled in another directory.
del ".\app\model.rds"