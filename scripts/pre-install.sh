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

TOTAL_STEPS=7
CURRENT_STEP=0

CERTS_DIR="${DIR}"/../certs

echo -e "${COLOR_GREEN} Running pre-install steps...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Stopping containers...\n\v${COLOR_NONE}"
docker-compose stop

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking requirements...\n\v${COLOR_NONE}"
sh "${DIR}/check-requirements.sh" || die "Unable to process installation! Please, check the requirements."

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

# Make self-signed certificate trusted for Kubernetes.
kubectl delete -n kube-system daemonset registry-ca
kubectl delete -n kube-system secret registry-ca
kubectl create secret generic registry-ca --namespace kube-system --from-file=registry-ca="${CERTS_DIR}"/registry/crt/ca.crt
kubectl create -f "${DIR}"/../environments/registry/registry-ca-ds.yaml

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Starting containers...\n\v${COLOR_NONE}"
docker-compose pull
docker-compose up -d --remove-orphans

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Adding registry.loc to /etc/hosts...\n\v${COLOR_NONE}"
sh "${DIR}/registry/update-hosts.sh"
