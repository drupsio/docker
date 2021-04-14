# Usage

## Basic Make commands

- `make up`- Pull and start up containers.
- `make stop`- Stop containers.
- `make start`- Start containers without updating.
- `make shell`- Access `engine` container via shell. You can optionally pass an argument with a service name to open a 
  shell on the specified container (e.g. `make shell application_back`, `make shell rabbitmq`).

**Note**: You can see all available commands by running `make help`.

## Project Settings

Project settings are stored in the `.env` file. You can modify them before running `make up` or `make install`. 
e.g. you can change the version of Redis in the `redis` container by updating the `REDIS_TAG` variable.

### Basic variables from .env

- `ENGINE_GIT_REPO`/`APPLICATION_GIT_REPO` - Git repository of Engine/Application to clone.
- `ENGINE_GIT_BRANCH`/`APPLICATION_GIT_BRANCH` - Git branch of Engine/Application to clone.
- `POSTGRES_USER` - Username of Postgres default user.
- `POSTGRES_PASSWORD` - Password of Postgres default user.
