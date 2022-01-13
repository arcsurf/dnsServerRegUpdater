#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
timestamp=`date +%s%N`
date=`date +%D`
echo $ip
echo $host
echo $timestamp
echo $date

#Check if file exist
if [ ! -f registeredIp.log ]
then
        touch registeredIp.log
fi

#Reading client public ip assigned and ip address into file registrered.
while IFS= read -r registeredIp; do
     
  if [ $ip != $registeredIp ]; then
    curl -X POST http://x.x.x.x:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'","timestamp":"'${timestamp}'","date":"'${date}'"}'
    echo $ip > registeredIp.log
  else
    echo "The Ip assigned is not updated"
  fi

done < registeredIp.log