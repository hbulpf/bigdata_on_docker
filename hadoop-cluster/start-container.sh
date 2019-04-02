#!/bin/bash

# the default slave node number is 2
N=${1:-2}

# start hadoop master container
docker rm -f master &> /dev/null
echo "start master container..."
docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name master \
                --hostname master \
                hs_hadoop:v1.0 &> /dev/null


# start hadoop slave container
i=0
while [ $i -lt $N ]
do
	docker rm -f slave-$i &> /dev/null
	echo "start slave-$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name slave-$i \
	                --hostname slave-$i \
	                hs_hadoop:v1.0 &> /dev/null
	i=$(( $i + 1 ))
done 


if [ $N -ne 3 ]
then 
	j=0
	docker cp ./hadoop_config/slaves master:/usr/local/hadoop/etc/hadoop/
	while [ $j -lt $N ]
	do	
	docker cp ./hadoop_config/slaves slave-$i:/usr/local/hadoop/etc/hadoop/
		j=$(( $j + 1 ))
	done 
fi

docker cp ./hadoop_config/run-wordcount.sh master:/root/
# get into hadoop master container
docker exec -it master bash
