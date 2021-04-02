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

clear

TOTAL_STEPS=2
CURRENT_STEP=0

echo -e "${COLOR_GREEN}Welcome to ${PROJECT_NAME} installer! ${COLOR_NONE}\n\n\n"
echo -e "${COLOR_GREEN}Preparing for installation...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning Engine repository...\n\v${COLOR_NONE}"
clone_repository "${ENGINE_GIT_REPO}" "${ENGINE_GIT_BRANCH}" "${ENGINE_DIR}"

# @todo implement Application cloning.

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Restarting containers...\n\v${COLOR_NONE}"
docker-compose stop
docker-compose pull
docker-compose up -d --remove-orphans