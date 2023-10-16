#!/bin/bash
IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTID="-3"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsenclosurebattery" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|enclosure_id|{#ENCLOSUREID}|g;
s|canister_id|{#CANISTERID}|g;
s|battery_slot|{#BATTAREYSLOT}|g;
s|battery_id|{#ID}|g')
#echo "${req[@]}" #| sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/16))'"|g'

for i in $(echo "${req[@]}" | jq ''); do
        echo $i | sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/11))'"|g'
        STARTID=$((STARTID+1))
done
