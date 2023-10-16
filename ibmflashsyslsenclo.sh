#!/bin/bash
IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTID="-2"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsenclosure" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|IO_group_id|{#IOGRID}|g;
s|type|{#TYPE}|g;
s|manged|{#MANAGED}|g;
s|IO_group_name|{#IOGRNAME}|g;
s|product_MTM|{#PRODUCTMTM}|g;
s|serial_number|{#SN}|g;
s|drive_slots|{#DRIVESLOTS}|g;
s|id|{#ID}|g')
#echo ${req[@]}

for i in $(echo "${req[@]}" | jq ''); do
        echo $i | sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/19))'"|g'
        STARTID=$((STARTID+1))
done
