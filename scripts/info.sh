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

echo -e "\n\
${COLOR_BLUE}${PROJECT_NAME} is ready!${COLOR_NONE}\v\

${COLOR_GREEN}\n RabbitMQ UI${COLOR_NONE}\t - ${COLOR_GREEN}http://${RABBITMQ_URL}${COLOR_NONE}\
${COLOR_GREEN}\n Traefik${COLOR_NONE}\t - ${COLOR_GREEN}http://${TRAEFIK_URL}${COLOR_NONE}\

${COLOR_BLUE}\n\vCredentials${COLOR_NONE}\

${COLOR_BLUE}\nRabbitMQ${COLOR_NONE}\
${COLOR_GREEN}\n Username\t${COLOR_NONE} - ${COLOR_GREEN}${RABBITMQ_USER}${COLOR_NONE}\
${COLOR_GREEN}\n Password\t${COLOR_NONE} - ${COLOR_GREEN}${RABBITMQ_PASS}${COLOR_NONE}"
