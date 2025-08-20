<!-- TOC -->
* [Docker Installation](#docker-installation)
  * [Starting n8n](#starting-n8n)
  * [Using with PostgreSQL](#using-with-postgresql)
  * [Updating](#updating)
  * [n8n with tunnel](#n8n-with-tunnel)
<!-- TOC -->

# Docker Installation

## Starting n8n

```bash

docker volume create n8n_data

docker run -it --rm \
 --name n8n \
 -p 5678:5678 \
 -e GENERIC_TIMEZONE="<YOUR_TIMEZONE>" \
 -e TZ="<YOUR_TIMEZONE>" \
 -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
 -e N8N_RUNNERS_ENABLED=true \
 -v n8n_data:/home/node/.n8n \
 docker.n8n.io/n8nio/n8n
```

- Maps and exposes port `5678` on the host.
- Sets the timezone for the container:
    - the TZ environment variable sets the system timezone to control what scripts and commands like date return.
    - the [GENERIC_TIMEZONE environment](https://docs.n8n.io/hosting/configuration/environment-variables/timezone-localization/) variable sets the correct timezone for schedule-oriented nodes like the
      Schedule Trigger node.
- Enforces secure file permissions for the n8n configuration file.
- Enables [task runners](https://docs.n8n.io/hosting/configuration/task-runners/), the recommended way of executing tasks in n8n.
- Mounts the `n8n_data` volume to the `/home/node/.n8n` directory to persist your data across container restarts.

## Using with PostgreSQL

```bash

docker volume create n8n_data

docker run -it --rm \
 --name n8n \
 -p 5678:5678 \
 -e GENERIC_TIMEZONE="<YOUR_TIMEZONE>" \
 -e TZ="<YOUR_TIMEZONE>" \
 -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
 -e N8N_RUNNERS_ENABLED=true \
 -e DB_TYPE=postgresdb \
 -e DB_POSTGRESDB_DATABASE=<POSTGRES_DATABASE> \
 -e DB_POSTGRESDB_HOST=<POSTGRES_HOST> \
 -e DB_POSTGRESDB_PORT=<POSTGRES_PORT> \
 -e DB_POSTGRESDB_USER=<POSTGRES_USER> \
 -e DB_POSTGRESDB_SCHEMA=<POSTGRES_SCHEMA> \
 -e DB_POSTGRESDB_PASSWORD=<POSTGRES_PASSWORD> \
 -v n8n_data:/home/node/.n8n \
 docker.n8n.io/n8nio/n8n
```

## Updating

```bash 

# Pull latest (stable) version
docker pull docker.n8n.io/n8nio/n8n

# Pull specific version
docker pull docker.n8n.io/n8nio/n8n:1.81.0

# Pull next (unstable) version
docker pull docker.n8n.io/n8nio/n8n:next

# Find your container ID
docker ps -a

# Stop the container with the `<container_id>`
docker stop <container_id>

# Remove the container with the `<container_id>`
docker rm <container_id>

# Start the container
docker run --name=<container_name> [options] -d docker.n8n.io/n8nio/n8n
```

## n8n with tunnel

> Note: Use this for local development and testing. It isn't safe to use it in production.

To use webhooks for trigger nodes of external services like GitHub, n8n has to be reachable from the web. n8n runs a [tunnel service](https://github.com/localtunnel/localtunnel) that can redirect
requests from n8n's servers to your local n8n
instance.

Start n8n with --tunnel by running:

```bash

docker volume create n8n_data

docker run -it --rm \
 --name n8n \
 -p 5678:5678 \
 -e GENERIC_TIMEZONE="<YOUR_TIMEZONE>" \
 -e TZ="<YOUR_TIMEZONE>" \
 -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
 -e N8N_RUNNERS_ENABLED=true \
 -v n8n_data:/home/node/.n8n \
 docker.n8n.io/n8nio/n8n \
 start --tunnel
```