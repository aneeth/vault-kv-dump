#!/bin/bash

DUMP_FOLDER="dump-$(date +"%Y%m%d%H%S")"
KV_FOLDER="${DUMP_FOLDER}/kv"
POLICIES_FOLDER="${DUMP_FOLDER}/policies"

if [ -z $TOKEN ]; then
  echo "Please define 'TOKEN'"
  exit 1
fi

if [ -z $VAULT_ADDR ]; then
  echo "Please define 'VAULT_ADDR'"
  exit 1
fi

if [ -z $MOUNTS ]; then
  echo "Please define 'MOUNTS'"
  echo " example: MOUNTS=\"secret/ my-secret/\""
  exit 1
fi


function list () {
  curl -s \
    --header "X-Vault-Token: ${TOKEN}" \
    --request LIST \
    ${VAULT_ADDR}/v1/$1 \
    | jq '.data.keys | join(" ")' \
    | tr -d '"'
}

function retrieve () {
  curl -s \
    --header "X-Vault-Token: ${TOKEN}" \
    http://127.0.0.1:8100/v1/$1 \
    | jq '.data'
}

function dump_kv () {
  mkdir -p "${KV_FOLDER}/${1%/*}"
  echo $(retrieve "$1") >> ${KV_FOLDER}/$1
}

function dump_policies () {
  mkdir -p "${POLICIES_FOLDER}"
  for policy in $(list "sys/policy")
  do
    echo $(retrieve "sys/policy/${policy}") >> "${POLICIES_FOLDER}/${policy}"
  done
}

function traverse_kv () {
  for item in $(list $1);
  do
    path="${1}${item}"
    if [ "${item: -1}" == "/" ]; then
      traverse_kv ${path}
    else
      dump_kv ${path}
    fi
  done
}

for mount in $MOUNTS
do
  if [ "${mount: -1}" != "/" ]; then
    mount="${mount}/"
  fi
  traverse_kv $mount
done

dump_policies
