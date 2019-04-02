## 在容器中运行 Hadoop 集群  / [English](README.md)

### 3 节点的 Hadoop 集群

##### 1. 拉取 docker 镜像

```
docker pull registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_hadoop:v1.0
docker tag registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_hadoop:v1.0 hs_hadoop:v1.0
```

##### 2. 创建 hadoop 网络

```
docker network create --driver=bridge hadoop
```

##### 3. 启动集群的容器

```
sh start-container.sh
```

**输出:**
```
start hadoop master container...
start hadoop slave-0 container...
start hadoop slave-1 container...
root@master:~# 
```

> 以上操作将会启动一个3节点的 Hadoop 集群(1 主 2 从) ，并进入 `/root/` 目录  
> 3个节点是: master,slave-0,slave-1

##### 4. 启动 hadoop

```
hdfs namenode -format
sh start-hadoop.sh
```

##### 5. 运行 wordcount 
```
sh run-wordcount.sh
```

**输出**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

### 任意数量从节点的Hadoop集群
```
sh start-container.sh <number of slaves>
```

### 再次进入master容器
```
docker exec -it master bash
```

## 参考
1. [基于Docker搭建Spark集群之升级版](http://kiwenlau.com/2016/06/12/160612-spark-cluster-docker-update/)