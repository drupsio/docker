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

TOTAL_STEPS=2
CURRENT_STEP=0

echo -e "${COLOR_GREEN} Running post-install steps...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Running Kubernetes Dashboard...\n\v${COLOR_NONE}"
sudo mkdir /var/log/kubectl -p
sudo touch /var/log/kubectl/proxy.log
sudo chown "$USER:$USER" /var/log/kubectl/proxy.log
kubectl proxy --address='0.0.0.0' --port=8181 --disable-filter=true </var/log/kubectl/proxy.log &>>/var/log/kubectl/proxy.log &

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Running info script...\n\v${COLOR_NONE}"
sh "${DIR}/info.sh"
