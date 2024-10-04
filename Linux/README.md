<!-- TOC -->
* [Linux](#linux)
  * [Init System  systemd (systemctl) or System V Init (service)](#init-system--systemd-systemctl-or-system-v-init-service)
  * [Running Distribution](#running-distribution)
<!-- TOC -->

# Linux

## Init System  systemd (systemctl) or System V Init (service)

If you are unsure which init system your platform uses, run the following command:

`ps --no-headers -o comm 1`

## Running Distribution
`lsb_release -sc`

`cat /etc/lsb-release`

`cat /etc/os-release`
