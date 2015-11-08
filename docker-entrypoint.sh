#! /usr/bin/env bash

# Fail hard and fast
set -eo pipefail

ZK_PATH=/zookeeper

ZOOKEEPER_ID=${ZOOKEEPER_ID:-1}
echo "ZOOKEEPER_ID=$ZOOKEEPER_ID"

echo $ZOOKEEPER_ID > ${ZK_PATH}/data/myid

ZOOKEEPER_TICK_TIME=${ZOOKEEPER_TICK_TIME:-2000}
echo "tickTime=${ZOOKEEPER_TICK_TIME}" > ${ZK_PATH}/conf/zoo.cfg
echo "tickTime=${ZOOKEEPER_TICK_TIME}"

ZOOKEEPER_INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-10}
echo "initLimit=${ZOOKEEPER_INIT_LIMIT}" >> ${ZK_PATH}/conf/zoo.cfg
echo "initLimit=${ZOOKEEPER_INIT_LIMIT}"

ZOOKEEPER_SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-5}
echo "syncLimit=${ZOOKEEPER_SYNC_LIMIT}" >> ${ZK_PATH}/conf/zoo.cfg
echo "syncLimit=${ZOOKEEPER_SYNC_LIMIT}"

echo "dataDir=${ZK_PATH}/data" >> ${ZK_PATH}/conf/zoo.cfg

ZOOKEEPER_CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT:-2181}
echo "clientPort=${ZOOKEEPER_CLIENT_PORT}" >> ${ZK_PATH}/conf/zoo.cfg

ZOOKEEPER_CLIENT_CNXNS=${ZOOKEEPER_CLIENT_CNXNS:-60}
echo "maxClientCnxns=${ZOOKEEPER_CLIENT_CNXNS}" >> ${ZK_PATH}/conf/zoo.cfg
echo "maxClientCnxns=${ZOOKEEPER_CLIENT_CNXNS}"

ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT:-3}
echo "autopurge.snapRetainCount=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT}" >> ${ZK_PATH}/conf/zoo.cfg
echo "autopurge.snapRetainCount=${ZOOKEEPER_AUTOPURGE_SNAP_RETAIN_COUNT}"

ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL:-0}
echo "autopurge.purgeInterval=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL}" >> ${ZK_PATH}/conf/zoo.cfg
echo "autopurge.purgeInterval=${ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL}"

for VAR in `env`
do
  if [[ $VAR =~ ^ZOOKEEPER_SERVER_[0-9]+= ]]; then
    SERVER_ID=`echo "$VAR" | sed -r "s/ZOOKEEPER_SERVER_(.*)=.*/\1/"`
    SERVER_IP=`echo "$VAR" | sed 's/.*=//'`
    echo "server.${SERVER_ID}=${SERVER_IP}" >> ${ZK_PATH}/conf/zoo.cfg
    echo "server.${SERVER_ID}=${SERVER_IP}"
  fi
done
echo '----------Generated config----------'
cat ${ZK_PATH}/conf/zoo.cfg


su zookeeper -s /bin/bash -c "/zookeeper/bin/zkServer.sh start-foreground"
