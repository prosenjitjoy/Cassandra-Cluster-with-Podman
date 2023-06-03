# Cassandra-Cluster-with-Podman
Cassandra single datacenter or multi datacenter cluster setup guide using podman

### Step 1
Clone this repo and cd into it.
```
git clone https://github.com/prosenjitjoy/Cassandra-Cluster-with-Podman.git
cd Cassandra-Cluster-with-Podman
```
### Step 2a
Run the following commands and if you want to setup 3 node single datacenter cluster. SimpleSnitch is enabled by default. So, the cluster is not rack aware.
```
chmod +x ./single-datacenter.sh
./single-datacenter.sh
```
Cluster status is similar to this one.
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
### Step 2b
Run the following commands and if you want to setup multi datacenter cluster each having 2 nodes. GossipingPropertyFileSnitch is enabled. So, the cluster is rack aware.
```
chmod +x ./multi-datacenter.sh
./multi-datacenter.sh
```
Cluster status is similar to this one.
```bash
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  10.89.0.2  109.42 KiB  16      48.8%             9977d520-df64-4578-b20d-f8b71338632a  rack1
UN  10.89.0.3  75.19 KiB   16      50.5%             54c76e0a-73b0-40e9-82bd-da255090186b  rack2

Datacenter: datacenter2
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  10.89.0.4  70.24 KiB   16      48.7%             3dc86058-005d-4a8f-8af6-66268bea9f06  rack1
UN  10.89.0.5  109.25 KiB  16      52.0%             84138b43-c6e9-4e8e-a81b-34fb6b206ed1  rack2
```