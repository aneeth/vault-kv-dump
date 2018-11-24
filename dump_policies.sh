#!/bin/bash

source lib/functions

DUMP_FOLDER="dump_policies-$(date +"%Y%m%d%H%S")"
POLICIES_FOLDER="${DUMP_FOLDER}/policies"

if [ -z $TOKEN ]; then
  echo "Please define 'TOKEN'"
  exit 1
fi

if [ -z $VAULT_ADDR ]; then
  echo "Please define 'VAULT_ADDR'"
  exit 1
fi

function dump_policies () {
  mkdir -p "${POLICIES_FOLDER}"
  for policy in $(list "sys/policy")
  do
    echo $(retrieve "sys/policy/${policy}") >> "${POLICIES_FOLDER}/${policy}"
  done
}

dump_policies
