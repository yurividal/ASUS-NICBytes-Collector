#!/bin/bash

while [ true ]
do
Usage1=`top -bn1 | head -2 | tail -n 1 | tr -d % | awk '{print 100 - $8}'`
sleep 10
Usage2=`top -bn1 | head -2 | tail -n 1 | tr -d % | awk '{print 100 - $8}'`
usleep 10
Usage3=`top -bn1 | head -2 | tail -n 1 | tr -d % | awk '{print 100 - $8}'`
sleep 10
sum=$(awk "BEGIN {print $Usage1+$Usage2+$Usage3; exit}")
avg=`echo "$sum 3" | awk '{printf "%.1f", $sum/10}'`
echo $avg
data="routerstats,host=ASUSRouter CpuUsage=${avg}"
Command="wget --header=\"Accept-Encoding: gzip, deflate\"  --header='Accept-Charset: UTF-8' --header='Content-Type: application/json' -O response.json --post-data  \"$data\" http://<IP OF INFLUXDB>:8086/write\?db\=<DATABASE NAME>"
eval "$Command"
