#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

if [ -z "$(command -v podman)" ]; then
  echo "ERR: podman is not installed"
  echo "RUN: sudo apt install podman"
  exit 1
fi

NET_NAME="multi-datacenter"

# Creating net network
podman network create $NET_NAME

# Datacenter1 nodes
podman run --name nodeA1 --network $NET_NAME --hostname nodeA1 -v ./cassandra.yaml:/etc/cassandra/cassandra.yaml -e CASSANDRA_DC=datacenter1 -e CASSANDRA_RACK=rack1 -m 1.8G -d cassandra:latest
echo "Sleeping for 60 second"
sleep 60

podman run --name nodeA2 --network $NET_NAME --hostname nodeA2 -v ./cassandra.yaml:/etc/cassandra/cassandra.yaml -e CASSANDRA_DC=datacenter1 -e CASSANDRA_RACK=rack2 -e CASSANDRA_SEEDS=nodeA1 -m 1.8G -d cassandra:latest
echo "Sleeping for 60 second"
sleep 60

# Datacenter2 nodes
podman run --name nodeB1 --network $NET_NAME --hostname nodeB1 -v ./cassandra.yaml:/etc/cassandra/cassandra.yaml -e CASSANDRA_DC=datacenter2 -e CASSANDRA_RACK=rack1 -e CASSANDRA_SEEDS=nodeA1 -m 1.8G -d cassandra:latest
echo "Sleeping for 60 second"
sleep 60

podman run --name nodeB2 --network $NET_NAME --hostname nodeB2 -v ./cassandra.yaml:/etc/cassandra/cassandra.yaml -e CASSANDRA_DC=datacenter2 -e CASSANDRA_RACK=rack2 -e CASSANDRA_SEEDS=nodeA2,nodeB1 -m 1.8G -d cassandra:latest
echo "Sleeping for 60 second"
sleep 60

# Display cluster info
podman exec -it nodeA1 nodetool status
