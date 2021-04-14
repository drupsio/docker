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

TOTAL_STEPS=8
CURRENT_STEP=0

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Docker...\n${COLOR_NONE}"
check_command "docker"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Docker Compose...\n${COLOR_NONE}"
check_command "docker-compose"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking GNU Make...\n${COLOR_NONE}"
check_command "make"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking OpenSSL...\n${COLOR_NONE}"
check_command "openssl"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking kubectl...\n${COLOR_NONE}"
check_command "kubectl"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Minikube...\n${COLOR_NONE}"
check_command "minikube" 1

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Kubernetes Cluster...\n${COLOR_NONE}"
check_k8s_cluster

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Kubernetes Dashboard port...\n${COLOR_NONE}"
check_port "8181"
