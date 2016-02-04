# zookeeper

Zookeper Docker image automation cluster-ready

This image is ready for Ansible deploy and Weave network

Docker-compose file to run:
Replace 'zero' to incremental number of machine(in this example 3 hosts)
```
zookeeper:
image: ybalt/zookeeper
container_name: zoo0
expose:
"2181"
"2888"
"3888"
environment:
ZOOKEEPER_ID: 0
ZOOKEEPER_SERVER_0: zoo0:2888:3888
ZOOKEEPER_SERVER_1: zoo1:2888:3888
ZOOKEEPER_SERVER_2: zoo2:2888:3888
```

Docker command-line:

`docker run -d -P -e ZOOKEEPER_ID=0 -e ZOOKEEPER_SERVER_0: zoo0:2888:3888 -e ZOOKEEPER_SERVER_1: zoo1:2888:3888 -e ZOOKEEPER_SERVER_2: zoo2:2888:3888 --name zoo0 ybalt/zookeeper`
