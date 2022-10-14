#!/bin/bash

USERNAME="${1}"
PASSWORD="${2}"
AUTH_URL="${3}"

AUTH_TOKEN=$(bash ./scripts/get_auth_token.sh "${USERNAME}" "${PASSWORD}" "${AUTH_URL}")

ID=$(wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header "X-Auth-Token: ${AUTH_TOKEN}" \
   http://10.0.0.25/image/v2/images -O - | jq '.images[] | select(.name? | match("cirros-.*")) | . .id' | sed 's/"//g')

printf %s "${ID}" > cirros_image_id
