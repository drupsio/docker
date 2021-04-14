# Installation

## Requirements

- `Docker`
- `Docker Compose`
- `GNU Make`
- `OpenSSL`
- `kubectl`
- `minikube (Recommended)`

You need to have a running [Kubernetes](https://kubernetes.io/) Cluster on your machine. We recommend using
[minikube](https://minikube.sigs.k8s.io). _minikube is local Kubernetes, focusing on making it easy to learn 
and develop for Kubernetes._ You can install minikube using the 
[official guide](https://minikube.sigs.k8s.io/docs/start/).

## Installation Process

- Clone the repository: `git clone git@github.com:drupsio/docker.git`
- Go to the project directory: `cd docker`
- Run the project installer: `make install`

The installer script will clone the application parts into `/apps` directory, install them and run servers and daemons.
You can get information about running stack (Application URLs, Credentials, etc.) by running `make info`.
