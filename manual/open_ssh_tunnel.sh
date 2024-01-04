#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "You have to pass ssh configuration for example 'ubuntu@ip_address -p <PORT>'"
    exit 1
fi

ssh_configuration="$1"

ssh -L 8081:localhost:8081  \
    -L 6432:localhost:6432  \
    -L 8090:localhost:8090  \
    -L 5002:localhost:5002  \
    -L 8082:localhost:8082  \
    -L 7432:localhost:7432  \
    -L 8080:localhost:8080  \
    -L 80:localhost:80 \
    -L 8084:localhost:8084 \
    "$ssh_configuration"