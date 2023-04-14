#!/bin/bash
if [ $# -lt 1 ]
then
    echo "No Args Input..."
    exit ;
fi

case $1 in
"start")
        echo " =================== 启动 hadoop集群 ==================="

        echo " --------------- 启动 hdfs ---------------"
        {{ hadoop_install_dir }}/hadoop-3.2.2/sbin/start-dfs.sh
        echo " --------------- 启动 yarn ---------------"
        {{ hadoop_install_dir }}/hadoop-3.2.2/sbin/start-yarn.sh
;;
"stop")
        echo " =================== 关闭 hadoop集群 ==================="

        echo " --------------- 关闭 yarn ---------------"
        {{ hadoop_install_dir }}/hadoop-3.2.2/sbin/stop-yarn.sh
        echo " --------------- 关闭 hdfs ---------------"
        {{ hadoop_install_dir }}/hadoop-3.2.2/sbin/stop-dfs.sh
;;
*)
    echo "Input Args Error..."
;;
esac