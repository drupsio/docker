#!/bin/bash
# This file is part of the Drups.io Docker.
#
# (c) 2021 Drups.io <dev@drups.io>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#
# Written by Temuri Takalandze <temo@drups.io>, April 2021

docker-compose exec engine ps -ef | grep 'celery' | grep -v grep | awk '{print $2}' | xargs -r kill -9
docker-compose exec -d engine celery -A drups worker --loglevel=DEBUG -E
