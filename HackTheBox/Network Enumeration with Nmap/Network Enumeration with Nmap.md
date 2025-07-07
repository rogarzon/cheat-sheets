# Syntax

```bash
  nmap <scan types> <options> <target>
```

# Scan Types

- `-sS`: TCP SYN scan (default and stealthy)
- `-sT`: TCP connect scan (full connection)
- `-sU`: UDP scan
- `-sA`: TCP ACK scan (to map firewall rules)
- `-sP`: Ping scan (to discover live hosts)
- `-sV`: Version detection (to identify service versions)
- `-sC`: Default script scan (runs default Nmap scripts)
- `-sO`: IP protocol scan (to identify supported protocols)
- `-sL`: List scan (to list targets without scanning)
- `-sR`: RPC scan (to identify RPC services)
- `-sI`: Idle scan (stealthy scan using a third-party host)
- `-sY`: SCTP INIT scan (for SCTP services)
- `-sZ`: SCTP COOKIE-ECHO scan (for SCTP services)
- `-sN`: TCP NULL scan (no flags set)
- `-sF`: TCP FIN scan (FIN flag set)
- `-sX`: TCP Xmas scan (FIN, URG, and PSH flags set)
- `-sW`: TCP Window scan (uses window size for detection)
- `-sM`: TCP Maimon scan (FIN/ACK scan)

# Options

- `-p <port range>`: Specify ports to scan (e.g., `-p 22,80,443` or `-p 1-1000`)
- `-p-`: Scan all ports (1-65535)
- `-T<0-5>`: Timing template (0 = slowest, 5 = fastest)
- `-Pn`: Skip host discovery (treat all hosts as online)
- `-PM`: Use ICMP echo request for host discovery
- `-n`: Disable DNS resolution
- `-sV`: Enable version detection
- `-O`: Enable OS detection
- `-A`: Enable OS detection, version detection, script scanning, and traceroute
- `-v`: Increase verbosity (use `-vv` for more)
- `-oN <filename>`: Output in normal format to a file
- `-oX <filename>`: Output in XML format to a file
- `-oG <filename>`: Output in grepable format to a file
- `-oA <basename>`: Output in all formats (normal, XML, grepable) with a common basename

# Scan Techniques

For example, the **TCP-SYN** scan (`-sS`) is one of the default settings unless we have defined otherwise and is also one of the most popular scan methods.
The **TCP-SYN** scan sends one packet with the **SYN** flag and, therefore, never completes the three-way handshake, which results in not establishing a full TCP connection to the scanned port.

- If our target sends a **SYN-ACK** flagged packet back to us, Nmap detects that the port is `open`.
- If the target responds with an **RST** flagged packet, it is an indicator that the port is `closed`.
- If Nmap does not receive a packet back, it will display it as `filtered`. Depending on the firewall configuration, certain packets may be dropped or ignored by the firewall.

# Example Commands

```bash 
    sudo nmap -sS localhost
    # Not shown: 996 closed ports
    # PORT     STATE SERVICE
    # 22/tcp   open  ssh
    # 80/tcp   open  http
    # 5432/tcp open  postgresql
    # 5901/tcp open  vnc-1
    
    # Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds
```

# Host Discovery

## Scan Network Range

```bash
    sudo nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5
    # 10.129.2.4
    # 10.129.2.10
    # 10.129.2.11
```

| Opción          | Descripción                                                      |
|-----------------|------------------------------------------------------------------|
| `10.129.2.0/24` | Target network range.                                            |
| `-sn`           | Disables port scanning.                                          |
| `-oA tnet`      | Stores the results in all formats starting with the name 'tnet'. |

This scanning method works only if the firewalls of the hosts allow it. Otherwise, we can use other scanning techniques to find out if the hosts are active or not. We will take a closer look at these
techniques in "**Firewall and IDS Evasion**".

## Scan IP List

`Nmap` also gives us the option of working with lists and reading the hosts from this list instead of manually defining or typing them in.

```bash
    cat hosts.lst
    # 10.129.2.4
    # 10.129.2.10
    
    sudo nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d" " -f5
```

| Scanning Option | Description                                                          |
|-----------------|----------------------------------------------------------------------|
| `-iL`           | Performs defined scans against targets in provided `hosts.lst` list. |

## Scan Single IP

Before we scan a single host for open ports and its services, we first have to determine if it is alive or not. For this, we can use the same method as before.

```bash
    sudo nmap 10.129.2.18 -sn -oA host
```

If we disable port scan (`-sn`), Nmap automatically ping scan with `ICMP Echo Requests (-PE)`. Once such a request is sent, we usually expect an **ICMP reply** if the pinging host is alive. The more
interesting fact is that our previous scans did not do that because before Nmap could send an ICMP echo request, it would send an **ARP ping** resulting in an **ARP reply**. We can confirm this with
the "`--packet-trace`" option. To ensure that ICMP echo requests are sent, we also define the option (`-PE`) for this.

```bash
    sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace
```

| Scanning Option  | Description                                          |
|------------------|------------------------------------------------------|
| `-PE`            | Performs the ping scan by using 'ICMP Echo requests' |
| `--packet-trace` | Shows all packets sent and received                  |

Another way to determine why Nmap has our target marked as "alive" is with the "`--reason`" option.

# Host and Port Scanning

The information we need includes:

- Open ports and its services
- Service versions
- Information that the services provided
- Operating system

There are a total of 6 different states for a scanned port we can obtain:

| State              | Description                                                                                                                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `open`             | This indicates that the connection to the scanned port has been established. These connections can be **TCP connections**, **UDP datagrams** as well as **SCTP associations**.                          |
| `closed`           | When the port is shown as closed, the TCP protocol indicates that the packet we received back contains an `RST` flag. This scanning method can also be used to determine if our target is alive or not. |
| `filtered`         | Nmap cannot correctly identify whether the scanned port is open or closed because either no response is returned from the target for the port or we get an error code from the target.                  |
| `unfiltered`       | This state of a port only occurs during the **TCP-ACK** scan and means that the port is accessible, but it cannot be determined whether it is open or closed.                                           |
| `open\|filtered`   | If we do not get a response for a specific port, **Nmap** will set it to that state. This indicates that a firewall or packet filter may protect the port.                                              |
| `closed\|filtered` | This state only occurs in the **IP ID idle** scans and indicates that it was impossible to determine if the scanned port is closed or filtered by a firewall.                                           |

## Discovering Open TCP Ports

- By default, Nmap scans the top 1000 TCP ports with the **SYN scan** (`-sS`)
- **SYN scan** is set only to default when we run it as root.
- Otherwise, the **TCP scan** (`-sT`) is performed by default.
- We can define the **ports** one by one (`-p 22,25,80,139,445`).
- By range (`-p 22-445`).
- By top ports (`--top-ports=10`)

## Scanning Top 10 TCP Ports

```bash
    sudo nmap 10.129.2.28 --top-ports=10
```

We see that we only scanned the top 10 TCP ports of our target, and **Nmap** displays their state accordingly. If we trace the packets **Nmap** sends, we will see the `RST` flag on `TCP port 21` that
our target sends back to us. To have a clear view of the SYN scan, we disable the ICMP echo requests (`-Pn`), DNS resolution (`-n`), and ARP ping scan (`--disable-arp-ping`).

## Nmap - Trace the Packets

```bash
    sudo nmap 10.129.2.28 -p 21 --packet-trace -Pn -n --disable-arp-ping
    # Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 15:39 CEST
    # SENT (0.0429s) TCP 10.10.14.2:63090 > 10.129.2.28:21 S ttl=56 id=57322 iplen=44  seq=1699105818 win=1024 <mss 1460>
    # RCVD (0.0573s) TCP 10.129.2.28:21 > 10.10.14.2:63090 RA ttl=64 id=0 iplen=40  seq=0 win=0
    # Nmap scan report for 10.11.1.28
    # Host is up (0.014s latency).
    
    # PORT   STATE  SERVICE
    # 21/tcp closed ftp
    # MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

| Scanning Option      | Description                          |
|----------------------|--------------------------------------|
| `10.129.2.28`        | Scans the specified target.          |
| `-p 21`              | Scans only the specified port.       |
| `--packet-trace`     | Shows all packets sent and received. |
| `-n`                 | Disables DNS resolution.             |
| `--disable-arp-ping` | Disables ARP ping.                   |
| `-Pn`                | Disables ICMP Echo requests.         |

### Request

| Message                                                     | Description                                                                                  |
|-------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| `SENT (0.0429s)`                                            | Indicates the SENT operation of Nmap, which sends a packet to the target.                    |
| `TCP `                                                      | Shows the protocol that is being used to interact with the target port.                      |
| `10.10.14.2:63090 >`                                        | Represents our IPv4 address and the source port, which will be used by Nmap to send packets. |
| `10.129.2.28:21`                                            | Shows the target IPv4 address and the target port.                                           |
| `S`                                                         | SYN flag of the sent TCP packet.                                                             |
| `ttl=56 id=57322 iplen=44 seq=1699105818 win=1024 mss 1460` | Additional TCP Header parameters.                                                            |

### Response

| Message                            | Description                                                                        |
|------------------------------------|------------------------------------------------------------------------------------|
| `RCVD (0.0573s)`                   | Indicates a received packet from the target.                                       |
| `TCP`                              | Shows the protocol that is being used.                                             |
| `10.129.2.28:21 > `                | Represents target's IPv4 address and the source port, which will be used to reply. |
| `10.10.14.2:63090`                 | Shows our IPv4 address and the port that will be replied to.                       |
| `RA`                               | RST and ACK flags of the sent TCP packet.                                          |
| `ttl=64 id=0 iplen=40 seq=0 win=0` | Additional TCP Header parameters.                                                  |

### Connect Scan

- (`-sT`) uses the TCP three-way handshake to determine if a specific port on a target host is open or closed.
- Sends an **SYN** packet to the target port and waits for a response.
- It is considered open if the target port responds with an **SYN-ACK**.
- Closed if it responds with an **RST** packet.
- Is one of the least stealthy techniques, as it fully establishes a connection, which creates logs on most systems and is easily detected by modern IDS/IPS solutions.

## Filtered Ports

When a port is shown as filtered, it can have several reasons. In most cases, firewalls have certain rules set to handle specific connections. The packets can either be `dropped`, or `rejected`.
When a packet gets dropped, **Nmap** receives no response from our target, and by default, the retry rate (`--max-retries`) is set to `10`.
This means **Nmap** will resend the request to the target port to determine if the previous packet was accidentally mishandled or not.

## Discovering Open UDP Ports

- Since **UDP** is a **stateless** **protocol** and does not require a three-way handshake like TCP
- Timeout is much longer, making the whole **UDP scan** (`-sU`) much slower than the **TCP scan** (`-sS`).
- we often do not get a response back because Nmap sends empty datagrams to the scanned UDP ports, and we do not receive any response. So we cannot determine if the UDP packet has arrived at all or
  not.
- If the UDP port is `open`, we only get a response if the application is configured to do so

```bash
  sudo nmap 10.129.2.28 -F -sU
  # Not shown: 95 closed ports
  # PORT     STATE         SERVICE
  # 68/udp   open|filtered dhcpc
  # 137/udp  open          netbios-ns
  # 138/udp  open|filtered netbios-dgm
  # 631/udp  open|filtered ipp
  # 5353/udp open          zeroconf
  # MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

| Scanning Option | Description          |
|-----------------|----------------------|
| `-F`            | Scans top 100 ports. |

```bash
sudo nmap 10.129.2.28 -sU -Pn -n --disable-arp-ping --packet-trace -p 137 --reason 
# PORT    STATE SERVICE    REASON
# 137/udp open  netbios-ns udp-response ttl 64
# MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

If we get an ICMP response with `error code 3` (port unreachable), we know that the port is indeed `closed`.
For all other ICMP responses, the scanned ports are marked as (`open|filtered`).

# Saving the Results

## Different Formats

While we run various scans, we should always save the results. We can use these later to examine the differences between the different scanning methods we have used. Nmap can save the results in 3
different formats.

- Normal output (`-oN`) with the `.nmap` file extension.
- Grepable output (`-oG`) with the `.gnmap` file extension.
- XML output (`-oX`) with the .xml file extension.
- All formats (`-oA`) with the basename we define.

## Style sheets

With the XML output, we can easily create HTML reports that are easy to read.
To convert the stored results from XML format to HTML, we can use the tool `xsltproc`.

```bash
    xsltproc target.xml -o target.html
```

# Service Enumeration

## Service Version Detection

It is recommended to perform a quick port scan first, which gives us a small overview of the available ports. This causes significantly less traffic, which is advantageous for us because otherwise we
can be discovered and blocked by the security mechanisms.

```bash
    sudo nmap 10.129.2.28 -p- -sV
```

| Scanning Option | Description                                      |
|-----------------|--------------------------------------------------|
| `10.129.2.28`   | Scans the specified target.                      |
| `-p-`           | Scans all ports.                                 |
| `-sV`           | Performs service version detection on the ports. |

- To view the scan status, we can press the `[Space Bar]` during the scan, which will cause **Nmap** to show us the scan status.
- Another option (`--stats-every=5s`) that we can use is defining how periods of time the status should be shown. Here we can specify the number of seconds (`s`) or minutes (`m`), after which we want
  to get the status.
- We can also increase the `verbosity level` (`-v` / `-vv`).

```bash
    sudo nmap 10.129.2.28 -p- -sV --stats-every=5s
```

# Nmap Scripting Engine (NSE)

t provides us with the possibility to create scripts in Lua for interaction with certain services. There are a total of 14 categories into which these scripts can be divided:

| Category    | Description                                                                                                                             |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `auth`      | Determination of authentication credentials.                                                                                            |
| `broadcast` | Scripts, which are used for host discovery by broadcasting and the discovered hosts, can be automatically added to the remaining scans. |
| `brute`     | Executes scripts that try to log in to the respective service by brute-forcing with credentials.                                        |
| `default`   | Default scripts executed by using the `-sC` option.                                                                                     |
| `discovery` | Evaluation of accessible services.                                                                                                      |
| `dos`       | These scripts are used to check services for denial of service vulnerabilities and are used less as it harms the services.              |
| `exploit`   | This category of scripts tries to exploit known vulnerabilities for the scanned port.                                                   |
| `external`  | Scripts that use external services for further processing.                                                                              |
| `fuzzer`    | This uses scripts to identify vulnerabilities and unexpected packet handling by sending different fields, which can take much time.     |
| `intrusive` | Intrusive scripts that could negatively affect the target system.                                                                       |
| `malware`   | Checks if some malware infects the target system.                                                                                       |
| `safe`      | Defensive scripts that do not perform intrusive and destructive access.                                                                 |
| `version`   | Extension for service detection.                                                                                                        |
| `vuln`      | Identification of specific vulnerabilities.                                                                                             |

We have several ways to define the desired scripts in **Nmap**.

## Default Scripts

```bash
  sudo nmap <target> -sC
```

## Specific Scripts Category

```bash
  sudo nmap <target> --script <category>
```

## Defined Scripts

```bash
  sudo nmap <target> --script <script-name>,<script-name>,...
```

## Nmap - Specifying Scripts

```bash
  sudo nmap 10.129.2.28 -p 25 --script banner,smtp-commands
```

| Scanning Option                 | Description                    |
|---------------------------------|--------------------------------|
| `10.129.2.28`                   | Scans the specified target.    |
| `-p 25 `                        | Scans only the specified port. |
| `--script banner,smtp-commands` | Uses specified NSE scripts.    |

The `smtp-commands` script shows us which commands we can use by interacting with the target SMTP server.

## Nmap - Aggressive Scan

**Nmap** also gives us the ability to scan our target with the aggressive option (`-A`). This scans the target with multiple options as service detection (`-sV`), OS detection (`-O`), traceroute (
`--traceroute`), and with the default NSE scripts (`-sC`).

```bash
  sudo nmap 10.129.2.28 -p 80 -A
```

| Scanning Option | Description                                                                                   |
|-----------------|-----------------------------------------------------------------------------------------------|
| `10.129.2.28`   | Scans the specified target.                                                                   |
| `-p 80 `        | Scans only the specified port.                                                                |
| `-A`            | Performs service detection, OS detection, traceroute and uses default scripts to scan target. |

## Vulnerability Assessment

```bash
  sudo nmap 10.129.2.28 -p 80 -sV --script vuln 
```

| Scanning Option | Description                                            |
|-----------------|--------------------------------------------------------|
| `10.129.2.28`   | Scans the specified target.                            |
| `-p 80`         | Scans only the specified port.                         |
| `-sV`           | Performs service version detection on specified ports. |
| `--script vuln` | Uses all related scripts from specified category.      |

> Note: **More information about NSE scripts and the corresponding categories we can find at:** [https://nmap.org/nsedoc/index.html](https://nmap.org/nsedoc/index.html)

# Performance

- We can use various options to tell Nmap how fast (`-T <0-5>`).
- With which frequency (`--min-parallelism <number>`).
- Which timeouts (`--max-rtt-timeout <time>`) the test packets should have.
- How many packets should be sent simultaneously (`--min-rate <number>`).
- Number of retries (`--max-retries <number>`) for the scanned ports the targets should be scanned.

## Timeouts

When **Nmap** sends a packet, it takes some time (`Round-Trip-Time - RTT`) to receive a response from the scanned port. Generally, **Nmap** starts with a high timeout (`--min-RTT-timeout`) of **100ms
**. Let us look at an example by scanning the whole network with 256 hosts, including the top 100 ports

### Default Scan

```bash 
  sudo nmap 10.129.2.0/24 -F
  # Nmap done: 256 IP addresses (10 hosts up) scanned in 39.44 seconds
```

### Optimized RTT

```bash
  sudo nmap 10.129.2.0/24 -F --initial-rtt-timeout 50ms --max-rtt-timeout 100ms
  # Nmap done: 256 IP addresses (8 hosts up) scanned in 12.29 seconds
```

| Scanning Option              | Description                                           |
|------------------------------|-------------------------------------------------------|
| `-F`                         | Scans top 100 ports.                                  |
| `--initial-rtt-timeout 50ms` | Sets the specified time value as initial RTT timeout. |
| `--max-rtt-timeout 100ms`    | Sets the specified time value as maximum RTT timeout. |

## Max Retries

Another way to increase scan speed is by specifying the retry rate of sent packets (`--max-retries`). The default value is **10**, but we can reduce it to **0**.

### Default Scan

```bash
  sudo nmap 10.129.2.0/24 -F | grep "/tcp" | wc -l
  # 23
```

### Reduced Retries

```bash
 sudo nmap 10.129.2.0/24 -F --max-retries 0 | grep "/tcp" | wc -l
 # 21
```

| Scanning Option   | Description                                                        |
|-------------------|--------------------------------------------------------------------|
| `--max-retries 0` | Sets the number of retries that will be performed during the scan. |

## Rates

### Default Scan

```bash
  sudo nmap 10.129.2.0/24 -F -oN tnet.default
  # Nmap done: 256 IP addresses (10 hosts up) scanned in 29.83 seconds
```

### Optimized Scan

```bash
  sudo nmap 10.129.2.0/24 -F -oN tnet.minrate300 --min-rate 300
  # Nmap done: 256 IP addresses (10 hosts up) scanned in 8.67 seconds
```

| Scanning Option       | Description                                                       |
|-----------------------|-------------------------------------------------------------------|
| `-oN tnet.minrate300` | Saves the results in normal format, starting with the given name. |
| `--min-rate 300`      | Sets the minimum number of packets to be sent per second.         |

## Timing

These values (`0-5`) determine the aggressiveness of our scans. This can also have negative effects if the scan is too aggressive, and security systems may block us due to the produced network
traffic. The default timing template used when we have defined nothing else is the normal (`-T 3`).

- `T 0` / `-T paranoid`
- `T 1` / `-T sneaky`
- `T 2` / `-T polite`
- `T 3` / `-T normal`
- `T 4` / `-T aggressive`
- `T 5` / `-T insane`

### Default Scan

```bash
  sudo nmap 10.129.2.0/24 -F -oN tnet.default
  # Nmap done: 256 IP addresses (10 hosts up) scanned in 32.44 seconds
```

### Insane Scan

```bash
  sudo nmap 10.129.2.0/24 -F -oN tnet.T5 -T 5
  # Nmap done: 256 IP addresses (10 hosts up) scanned in 18.07 seconds
```

# Firewall and IDS/IPS Evasion

**Nmap** gives us many different ways to bypass firewalls rules and IDS/IPS. These methods include the fragmentation of packets, the use of decoys, and others that we will discuss in this section.

## IDS/IPS

### Determine Firewalls and Their Rules

When a port is shown as filtered, it can have several reasons. In most cases, firewalls have certain rules set to handle specific connections.

- The packets can either be `dropped`, or `rejected`.
- The `dropped` packets are ignored, and no response is returned from the host.
- This is different for `rejected` packets that are returned with an `RST` flag. These packets contain different types of ICMP error codes or contain nothing at all.
    * Net Unreachable
    * Net Prohibited
    * Host Unreachable
    * Host Prohibited
    * Port Unreachable
    * Proto Unreachable

**Nmap's TCP ACK scan** (`-sA`) method is much harder to filter for firewalls and IDS/IPS systems than regular SYN (`-sS`) or Connect scans (`sT`) because they only send a TCP packet with only the ACK
flag

### Decoys

- **Decoys** are used to hide our real IP address by sending packets from multiple fake IP addresses.
- Decoy scanning method (`-D`) is the right choice.
- We can generate random (`RND`) a specific number (for example: 5) of IP addresses separated by a colon (`:`)

**Scan by Using Decoys**

```bash
  sudo nmap 10.129.2.28 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5
```

| Scanning Option      | Description                                                                                |
|----------------------|--------------------------------------------------------------------------------------------|
| 10.129.2.28          | Scans the specified target.                                                                |
| `-p 80`              | Scans only the specified ports.                                                            |
| `-sS`                | Performs SYN scan on specified ports.                                                      |
| `-Pn`                | Disables ICMP Echo requests.                                                               |
| `-n`                 | Disables DNS resolution.                                                                   |
| `--disable-arp-ping` | Disables ARP ping.                                                                         |
| `--packet-trace`     | Shows all packets sent and received.                                                       |
| `-D RND:5`           | Generates five random IP addresses that indicates the source IP the connection comes from. |

Another scenario would be that only individual subnets would not have access to the server's specific services. **So we can also manually specify the source IP address** (`-S`) to test if we get
better results with this one. Decoys can be used for **SYN**, **ACK**, **ICMP** scans, and **OS** detection scans.

**Scan by Using Different Source IP**

```bash
  sudo nmap 10.129.2.28 -n -Pn -p 445 -O -S 10.129.2.200 -e tun0
```

| Scanning Option | Description                                            |
|-----------------|--------------------------------------------------------|
| `10.129.2.28`   | Scans the specified target.                            |
| `-n`            | Disables DNS resolution.                               |
| `-Pn`           | Disables ICMP Echo requests.                           |
| `-p 445`        | Scans only the specified ports.                        |
| `-O`            | Performs operation system detection scan.              |
| `-S`            | Scans the target by using different source IP address. |
| `10.129.2.200`  | Specifies the source IP address.                       |
| `-e tun0`       | Sends all requests through the specified interface.    |

## DNS Proxying

- **Nmap** still gives us a way to specify DNS servers ourselves (`--dns-server <ns>`,`<ns>`). he company's DNS servers are usually more trusted than those from the Internet
- As another example, we can use **TCP port 53** as a source port (`--source-port`) for our scans.

**SYN-Scan From DNS Port**

```bash
  sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace --source-port 53
```

| Scanning Option      | Description                                    |
|----------------------|------------------------------------------------|
| `10.129.2.28`        | Scans the specified target.                    |
| `-p 50000`           | Scans only the specified ports.                |
| `-sS`                | Performs SYN scan on specified ports.          |
| `-Pn`                | Disables ICMP Echo requests.                   |
| `-n `                | Disables DNS resolution.                       |
| `--disable-arp-ping` | Disables ARP ping.                             |
| `--packet-trace`     | Shows all packets sent and received.           |
| `--source-port 53`   | Performs the scans from specified source port. |

Now that we have found out that the firewall accepts **TCP port 53**, it is very likely that IDS/IPS filters might also be configured much weaker than others. We can test this by trying to connect to
this port by using **Netcat**

**Connect To The Filtered Port**

```bash
  ncat -nv --source-port 53 10.129.2.28 50000
```