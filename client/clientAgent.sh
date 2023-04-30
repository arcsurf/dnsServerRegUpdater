#!/bin/bash
ip=`curl ifconfig.me`
host=`cat /etc/hostname`
timestamp=`date +%s%N`
date=`date +%D`

#Check if IP address is the same between DNS server and VPNServer Host IP:
registeredIp=`curl -X GET "http://35.199.102.88:3000/host/${host}"`

#Reading client public ip assigned and check new ip address registrered in VPN server, and update on DNS server.     
if [ $ip != $registeredIp ]; then
  curl -X POST http://x.x.x.x:3000/dns -H 'Content-Type: application/json' -d '{"ip":"'${ip}'","hostname":"'${host}'","timestamp":"'${timestamp}'","date":"'${date}'"}'
else
  echo "The Ip assigned is not updated"
fi
