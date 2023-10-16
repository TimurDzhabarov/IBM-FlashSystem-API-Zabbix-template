#!/bin/bash
IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTID="-5"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsportfc" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|port_speed|{#PORTSPEED}|g;
s|fc_io_port_id|{#FCIOPORTID}|g;
s|adapter_port_id|{#ADAPTERPORTID}|g;
s|port_id|{#PORTID}|g;
s|node_id|{#NODEID}|g;
s|node_name|{#NODENAME}|g;
s|WWPN|{#WWPN}|g;
s|nportid|{#NPORTID}|g;
s|attachment|{#ATTACHMENT}|g;
s|cluster_use|{#CLUSTERUSE}|g;
s|adapter_location|{#ADAPTERLOCATION}|g;
s|adapter_location|{#ADAPTERLOCATION}|g;
s|name|{#NAME}|g')
#echo "${req[@]}" #| sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/16))'"|g'

for i in $(echo "${req[@]}" | jq ''); do
        echo $i | sed 's|"type": "fc",|"type": "fc", "{#ID}": "'$((STARTID/16))'",|g'
#       echo $i | sed 's|"type": "fc",|"type": "post",|g'
        STARTID=$((STARTID+1))
done
