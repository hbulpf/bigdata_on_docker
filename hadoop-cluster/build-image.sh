#!/bin/bashb 

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t hs_hadoop:v1.0 .

echo ""