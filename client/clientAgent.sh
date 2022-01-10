#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
timestamp=`date +%s%N`
date=`date +%D`
echo $ip
echo $host
echo $timestamp
echo $date
curl -X POST http://x.x.x.x:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'","timestamp":"'${timestamp}'","date":"'${date}'"}'
