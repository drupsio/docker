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

source "${DIR}"/../styles.env

TOTAL_STEPS=3
CURRENT_STEP=0

echo -e "${COLOR_GREEN} Installing Engine...${COLOR_NONE}\n"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Running pre-install script...\n\v${COLOR_NONE}"
sh "${DIR}/pre-install.sh"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Running pip install...\n\v${COLOR_NONE}"
docker-compose exec engine pip install -r requirements/dev.txt

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Running Celery process...\n\v${COLOR_NONE}"
docker-compose exec -d engine celery -A drups worker --loglevel=DEBUG -E
