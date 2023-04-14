### 注意事项

1. 此脚本仅测试过安装流程，未同BAP服务进行联调，可能需要进行适配

2. 执行安装脚本的用户需要有sudo免密权限，并能ssh免密登录其他主机

3. 关闭防火墙和Selinux

4. 安装通过Ansible进行，可通过BAP的安装脚本提前安装

   ```
   [root@bap-1 data]# cd bap-install
   [root@bap-1 bap-install]# bin/00_init.sh
   ```

5. Hive的元数据存储在PG数据库，可通过BAP的安装脚本提前安装PG数据库(可不执行01、02、03脚本)

   ```
   [root@bap-1 bap-install]# bin/04_pg.sh
   ```

6. 安装的大数据平台启用了Kerberos认证，提供bap用户进行认证，密码admin，keytab文件/etc/security/keytabs/bap.keytab



### 安装流程

1. 配置修改

   根据具体环境信息修改安装配置文件

   ```
   [root@bap-1 hadoop-install]# vi conf/hosts
   ```

   

2. 安装Jdk

   Jdk版本为openjdk1.8，安装路径位于/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64

   ```
   [root@bap-1 hadoop-install]# bin/01_jdk.sh
   ```

   可通过 `java -version`命令检查是否安装成功

   

3. 安装Zookeeper

   Zookeeper版本为3.7.0，安装路径可自行配置

   ```
   [root@bap-1 hadoop-install]# bin/02_zookeeper.sh
   ```

   在所有安装节点，进入Zookeeper安装路径，执行命令`bin/zkServer.sh status`，如果出现1个leader，其余均为follower，则安装成功。可通过以下命令启动、停止、重启Zookeeper服务

   ```
   [root@bap-1 zookeeper-3.7.0]# bin/zkServer.sh start
   [root@bap-1 zookeeper-3.7.0]# bin/zkServer.sh stop
   [root@bap-1 zookeeper-3.7.0]# bin/zkServer.sh restart
   ```

   

4. 安装Kerberos

   ```
   [root@bap-1 hadoop-install]# bin/03_kerbeos.sh
   ```

   Kerberos安装后在Server节点会启动三个服务，通过以下命令检查服务是否是active状态

   ```
   [root@bap-1 hadoop-install]# systemctl status slapd
   [root@bap-1 hadoop-install]# systemctl status krb5kdc
   [root@bap-1 hadoop-install]# systemctl status kadmin
   ```

   确认keytabs文件已经生成并拷贝到所有节点/etc/security/keytabs目录下，确认bap用户可以登录成功

   ```
   [root@bap-1 hadoop-install]# ll /etc/security/keytabs
   [root@bap-1 hadoop-install]# kinit -kt /etc/security/keytabs/bap.keytab bap
   ```

   

5. 安装Hadoop

   Hadoop版本为3.2.2，安装路径可自行配置，Hadoop超级用户可自行配置

   ```
   [root@bap-1 hadoop-install]# bin/04_hadoop.sh
   ```

   Hadoop集群启用了NameNode HA和ResourceManager HA，通过`jps`命令查看集群各节点Hadoop服务进程是否存在，进程包括：NameNode、DataNode、ResourceManager、NodeManager、ZKFC等。网页端访问NameNode节点9870/50070端口，ResourManager节点8088端口，确认Web服务正常。

   通过以下命令可重启Hadoop集群

   ```
   [root@bap-1 hadoop-3.2.2]# sbin/stop-all.sh
   [root@bap-1 hadoop-3.2.2]# sbin/start-all.sh
   ```

   

6. 安装Hive

   Hive版本为2.3.8，安装路径可自行配置

   ```
   [root@bap-1 hadoop-install]# bin/05_hive.sh
   ```

   Hive安装完成后会启动Metastore服务和HiveServer2服务，可通过以下命令查看这两个服务是否正常，以及重启服务

   ```
   [root@bap-1 hive-2.3.8]# bin/hiveservice.sh status
   [root@bap-1 hive-2.3.8]# bin/hiveservice.sh start
   [root@bap-1 hive-2.3.8]# bin/hiveservice.sh stop
   [root@bap-1 hive-2.3.8]# bin/hiveservice.sh restart
   ```

   

   

