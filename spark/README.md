## Run Spark Cluster within Docker Containers / [中文](README-CN.md)

### 3 Nodes Spark Cluster

##### 1. pull docker image 
```
docker pull registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_spark:v1.0
docker tag registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_spark:v1.0 hs_spark:v1.0
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
start spark master container...
start spark slave-0 container...
start spark slave-1 container...
root@master:~# 
```

>after that , you start 3 containers with 1 master and 2 slaves,you will get into the `/root` directory of master container  
>3 nodes are: master,slave-0,slave-1

##### 4. start hadoop
```
hdfs namenode -format
sh start-hadoop.sh
```

##### 5. start spark
```
sh start-spark.sh
```

test if spark's ok
```
spark-shell
```
### Arbitrary size Spark cluster
```
sh start-container.sh <number of slaves>
```

### get into master again
```
docker exec -it master bash
```
