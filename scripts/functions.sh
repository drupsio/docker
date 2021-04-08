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
