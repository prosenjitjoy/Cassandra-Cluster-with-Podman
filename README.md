# Cassandra-Cluster-with-Podman
Cassandra cluster setup guide using podman

# 🚀 Manual:

### Step 1
Create separate network for you Cassandra nodes
```bash
podman network create cluster
```

### Step 2
Add the first node of cassandra cluster. Then wait a minute for the node to configure itself.
```bash
podman run --name nodeX --network cluster --hostname nodeX -m 1.2G -d cassandra:latest
sleep 60
```
### Step 3
Add the second node of cassandra cluster. Then wait a minute for the node to configure itself.
```bash
podman run --name nodeY --network cluster --hostname nodeY -e CASSANDRA_SEEDS=nodeX -m 1.2G -d cassandra:latest
sleep 60
```

### Step 4
Add the third node of cassandra cluster. Then wait a minute for the node to configure itself.
```bash
podman run --name nodeZ --network cluster --hostname nodeZ -e CASSANDRA_SEEDS=nodeX,nodeY -m 1.2G -d cassandra:latest
sleep 60
```
### Step 5
To view your cluster setup run the following using any node. For this example I used NodeX.
```bash
podman exec -it NodeX nodetool status
```
output is similar to this one
```bash
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  10.89.0.4  25.57 KiB   16      76.0%             ea8d0755-3292-4730-b737-7be1994e0e2f  rack1
UN  10.89.0.2  109.38 KiB  16      64.7%             e84c3b9c-e03e-474e-a931-9aae4e0ed16c  rack1
UN  10.89.0.3  104.36 KiB  16      59.3%             841f54f4-bcac-4944-8516-933ca231da04  rack1
```

# 🧞 Automatic
Clone this repo and cd into it. Then run the following commands and you are done.
```
chmod +x ./create-cluster.sh
./create-cluster.sh
```