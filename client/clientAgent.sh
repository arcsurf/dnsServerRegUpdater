#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
timestamp=`date +%s%N`
echo $ip
echo $host
echo $timestamp
curl -X POST http://x.x.x.x:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'","timestamp":"'${timestamp}'"}'
