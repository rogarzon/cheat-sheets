# [Docker Engine](https://www.docker.com/products/docker-desktop/)

<!-- TOC -->
* [Docker Engine](#docker-engine)
  * [Important](#important)
  * [Switching between Docker Desktop and Docker Engine](#switching-between-docker-desktop-and-docker-engine)
<!-- TOC -->

## Important

Docker Desktop on Linux runs a Virtual Machine (VM) which creates and uses a custom docker context, desktop-linux, on startup
This means images and containers deployed on the Linux Docker Engine (before installation) are not available in Docker Desktop for Linux.

While it's possible to run both Docker Desktop and Docker Engine simultaneously, there may be situations where running both at the same time can cause issues. For example, when mapping network ports (
-p / --publish) for containers, both Docker Desktop and Docker Engine may attempt to reserve the same port on your machine, which can lead to conflicts ("port already in use").

* Use the following command to stop the Docker Engine service:
    ```bash
    sudo systemctl stop docker docker.socket containerd
    sudo systemctl disable docker docker.socket containerd
    ```

## Switching between Docker Desktop and Docker Engine

Use the `docker context ls` command to view what contexts are available on your machine. The current context is indicated with an asterisk (*).

If you have both Docker Desktop and Docker Engine installed on the same machine, you can run the `docker context use` command to switch between the Docker Desktop and Docker Engine contexts

```bash
  docker context use default
  # default
  # Current context is now "default"
  
  # use the desktop-linux context to interact with Docker Desktop
  docker context use desktop-linux
  # desktop-linux
  # Current context is now "desktop-linux"
```