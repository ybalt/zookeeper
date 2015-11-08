#
# ZooKeeper Dockerfile
#

FROM java:8
MAINTAINER ybaltouski@gmail.com

ENV ZK_VERSION=zookeeper-3.4.6
ENV ZK_TARBALL=${ZK_VERSION}.tar.gz
ENV ZK_CVS_PATH .

RUN mkdir /kafka /data /logs

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/${ZK_VERSION}/${ZK_TARBALL} | tar -xzf - -C /opt \
    && mv /opt/${ZK_VERSION} /zookeeper \
    && mkdir /zookeeper/data

ADD $ZK_CVS_PATH/docker-entrypoint.sh /zookeeper/docker-entrypoint.sh


RUN groupadd -r zookeeper \
  && useradd -c "Zookeeper" -d /zookeeper -g zookeeper -M -r -s /sbin/nologin zookeeper \
  && chown -R zookeeper:zookeeper /zookeeper

RUN chmod +x /zookeeper/docker-entrypoint.sh

EXPOSE 2181 2888 3888

WORKDIR /zookeeper

VOLUME ["/zookeeper/conf", "/zookeeper/data"]

ENTRYPOINT ["/zookeeper/docker-entrypoint.sh"]


