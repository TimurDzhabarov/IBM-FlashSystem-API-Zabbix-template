#!/bin/bash
IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTID="-12"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsfabric" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|remote_wwpn|{#REMOTEWWPN}|g;
s|remote_nportid|{#REMOTENPORTID}|g;
s|node_name|{#NODENAME}|g;
s|local_wwpn|{#LOCALWWPN}|g;
s|local_nportid|{#LOCALNPORTID}|g;
s|local_port|{#LOCALPORT}|g;
s|cluster_name|{#CLUSTERNAME}|g;
s|name|{#NAME}|g')
#echo "${req[@]}" #| sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/16))'"|g'

for i in $(echo "${req[@]}" | jq ''); do
        echo $i | sed 's|"type": "host"|"type": "host", "{#ID}": "'$((STARTID/13))'"|g'
        #echo $i | sed 's|"type": "host"|"type": "post"|g'
        STARTID=$((STARTID+1))
done
