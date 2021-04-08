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

source "${DIR}"/../.env
source "${DIR}"/styles.env
source "${DIR}"/functions.sh

TOTAL_STEPS=4
CURRENT_STEP=0

CERTS_DIR="${DIR}"/../certs

echo -e "${COLOR_GREEN} Preparing for installation...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning Engine repository...\n\v${COLOR_NONE}"
clone_repository "${ENGINE_GIT_REPO}" "${ENGINE_GIT_BRANCH}" "${ENGINE_DIR}"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning Application repository...\n\v${COLOR_NONE}"
clone_repository "${APPLICATION_GIT_REPO}" "${APPLICATION_GIT_BRANCH}" "${APPLICATION_DIR}"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Creating certificates for Local Docker Registry...\n\v${COLOR_NONE}"
mkdir -p "${CERTS_DIR}"/registry/{crt,key}
openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes \
  -out "${CERTS_DIR}"/registry/crt/ca.crt \
  -keyout "${CERTS_DIR}"/registry/key/ca.key \
  -subj '/CN=registry.loc' \
  -addext "subjectAltName = DNS:registry.loc"

# Make self-signed certificate trusted for Docker.
sudo mkdir /etc/docker/certs.d/registry.loc -p
sudo cp "${CERTS_DIR}"/registry/crt/ca.crt /etc/docker/certs.d/registry.loc/

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Restarting containers...\n\v${COLOR_NONE}"
docker-compose stop
docker-compose pull
docker-compose up -d --remove-orphans
