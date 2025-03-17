<!-- TOC -->
* [Linux](#linux)
  * [Init System  systemd (systemctl) or System V Init (service)](#init-system--systemd-systemctl-or-system-v-init-service)
  * [Running Distribution](#running-distribution)
  * [Symbolic Link](#symbolic-link)
    * [What is the difference between soft and hard links in Linux?](#what-is-the-difference-between-soft-and-hard-links-in-linux)
    * [How to create a symlink to a file](#how-to-create-a-symlink-to-a-file)
    * [How to create a symbolic link to a directory](#how-to-create-a-symbolic-link-to-a-directory)
    * [How to remove a symbolic link](#how-to-remove-a-symbolic-link)
    * [How to overwrite symlinks](#how-to-overwrite-symlinks)
  * [Check if a package is installed](#check-if-a-package-is-installed)
<!-- TOC -->

# Linux

## Init System  systemd (systemctl) or System V Init (service)

If you are unsure which init system your platform uses, run the following command:

`ps --no-headers -o comm 1`

## Running Distribution

`lsb_release -sc`

`cat /etc/lsb-release`

`cat /etc/os-release`

## Symbolic Link

### What is the difference between soft and hard links in Linux?

A soft link or symbolic link will point to the original file on your system. A hard link will create a copy of the file.

Soft links can point to other files or directories on a different file system, whereas hard links cannot.

### How to create a symlink to a file

You use the ln command to create the links for the files and the `-s` option to specify that this will be a symbolic link. If you omit the `-s`
option, then a hard link will be created instead.

`ln -s existing_source_file optional_symbolic_link`

### How to create a symbolic link to a directory

`ln -s /Users/jessicawilkins/Music ~/my_music`

### How to remove a symbolic link

`rm fcc_link.txt`

`unlink fcc_link.txt`

### How to overwrite symlinks

`ln -sf example_fcc_file.txt fcc_link.txt`

## Check if a package is installed
`sudo apt list --installed | grep openssh-server`

## Syncing files and directories
`rsync -av /source /destination`

`rsync -azP o17_bps_mig_x_2025-02-27-07-53-12.sql.gz omen@192.168.1.112:/home/omen/Descargas`