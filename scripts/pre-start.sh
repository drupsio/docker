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

source "${DIR}"/styles.env
source "${DIR}"/functions.sh

TOTAL_STEPS=3
CURRENT_STEP=0

echo -e "${COLOR_GREEN}\nRunning pre-start steps...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Kubernetes Cluster...\n${COLOR_NONE}"
check_k8s_cluster

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Traefik ports...\n${COLOR_NONE}"
check_port "80"
check_port "8080"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Checking Kubernetes Dashboard port...\n${COLOR_NONE}"
check_port "8181"
