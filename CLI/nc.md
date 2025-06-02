# NC Command

## Description
The `nc` command, also known as **Netcat**, is a versatile networking utility that can read and write data across network connections using TCP or UDP protocols. It is often referred to as the "Swiss Army knife" of networking due to its wide range of capabilities.

## Usage
```bash
nc [options] [hostname] [port]
```
## Options
- `-l`: Listen for incoming connections.
- `-p <port>`: Specify the local port to listen on or connect to.
- `-u`: Use UDP instead of TCP.
- `-v`: Enable verbose mode to display more information about the connection.
- `-z`: Zero-I/O mode, used for scanning and checking if a port is open without sending any data.
- `-w <timeout>`: Set a timeout for connections, in seconds.
- `-e <program>`: Execute a program after establishing a connection (note: this option may not be available in all versions of Netcat due to security concerns).
- `-n`: Do not perform DNS resolution, use numeric IP addresses only.
- `-k`: Keep the connection open after the first client disconnects, allowing multiple connections to be handled sequentially.
- `-s <source address>`: Specify the source address to use for the connection.
- `-i <interval>`: Set the interval for sending data, in seconds (useful for sending periodic messages).
- `-o <file>`: Write the output to a file instead of standard output.
- `-C`: Use CRLF line endings instead of LF, useful for compatibility with certain protocols.
- `-4`: Use IPv4 only.
- `-6`: Use IPv6 only.
- `-h`: Display help information and exit.
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

