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

clear

echo -e "${COLOR_GREEN}Welcome to ${PROJECT_NAME} installer! ${COLOR_NONE}\n\n\n"

# Pre-installation steps.
sh "${DIR}/pre-install.sh"

echo -e "\n\n"

# Install Engine.
sh "${DIR}/engine/install.sh"

echo -e "\n\n"

# Install Application.
sh "${DIR}/application/install.sh"
