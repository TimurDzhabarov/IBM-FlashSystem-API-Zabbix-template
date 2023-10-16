#!/bin/bash
IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTIDARR="-2"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsarray" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|mdisk_name|{#MDNAME}|g;
s|mdisk_grp_id|{#MDGRID}|g;
s|mdisk_grp_name|{#MDGRNAME}|g;
s|capacity|{#CAPACITY}|g;
s|raid_level|{#RAIDLVL}|g;
s|redundancy|{#REDUNDANCY}|g;
s|strip_size|{#STRIPSIZE}|g;
s|encrypt|{#ENCRYPT}|g;
s|distributed|{#DISTRIBUTED}|g;
s|tier|{#TIER}|g;
s|mdisk_id|{#ID}|g')
#echo $req #| sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/16))'"|g'

for i in $(echo "${req[@]}" | jq ''); do
        echo $i | sed 's|"{#ID}": "[0-9][0-9]"|"{#ID}": "'$((STARTIDARR/15))'"|g'
        STARTIDARR=$((STARTIDARR+1))
done
