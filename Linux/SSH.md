# SSH

<!-- TOC -->
* [SSH](#ssh)
  * [How to Fix Connection Refused by Port 22 Debian/Ubuntu](#how-to-fix-connection-refused-by-port-22-debianubuntu)
    * [Verify OpenSSH Installation on Your Linux System](#verify-openssh-installation-on-your-linux-system)
    * [In case OpenSSH is not installed, we will install it by executing the following command:](#in-case-openssh-is-not-installed-we-will-install-it-by-executing-the-following-command)
    * [Check SSH Service](#check-ssh-service)
    * [If your SSH service is inactive, you can start it by executing the following commands:](#if-your-ssh-service-is-inactive-you-can-start-it-by-executing-the-following-commands)
    * [Check SSH Server Listening Port](#check-ssh-server-listening-port)
  * [Allow SSH in Firewall](#allow-ssh-in-firewall)
* [Autenticarse usando el par de llaves privada/pública (NO MÁS CONTRASEÑAS)](#autenticarse-usando-el-par-de-llaves-privadapública-no-más-contraseñas)
  * [Generar la llave pública/privada](#generar-la-llave-públicaprivada)
  * [Copiar la llave pública al servidor remoto](#copiar-la-llave-pública-al-servidor-remoto)
  * [Conectarse al servidor remoto](#conectarse-al-servidor-remoto)
<!-- TOC -->

## [How to Fix Connection Refused by Port 22 Debian/Ubuntu](https://linuxhint.com/fix_connection_refused_ubuntu/)

### Verify OpenSSH Installation on Your Linux System

```bash 
    sudo apt list --installed | grep openssh-server
```

### In case OpenSSH is not installed, we will install it by executing the following command:

```bash 
    sudo apt install openssh-server
```

### Check SSH Service

```bash 
    sudo service ssh status
```

### If your SSH service is inactive, you can start it by executing the following commands:

```bash 
    sudo service ssh start
    # ó
    sudo service ssh restart
```

### Check SSH Server Listening Port

Perhaps, you are connecting to the wrong port which is why you are getting a connection refused error. For example, the
server is listening for a connection on port 1068 but you are trying to connect to port 22.

Before trying to connect, first, verify which port is being used by the SSH server to listen to new connections. If the
server is listening on default port 22, then you can use the following command syntax to make a connection:

```bash 
    ssh [username]@[remoteserver IP or hostname]
```

Issue the following command to check on which port the OpenSSH server is listening:

```bash 
    sudo netstat -ltnp | grep sshd
```

In case, some other port is being used in place of 22, you will issue the command like this:

```bash 
    ssh -p [Port] [username]@[ip_address]
```

## Allow SSH in Firewall

A connection refused message could also be because the firewall on your system is blocking the SSH port. To allow the port through firewall, execute this command:

```bash  
    sudo ufw allow ssh
    # ó
    sudo ufw allow port 22/tcp
    
    # una regla más específica
    sudo ufw allow from 192.168.1.0/24 to any port 22 proto tcp
```

Reload the firewall with this command to update the rules:

```bash    
    sudo ufw reload
    sudo ufw status
```

# Autenticarse usando el par de llaves privada/pública (NO MÁS CONTRASEÑAS)

## Generar la llave pública/privada

```bash
    ssh-keygen -t rsa -b 4096
```

## Copiar la llave pública al servidor remoto

```bash
    ssh-copy-id user@remote_host
    # o
    ssh-copy-id -i ~/.ssh/id_rsa.pub user@remote_host
```

## Conectarse al servidor remoto

```bash
    ssh user@remote_host
```