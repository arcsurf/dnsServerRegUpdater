#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
echo $ip
echo $host
curl -X POST http://x.x.x.x:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'"}'
