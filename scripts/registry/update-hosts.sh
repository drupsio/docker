#!/bin/bash
# This file is part of the Drups.io Docker.
#
# (c) 2021 Drups.io <dev@drups.io>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#
# Written by Temuri Takalandze <temo@drups.io>, April 2021

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${DIR}"/../../.env
source "${DIR}"/../functions.sh

CONTAINER_IP=$(get_container_ip "${PROJECT_NAME}_registry")
HOSTNAME='registry.loc'

MATCH="$(grep -n $HOSTNAME /etc/hosts | cut -f1 -d:)"
HOST_ENTRY="${CONTAINER_IP} ${HOSTNAME}"

if [ ! -z "$MATCH" ]; then
  while read -r LINE; do
    if [[ "$OSTYPE" == darwin* ]]; then
      sudo sed -i '' "${LINE}s/.*/${HOST_ENTRY} /" /etc/hosts
    else
      sudo sed -i "${LINE}s/.*/${HOST_ENTRY} /" /etc/hosts
    fi
  done <<<"$MATCH"
else
  echo "$HOST_ENTRY" | sudo tee -a /etc/hosts >/dev/null
fi

# Update in Minikube node.
if command -v minikube &>/dev/null; then
  minikube ssh sudo "bash -c 'echo ${HOST_ENTRY} >> /etc/hosts'"
fi
