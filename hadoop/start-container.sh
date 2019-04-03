#!/bin/bash

# the default slave node number is 2
N=${1:-2}

# start hadoop master container
docker rm -f master &> /dev/null
echo "start hadoop master container..."
docker run -itd \
                --net=hadoop \
                -p 10070:50070 \
                -p 18088:8088 \
                --name master \
                --hostname master \
                hs_hadoop:v1.0 &> /dev/null


# start hadoop slave container
i=0
while [ $i -lt $N ]
do
	docker rm -f slave-$i &> /dev/null
	echo "start hadoop slave-$i container..."
	docker run -itd \
	                --net=hadoop \
					-p "1800${i}":50075 \			
	                --name slave-$i \
	                --hostname slave-$i \
	                hs_hadoop:v1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

echo -e "hadoop cluster: 1 master, $N slaves\n"

if [ $N -ne 2 ]
then 
	j=0
	rm hadoop_config/slaves
	while [ $j -lt $N ]
	do
		echo "slave-$j" >> hadoop_config/slaves
		((j++))
	done 
	docker cp hadoop_config/slaves master:/usr/local/hadoop/etc/hadoop/slaves
	while [ $j -lt $N ]
	do	
	# copy file to slave-$j
	docker cp hadoop_config/slaves slave-$j:/usr/local/hadoop/etc/hadoop/slaves
	j=$(( $j + 1 ))
	done 
fi

docker cp ./hadoop_config/run-wordcount.sh master:/root/run-wordcount.sh
# get into hadoop master container
docker exec -it master bash
