#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
echo $ip
echo $host
curl -X POST http://35.199.102.88:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'"}'
