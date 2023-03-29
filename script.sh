#!/bin/bash

contents=$(jq --arg client "$1" --arg netmask "$2" '.instance_name_prefix=$client | .netmask=$netmask' inventories/template/temp.json) && echo "${contents}" > inventories/template/all.json

ALL="$(base64 -i inventories/template/all.json)"
CLIENT="$(base64 -i inventories/template/client.json)"
HOST="$(base64 -i inventories/template/hosts)"

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $3"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/TY231618/git-push/contents/$1/all.yml \
  -d "{\"message\":\"my commit message\",\"committer\":{\"name\":\"Tony\",\"email\":\"ayoung@and.digital\"},\"content\":\"$ALL\"}"

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $3"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/TY231618/git-push/contents/$1/client.yml \
  -d "{\"message\":\"my commit message\",\"committer\":{\"name\":\"Tony\",\"email\":\"ayoung@and.digital\"},\"content\":\"$CLIENT\"}"

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $3"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/TY231618/git-push/contents/$1/hosts \
  -d "{\"message\":\"my commit message\",\"committer\":{\"name\":\"Tony\",\"email\":\"ayoung@and.digital\"},\"content\":\"$HOST\"}"
