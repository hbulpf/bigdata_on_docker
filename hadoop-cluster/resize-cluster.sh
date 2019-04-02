#!/bin/bash

# N is the node number of hadoop cluster
N=$1

if [ $# = 0 ]
then
	echo "Please specify the node number of hadoop cluster!"
	exit 1
fi

# change slaves file
i=0
rm config/slaves
while [ $i -lt $N ]
do
	echo "slave-$i" >> hadoop_config/slaves
	((i++))
done 

echo ""