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

source "${DIR}"/../../.env

ENV_LOCAL_PATH="${DIR}/../../environments/engine/.env.local"
ENV_LOCAL_DEST="${ENGINE_DIR}/.env.local"

RABBITMQ_HOST="rabbitmq"
REDIS_HOST="redis"

DOCKER_HOST='docker'
DOCKER_PORT='2376'

DOCKER_REGISTRY_HOST="registry.loc"

K8S_HOST=$(docker exec -it "${PROJECT_NAME}_engine" ip route | awk '/default/ { print $3 }' | sed 's/ *$//g')
K8S_PORT='8181'

cp "${ENV_LOCAL_PATH}" "${ENV_LOCAL_DEST}"

if [[ "$OSTYPE" == darwin* ]]; then
  sed -i '' "s/_BROKER_USER_/$RABBITMQ_USER/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_BROKER_PASS_/$RABBITMQ_PASS/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_BROKER_HOST_/$RABBITMQ_HOST/g" "$ENV_LOCAL_DEST"

  sed -i '' "s/_RESULT_BACKEND_HOST_/$REDIS_HOST/g" "$ENV_LOCAL_DEST"

  sed -i '' "s/_DOCKER_HOST_/$DOCKER_HOST/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_DOCKER_PORT_/$DOCKER_PORT/g" "$ENV_LOCAL_DEST"

  sed -i '' "s/_DOCKER_REGISTRY_HOST_/$DOCKER_REGISTRY_HOST/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_DOCKER_REGISTRY_USER_/$DOCKER_REGISTRY_USER/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_DOCKER_REGISTRY_PASS_/$DOCKER_REGISTRY_PASS/g" "$ENV_LOCAL_DEST"

  sed -i '' "s/_K8S_HOST_/$K8S_HOST/g" "$ENV_LOCAL_DEST"
  sed -i '' "s/_K8S_PORT_/$K8S_PORT/g" "$ENV_LOCAL_DEST"
else
  sed -i "s/_BROKER_USER_/$RABBITMQ_USER/g" "$ENV_LOCAL_DEST"
  sed -i "s/_BROKER_PASS_/$RABBITMQ_PASS/g" "$ENV_LOCAL_DEST"
  sed -i "s/_BROKER_HOST_/$RABBITMQ_HOST/g" "$ENV_LOCAL_DEST"

  sed -i "s/_RESULT_BACKEND_HOST_/$REDIS_HOST/g" "$ENV_LOCAL_DEST"

  sed -i "s/_DOCKER_HOST_/$DOCKER_HOST/g" "$ENV_LOCAL_DEST"
  sed -i "s/_DOCKER_PORT_/$DOCKER_PORT/g" "$ENV_LOCAL_DEST"

  sed -i "s/_DOCKER_REGISTRY_HOST_/$DOCKER_REGISTRY_HOST/g" "$ENV_LOCAL_DEST"
  sed -i "s/_DOCKER_REGISTRY_USER_/$DOCKER_REGISTRY_USER/g" "$ENV_LOCAL_DEST"
  sed -i "s/_DOCKER_REGISTRY_PASS_/$DOCKER_REGISTRY_PASS/g" "$ENV_LOCAL_DEST"

  sed -i "s/_K8S_HOST_/$K8S_HOST/g" "$ENV_LOCAL_DEST"
  sed -i "s/_K8S_PORT_/$K8S_PORT/g" "$ENV_LOCAL_DEST"
fi
