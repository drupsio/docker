# Drups.io Docker

Development Docker stack for Drups.io

[![GitHub release](https://img.shields.io/github/release/drupsio/docker.svg)](https://github.com/drupsio/docker/releases)
[![GitHub license](https://img.shields.io/github/license/drupsio/docker.svg)](https://github.com/drupsio/docker/blob/0.x/LICENSE)
[![Documentation Status](https://readthedocs.org/projects/drupsio-docker/badge/?version=latest)](https://drupsio.rtfd.io/projects/docker/)

## Stack

| Container            | Service name           | Image           |
| -------------------- | ---------------------- | --------------- |
| Engine               | `engine`               | [_/python]      |
| Application Back     | `application_back`     | [_/node]        |
| Application Front    | `application_front`    | [_/node]        |
| RabbitMQ             | `rabbitmq`             | [_/rabbitmq]    |
| Redis                | `redis`                | [_/redis]       |
| Postgres             | `postgres`             | [_/postgres]    |
| Traefik              | `traefik`              | [_/traefik]     |

## Installation

- Clone the repository: `git clone git@github.com:drupsio/docker.git`
- Go to the project directory: `cd docker`
- Run the project installer: `make install`

The installer script will clone the application parts into `/apps` directory, install them and run servers and daemons.
You can get information about running stack (Application URLs, Credentials, etc.) by running `make info`.

## Usage

### Basic Make commands

- `make up`- Pull and start up containers.
- `make stop`- Stop containers.
- `make start`- Start containers without updating.
- `make shell`- Access `engine` container via shell. You can optionally pass an argument with a service name to open a 
  shell on the specified container (e.g. `make shell application_back`, `make shell rabbitmq`).

**Note**: You can see all available commands by running `make help`.

### Project Settings

Project settings are stored in the [.env](.env) file. You can modify them before running `make up` or `make install`. 
e.g. you can change the version of Redis in the `redis` container by updating the `REDIS_TAG` variable.

#### Basic variables from .env

- `ENGINE_GIT_REPO`/`APPLICATION_GIT_REPO` - Git repository of Engine/Application to clone.
- `ENGINE_GIT_BRANCH`/`APPLICATION_GIT_BRANCH` - Git branch of Engine/Application to clone.
- `POSTGRES_USER` - Username of Postgres default user.
- `POSTGRES_PASSWORD` - Password of Postgres default user.

## Documentation

You can see the project documentation at [drupsio.rtfd.io/projects/docker](https://drupsio.rtfd.io/projects/docker/).

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for details.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

- [Temuri Takalandze](https://abgeo.dev) - *Initial work*

## License

Copyright © 2021 [Drups.io](https://drups.io).  
Released under the [MIT](LICENSE) license.

[_/python]: https://hub.docker.com/_/python
[_/node]: https://hub.docker.com/_/node
[_/rabbitmq]: https://hub.docker.com/_/rabbitmq
[_/redis]: https://hub.docker.com/_/redis
[_/postgres]: https://hub.docker.com/_/postgres
[_/traefik]: https://hub.docker.com/_/traefik
