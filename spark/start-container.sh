#!/bin/bash

# the default slave node number is 2
N=${1:-2}

# start spark master container
docker rm -f master &> /dev/null
echo "start spark master container..."
docker run -itd \
                --net=hadoop \
                -p 10070:50070 \
                -p 18088:8088 \
                --name master \
                --hostname master \
                hs_spark-hadoop:v1.0 &> /dev/null


# start spark slave container
i=0
while [ $i -lt $N ]
do
	docker rm -f slave-$i &> /dev/null
	echo "start spark slave-$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name slave-$i \
	                --hostname slave-$i \
	                hs_spark-hadoop:v1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

echo -e "spark cluster: 1 master, $N slaves\n"

if [ $N -ne 2 ]
then 
	j=0
	rm spark_config/slaves
	while [ $j -lt $N ]
	do
		echo "slave-$j" >> spark_config/slaves
		((j++))
	done 
	docker cp spark_config/slaves master:/usr/local/hadoop/etc/hadoop/slaves
	docker cp spark_config/slaves master:/usr/local/spark/conf/slaves
	while [ $j -lt $N ]
	do	
	# copy file to slave-$j
	docker cp spark_config/slaves slave-$j:/usr/local/hadoop/etc/hadoop/slaves
	docker cp spark_config/slaves slave-$j:/usr/local/spark/conf/slaves
	j=$(( $j + 1 ))
	done 
fi

docker cp ./spark_config/run-wordcount.sh master:/root/run-wordcount.sh
# get into spark master container
docker exec -it master bash
