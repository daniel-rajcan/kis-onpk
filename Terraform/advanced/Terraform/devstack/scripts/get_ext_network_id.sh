#!/bin/bash

USERNAME="${1}"
PASSWORD="${2}"
AUTH_URL="${3}"

AUTH_TOKEN=$(bash ./scripts/get_auth_token.sh "${USERNAME}" "${PASSWORD}" "${AUTH_URL}")

ID=$(wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header "X-Auth-Token: ${AUTH_TOKEN}" \
   http://10.0.0.25:9696/v2.0/networks -O - | jq '.networks[] | select(.name=="public") | . .id' | sed 's/"//g')

printf %s "${ID}" > ext_network_id
