## Run Hadoop Cluster within Docker Containers

### 3 Nodes Hadoop Cluster

##### 1. pull docker image 

```
docker pull registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_hadoop:v1.0
docker tag registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_hadoop:v1.0 hs_hadoop:v1.0
```

##### 2. create hadoop network

```
docker network create --driver=bridge hadoop
```

##### 3. start container

```
sh start-container.sh
```

**output:**
```
start master container...
start slave-0 container...
start slave-1 container...
root@master:~# 
```

>after that , you start 3 containers with 1 master and 2 slaves,you will get into the /root directory of master container
>3 nodes are: master,slave-0,slave-1

##### 4. start hadoop

```
hdfs namenode -format
sh start-hadoop.sh
```

##### 5. run wordcount
```
sh run-wordcount.sh
```

**output**

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

### Arbitrary size Hadoop cluster
```
sh start-container.sh <number of slaves>
```


## 参考
1. Blog: [Run Hadoop Cluster in Docker Update](http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/)
1. 博客: [基于Docker搭建Hadoop集群之升级版](http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/)