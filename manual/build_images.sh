#!/bin/sh

docker build -t central-module:latest ../../central-module/ --no-cache
docker build -t calculations-db-access:latest ../../calculationsdb-access/ --no-cache
docker build -t mediative-module:latest ../../mediative-module/  --no-cache
docker build -t simulation-module:latest ../../simulation-module/ --no-cache
docker build -t web:latest ../../web/ --no-cache
docker build -t logic:latest ../../logic/ --no-cache
docker build -t real-time-calculations:latest ../../real-time-calculations/ --no-cache
docker build -t prediction-module:latest ../../prediction-module/ --no-cache
echo "Building of images has been completed"



