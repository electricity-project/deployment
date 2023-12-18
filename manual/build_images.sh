#!/bin/sh

docker build -t central-module:latest ../../central-module/ --no-cache
docker build -t calculations-db-access:latest ../../calculationsdb-access/ --no-cache
docker build -t mediative-module:latest ../../mediative-module/  --no-cache
docker build -t simulation-module:latest ../../simulation-module/ --no-cache
docker build -t web:dev -f ../../web/Dockerfile.dev ../../web/ --no-cache
echo "Building of images has been completed"



