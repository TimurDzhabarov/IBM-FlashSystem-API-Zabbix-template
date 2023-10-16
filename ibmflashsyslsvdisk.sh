#!/bin/bash
#IFS=$'\n'

PARAM1="${1}"
PARAM2="${2}"
PARAM3="${3}"

STARTID="-2"
URL="https://$PARAM3:7443"
HEADAPP="Accept: application/json"
HEADCONT="Content-Type: application/json;  charset=UTF-8"
ARR=()

auth=$(curl -k -s -X POST "$URL/rest/auth" -H "$HEADAPP" -H "X-Auth-Username: $PARAM1"  -H "X-Auth-Password: $PARAM2" | jq .token | sed 's|"||g')
req=$(curl -k -s -X POST "$URL/rest/lsvdisk" -H "$HEADAPP" -H "X-Auth-Token: $auth" | \
sed 's|IO_group_id|{#IOGRID}|g;
s|IO_group_name|{#IOGRNAME}|g;
s|capacity|{#CAPACITY}|g;
s|type|{#TYPE}|g;
s|FC_id|{#FCID}|g;
s|FC_name|{#FCNAME}|g;
s|RC_id|{#RCID}|g;
s|RC_name|{#RCNAME}|g;
s|vdisk_UID|{#VDISKUID}|g;
s|fc_map_count|{#FCMAPCOUNT}|g;
s|fast_write_state|{#FSTWRITESTATE}|g;
s|se_copy_count|{#SECOPYCOUNT}|g;
s|RC_change|{#RCHANGE}|g;
s|compressed_copy_count|{#COMPCOPYCOUNT}|g;
s|parent_mdisk_grp_id|{#PARENTMDISKGROUPID}|g;
s|parent_mdisk_grp_name|{#PARENTMDISKGROUPNAME}|g;
s|owner_id|{#OWNERID}|g;
s|owner_name|{#OWNERNAME}|g;
s|formatting|{#FORMATING}|g;
s|encrypt|{#ENCRYPT}|g;
s|volume_id|{#VOLID}|g;
s|volume_name|{#VOLNAME}|g;
s|function|{#FUNCTION}|g;
s|protocol|{#PROTOCOL}|g;
s|mdisk_grp_id|{#MDISKGRID}|g;
s|mdisk_grp_name|{#MDISKGRNAME}|g;
s|copy_count|{#COPYCOUNT}|g;
s|name|{#NAME}|g;
s|id|{#ID}|g')
echo "${req[@]}" #| sed 's|"{#ID}": "[0-9]"|"{#ID}": "'$((STARTID/16))'"|g'

#for i in $(echo "${req[@]}" | jq ''); do
#       echo $i | sed 's|"{#ID}": "[0-9][0-9]"|"{#ID}": "'$((STARTID/16))'"|g'
#       STARTID=$((STARTID+1))
#done
