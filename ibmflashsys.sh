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
req=$(curl -k -s -X POST "$URL/rest/lssystem" -H "$HEADAPP" -H "X-Auth-Token: $auth")
echo $req
