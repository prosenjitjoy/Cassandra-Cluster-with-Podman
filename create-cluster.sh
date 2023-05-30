#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

# Check if buildah is present in host os
if [ -z "$(command -v podman)" ]; then
  echo "ERR: podman is not installed"
  echo "RUN: sudo apt install podman"
  exit 1
fi

NET_NAME="cluster"

# Creating net network
podman network create $NET_NAME

# Creating first node
podman run --name nodeX --network cluster --hostname nodeX -m 1.2G -d cassandra:latest
echo "Sleeping for 1 minute"
sleep 60

# Creating second node
podman run --name nodeY --network cluster --hostname nodeY -e CASSANDRA_SEEDS=nodeX -m 1.2G -d cassandra:latest
echo "Sleeping for 1 minute"
sleep 60

# Creating third node
podman run --name nodeZ --network cluster --hostname nodeZ -e CASSANDRA_SEEDS=nodeX,nodeY -m 1.2G -d cassandra:latest
echo "Sleeping for 1 minute"
sleep 60

# Display cluster info
podman exec -it nodeX nodetool status

