#!/bin/bash
# This file is part of the Drups.io Docker.
#
# (c) 2021 Drups.io <dev@drups.io>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#
# Written by Temuri Takalandze <temo@drups.io>, April 2021

clone_repository() {
  REPO=$1
  BRANCH=$2
  REPO_DIR=$3

  if [[ -d ${REPO_DIR} && ! "$(ls -A "$REPO_DIR")" ]]; then
    rm -rf "$REPO_DIR"
  fi

  if [[ -d ${REPO_DIR} ]]; then
    cd "${REPO_DIR}" || return
    git pull origin "${BRANCH}"
    cd "${DIR}"/.. || return
  else
    git clone --single-branch --branch "${BRANCH}" "${REPO}" "${REPO_DIR}"
  fi
}

get_container_ip() {
  IP=$(docker inspect --format='{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${1}")

  echo "$IP"
}

check_command() {
  COMMAND=$1
  RECOMMENDED=$2

  if ! command -v "$COMMAND" &>/dev/null; then
    if [ "$RECOMMENDED" != 1 ]; then
      echo -e "${COLOR_RED}Command ${COMMAND} could not be found!${COLOR_NONE}\n"
      exit 1
    fi

    echo -e "${COLOR_YELLOW}Command ${COMMAND} is recommend, but could not be found!${COLOR_NONE}\n"
    return 0
  fi

  echo -e "${COLOR_GREEN}Command ${COMMAND} exists!${COLOR_NONE}\n"
}

check_port() {
  PORT=$1
  MATCH=$(sudo netstat -tulpn | grep ":${PORT}")

  if [ -n "${MATCH}" ]; then
    echo -e "${COLOR_RED}Port ${PORT} in use!${COLOR_NONE}\n"
    exit 1
  fi

  echo -e "${COLOR_GREEN}Port ${PORT} not in use!${COLOR_NONE}\n"
}

die() {
  echo -e "${COLOR_RED}${1}${COLOR_NONE}"
  exit 1
}

check_k8s_cluster() {
  MATCH=$(kubectl cluster-info)
  if [[ $MATCH == *"is running"* ]]; then
    echo -e "${COLOR_GREEN}Kubernetes Cluster is running!${COLOR_NONE}\n"
  else
    echo -e "${COLOR_RED}Kubernetes Cluster is not running!${COLOR_NONE}\n"
    exit 1
  fi
}
