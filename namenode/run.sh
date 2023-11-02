#!/bin/bash



configure /etc/hadoop/core-site.xml core CORE_CONF
configure /etc/hadoop/hdfs-site.xml hdfs HDFS_CONF



# HDFS
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.rpc-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.servicerpc-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.http-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.namenode.https-bind-host 0.0.0.0
addProperty /etc/hadoop/hdfs-site.xml dfs.client.use.datanode.hostname true
addProperty /etc/hadoop/hdfs-site.xml dfs.datanode.use.datanode.hostname true




for i in ${SERVICE_PRECONDITION[@]}
do
    wait_for_it ${i}
done



namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

echo "remove lost+found from $namedir"
rm -r $namedir/lost+found

if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
  $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME
fi

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode
