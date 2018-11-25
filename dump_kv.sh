#!/bin/bash

source lib/constants
source lib/functions

DUMP_FOLDER="dump_kv-$(date +"%Y%m%d%H%S")"
KV_FOLDER="${DUMP_FOLDER}/kv"

if [ -z $TOKEN ]; then
  echo "Please define 'TOKEN'"
  exit 1
fi

if [ -z $VAULT_ADDR ]; then
  echo "Please define 'VAULT_ADDR'"
  exit 1
fi

if [ -z $KV_MOUNTS ]; then
  echo "Please define 'KV_MOUNTS'"
  echo " example: KV_MOUNTS=\"secret/ my-secret/\""
  exit 1
fi

function dump_kv () {
  path=$( echo $1 | sed "s#/#${FOLDER_IDENTIFIER}/#g")
  mkdir -p "${KV_FOLDER}/${path%/*}"
  echo $(retrieve "$1") >> ${KV_FOLDER}/$path
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

for mount in $KV_MOUNTS
do
  if [ "${mount: -1}" != "/" ]; then
    mount="${mount}/"
  fi
  traverse_kv $mount
done
