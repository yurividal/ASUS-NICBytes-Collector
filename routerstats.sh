#!/bin/bash

while [ true ]
do
        RxOctets=`cat /proc/net/dev | grep eth2.2 | awk '{print $2}'`
        #echo $RxOctets 
        TxOctets=`cat /proc/net/dev | grep eth2.2 | awk '{print $10}'`
        #echo $TxOctets
        uptime=`cat /proc/uptime | awk '{print $1}'`
                ramused=`free | grep Mem | awk '{print $3}'`
                data="routerstats,host=AsusRouter RxOctets=${RxOctets},TxOctets=${TxOctets},uptime=${uptime},ramused=$ramused"
        #echo $data
                Command="wget --header=\"Accept-Encoding: gzip, deflate\"  --header='Accept-Charset: UTF-8' --header='Content-Type: application/json' -O response.json --post-data  \"$data\" http://<IP-OF-INFLUXDB>:8086/write\?db\=<DATABASE NAME>"
        #echo "$Command"
        eval "$Command"
        sleep 30
