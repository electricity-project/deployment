#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "You have to pass ssh configuration for example 'ubuntu@ip_address -p <PORT>'"
    exit 1
fi

ssh_configuration="$1"

echo "Start uploading central-module"
docker save central-module:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading  calculations-db-access"
docker save calculations-db-access:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading mediative-module"
docker save mediative-module:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading simulation-module"
docker save simulation-module:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading web"
docker save web:dev | ssh -C "$ssh_configuration" docker load
echo "Uploaded all images"

ssh "$ssh_configuration" 'mkdir -p deploy/'
scp docker-compose-manual.yaml "$ssh_configuration":deploy/
ssh "$ssh_configuration" 'docker compose -f deploy/docker-compose-manual.yaml up'