rem Copy the model from the model directory to the /docker/app folder
copy "..\models\model.rds" ".\app"

rem build the docker container
docker build -t azure-rmodel-devops .

rem Delete the model.rds file from the local /docker/app directory, we don't want it source controlled there.
del ".\app\model.rds"