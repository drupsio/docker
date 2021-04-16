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

TOTAL_STEPS=1
CURRENT_STEP=0

echo -e "${COLOR_GREEN}\nRunning post-stop steps...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Stopping Kubernetes Dashboard...\n\v${COLOR_NONE}"
netstat -tulpn | grep :8181 | awk '/LISTEN/ { print $7 }' | cut -d/ -f1 | xargs kill -9 || echo -e "${COLOR_YELLOW}\nNothing to stop.${COLOR_NONE}\n"
