#!/bin/bash

source lib/functions

if [ -z $TOKEN ]; then
  echo "Please define 'TOKEN'"
  exit 1
fi

if [ -z $VAULT_ADDR ]; then
  echo "Please define 'VAULT_ADDR'"
  exit 1
fi

if [ -z $DUMP_FOLDER ]; then
  echo "Please define 'DUMP_FOLDER'"
  exit 1
fi

KV_FOLDER="${DUMP_FOLDER}/kv"

function write_kv () {
  write $1
}
function traverse_dir () {
  for item in $(ls -F $1);
  do
    path="${1}${item}"
    if [ "${item: -1}" == "/" ]; then
      traverse_dir ${path}
    else
      write_kv $path
    fi
  done
}

if [ "${KV_FOLDER: -1}" != "/" ]; then
  KV_FOLDER="${KV_FOLDER}/"
fi
traverse_dir ${KV_FOLDER}
