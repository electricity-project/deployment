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
docker save web:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading logic"
docker save logic:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading real-time-calculations"
docker save real-time-calculations:latest | ssh -C "$ssh_configuration" docker load
echo "Start uploading prediction-module"
docker save prediction-module:latest | ssh -C "$ssh_configuration" docker load
echo "Uploaded all images"

ssh "$ssh_configuration" 'mkdir -p deploy/'
scp docker-compose-manual.yaml "$ssh_configuration":deploy/
scp .env "$ssh_configuration":deploy/

ssh "$ssh_configuration" 'mkdir -p deploy/import/'
scp ../import/szoze-realm.json "$ssh_configuration":deploy/import/

ssh "$ssh_configuration" 'docker compose -f deploy/docker-compose-manual.yaml up -d'
#ssh "$ssh_configuration" 'docker compose -f deploy/docker-compose-manual.yaml up central-module calculations-db-access mediative-module simulation-module web logic  real-time-calculations prediction-module -d'

ssh "ssh_configuration" 'docker network connect bridge szoze-system-calculations-db-access-1'
