#!/bin/bashb 

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t hs_spark-hadoop:v1.0 .

echo ""