# This file is part of the Drups.io Docker.
#
# (c) 2021 Drups.io <dev@drups.io>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#
# Written by Temuri Takalandze <temo@drups.io>, April 2021

include .env

default: help

## help		:	Print commands help.
.PHONY: help
help : Makefile
	@sed -n 's/^##//p' $<

## up		:	Start up containers.
.PHONY: up
up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	@./scripts/pre-start.sh
	docker-compose pull
	docker-compose up -d --remove-orphans
	@./scripts/post-start.sh

## down		:	Stop containers.
.PHONY: down
down: stop

## start		:	Start containers without updating.
.PHONY: start
start:
	@echo "Starting containers for $(PROJECT_NAME) from where you left off..."
	@./scripts/pre-start.sh
	@docker-compose start
	@./scripts/post-start.sh
## stop		:	Stop containers.
.PHONY: stop
stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop
	@./scripts/post-stop.sh

## restart	:	Restart the containers.
##			You can optionally pass an argument with the service name to restart specific container
##			restart engine			: Restart `engine` container.
##			restart engine application	: Restart `engine` and `application` containers.
.PHONY: restart
restart:
	@docker-compose restart $(filter-out $@,$(MAKECMDGOALS))

## prune		:	Remove containers and their volumes.
##			You can optionally pass an argument with the service name to prune single container
##			prune engine		 : Prune `engine` container and remove its volumes.
##			prune engine application : Prune `engine` and `application` containers and remove their volumes.
.PHONY: prune
prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v $(filter-out $@,$(MAKECMDGOALS))

## ps		:	List running containers.
.PHONY: ps
ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

## info		:	Print stack info.
.PHONY: info
info:
	@./scripts/info.sh

## shell		:	Access `engine` container via shell.
##			You can optionally pass an argument with a service name to open a shell on the specified container
.PHONY: shell
shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_$(or $(filter-out $@,$(MAKECMDGOALS)), 'engine')' --format "{{ .ID }}") bash

## logs		:	View containers logs.
##			You can optionally pass an argument with the service name to limit logs
##			logs engine		: View `engine` container logs.
##			logs engine application	: View `engine` and `application` containers logs.
.PHONY: logs
logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

## install	:	Run the project installer.
.PHONY: install
install:
	@./scripts/install.sh

## update-hosts	:	Write container IPs to /etc/hosts.
.PHONY: update-hosts
update-hosts:
	@./scripts/registry/update-hosts.sh

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
