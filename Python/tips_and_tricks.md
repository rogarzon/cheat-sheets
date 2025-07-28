# Python Tips & Tricks

<!-- TOC -->
* [Python Tips & Tricks](#python-tips--tricks)
  * [Crear un servidor web](#crear-un-servidor-web)
  * [Crear un servidor FTP](#crear-un-servidor-ftp)
    * [Opciones del servidor FTP](#opciones-del-servidor-ftp)
  * [Crear un servidor para subir archivos](#crear-un-servidor-para-subir-archivos)
    * [Opciones](#opciones)
<!-- TOC -->

## Crear un servidor web

Crear un servidor web para servir archivos estáticos en el directorio actual es muy fácil con Python. Solo necesitas ejecutar el siguiente comando en la terminal:

* `<port>` Si no se especifica, el puerto por defecto es 8000.
* `--directory <directory>` Si no se especifica, el directorio por defecto es el directorio actual.

```bash
    python -m http.server <port>
```

## Crear un servidor FTP

Para crear un servidor FTP simple con Python, puedes usar el módulo `pyftpdlib`. Primero, asegúrate de tenerlo instalado:

```bash
    pip install pyftpdlib
    sudo python3 -m pyftpdlib -p 21
```

### Opciones del servidor FTP

```bash
 
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

## Crear un servidor para subir archivos

```bash
  pip3 install uploadserver
  python3 -m uploadserver 8000

```

### Opciones

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
