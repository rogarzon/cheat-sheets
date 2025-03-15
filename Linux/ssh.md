# [How to Fix Connection Refused by Port 22 Debian/Ubuntu](https://linuxhint.com/fix_connection_refused_ubuntu/)

## Verify OpenSSH Installation on Your Linux System

`sudo apt list --installed | grep openssh-server`

## In case OpenSSH is not installed, we will install it by executing the following command:

`sudo apt install openssh-server`

## Check SSH Service

`sudo service ssh status`

## If your SSH service is inactive, you can start it by executing the following commands:

`sudo service ssh start`

`sudo service ssh restart`

## Check SSH Server Listening Port

Perhaps, you are connecting to the wrong port which is why you are getting a connection refused error. For example, the
server is listening for a connection on port 1068 but you are trying to connect to port 22.

Before trying to connect, first, verify which port is being used by the SSH server to listen to new connections. If the
server is listening on default port 22, then you can use the following command syntax to make a connection:

`ssh [username]@[remoteserver IP or hostname]`

Issue the following command to check on which port the OpenSSH server is listening:

`sudo netstat -ltnp | grep sshd`

In case, some other port is being used in place of 22, you will issue the command like this:

`ssh -p [Port] [username]@[ip_address]`

## Allow SSH in Firewall

A connection refused message could also be because the firewall on your system is blocking the SSH port. To allow the port through firewall, execute this command:

`sudo ufw allow ssh`

or 

`sudo ufw allow port /tcp`

Reload the firewall with this command to update the rules:

`sudo ufw reload`

`sudo ufw status`