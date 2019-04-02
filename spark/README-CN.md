## 在容器中运行 Spark 集群 / [English](README.md)

### 3 节点的 Spark 集群

##### 1. 拉取 docker 镜像

```
docker pull registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_spark:v1.0
docker tag registry.cn-shenzhen.aliyuncs.com/hsdocker2019/hs_spark:v1.0 hs_spark:v1.0
```

##### 2. 创建 hadoop 网络
```
docker network create --driver=bridge hadoop
```

##### 3. 启动集群的容器
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


> 以上操作将会启动一个3节点的 Spark 集群(1 主 2 从) ，并进入 `/root/` 目录  
> 3个节点是: master,slave-0,slave-1

##### 4. 启动 hadoop
```
hdfs namenode -format
sh start-hadoop.sh
```

##### 5. 启动 spark
```
sh start-spark.sh
```

test if spark's ok
```
spark-shell
```
### 任意数量从节点的Spark集群
```
sh start-container.sh <number of slaves>
```

### 再次进入master容器
```
docker exec -it master bash
```
