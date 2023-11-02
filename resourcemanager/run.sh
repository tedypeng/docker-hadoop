#!/bin/bash


configure /etc/hadoop/yarn-site.xml yarn YARN_CONF
configure /etc/hadoop/httpfs-site.xml httpfs HTTPFS_CONF
configure /etc/hadoop/kms-site.xml kms KMS_CONF
configure /etc/hadoop/mapred-site.xml mapred MAPRED_CONF

# YARN
addProperty /etc/hadoop/yarn-site.xml yarn.resourcemanager.bind-host 0.0.0.0
addProperty /etc/hadoop/yarn-site.xml yarn.nodemanager.bind-host 0.0.0.0
addProperty /etc/hadoop/yarn-site.xml yarn.timeline-service.bind-host 0.0.0.0

# MAPRED
addProperty /etc/hadoop/mapred-site.xml yarn.nodemanager.bind-host 0.0.0.0


$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager
