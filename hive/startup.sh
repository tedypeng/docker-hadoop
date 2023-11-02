#!/bin/bash

source /entrypoint.sh

configure /opt/hive/conf/hive-site.xml hive HIVE_SITE_CONF

hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse

cd $HIVE_HOME/bin
./hiveserver2 --hiveconf hive.server2.enable.doAs=false
