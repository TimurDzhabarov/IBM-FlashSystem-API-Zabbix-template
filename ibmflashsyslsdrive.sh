#!/bin/bash

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
#echo $auth
req=$(curl -k -s -X POST "$URL/rest/lsdrive" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|mdisk_id|{#MDISKID}|g;
s|enclosure_id|{#ENCLOSUREID}|g;
s|member_id|{#MEMBERID}|g;
s|drive_class_id|{#DRIVECLASSID}|g;
s|slot_id|{#SLOTID}|g;
s|capacity|{#CAPACITY}|g;
s|mdisk_name|{#DISKNAME}|g;
s|node_id|{#NODEID}|g;
s|use|{#USE}|g;
s|tech_type|{#TECHTYPE}|g;
s|node_name|{#NODENAME}|g;
s|auto_manage|{#AUTOMANAGE}|g;
s|id|{#ID}|g' )
echo $req
