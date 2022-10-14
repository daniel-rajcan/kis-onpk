#!/bin/bash

USERNAME="${1}"
PASSWORD="${2}"
AUTH_URL="${3}"

AUTH_TOKEN=$(wget -S --no-check-certificate --quiet \
  --method POST \
  --timeout=0 \
  --header 'Content-Type: application/json' \
  --body-data "{
    \"auth\": {
        \"identity\": {
            \"methods\": [
                \"password\"
            ],
            \"password\": {
                \"user\": {
                    \"name\": \"${USERNAME}\",
                    \"domain\": {
                        \"name\": \"Default\"
                    },
                    \"password\": \"${PASSWORD}\"
                }
            }
        }
    }
}
" $AUTH_URL/v3/auth/tokens -O - 2>&1 | grep -Po "X-Subject-Token: \K.+")

echo $AUTH_TOKEN
