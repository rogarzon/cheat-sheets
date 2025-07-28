# FTP (File Transfer Protocol)

<!-- TOC -->
* [FTP (File Transfer Protocol)](#ftp-file-transfer-protocol)
  * [Características](#características)
  * [Opciones](#opciones)
  * [Comandos](#comandos)
  * [Acceso a recursos compartidos](#acceso-a-recursos-compartidos)
  * [Windows](#windows)
<!-- TOC -->

## Características
- Transfiere archivos entre un cliente y un servidor.
- Usa el puerto **TCP 21**.
- Funciona en la capa de aplicación del modelo OSI.
- Permite conexiónes anónimas o autenticadas.
- Para conexiones seguras se usa FTPS (FTP Secure) o SFTP (SSH File Transfer Protocol).

## Opciones
- `-v`: Modo verbose, muestra información detallada de las acciones.
- `-P <puerto>`: Especifica el puerto del servidor FTP.

## Comandos
- `cd <directorio>`: Cambia al directorio especificado en el servidor.
- `ls`: Lista los archivos y directorios en el directorio actual del servidor.
- `get <archivo>`: Descarga un archivo del servidor al sistema local.
- `put <archivo>`: Sube un archivo del sistema local al servidor.
- `mget <archivos>`: Descarga múltiples archivos del servidor al sistema local.
- `mput <archivos>`: Sube múltiples archivos del sistema local al servidor.
- `del <archivo>`: Elimina un archivo del servidor.
- `mkdir <directorio>`: Crea un nuevo directorio en el servidor.
- `rmdir <directorio>`: Elimina un directorio del servidor.
- `exit`: Sale del servidor y cierra la conexión.
- `lcd <directorio>`: Cambia al directorio especificado en el sistema local.
- `lpwd`: Muestra el directorio actual en el sistema local.
- `pwd`: Muestra el directorio actual en el servidor.
- `!<comando>`: Ejecuta un comando del sistema local desde la sesión FTP

## Acceso a recursos compartidos
- Para acceder a un servidor FTP, se usa el comando `ftp`. Si el comando no está instalado, se puede instalar mediante el comando `sudo apt install ftp`.
- `ftp` tratará de conectarse al servidor FTP remoto y verificará si es requerida una autenticación.
- Si no se especifica usuario, usará el usuario anónimo por defecto.

**Instalación de ftp**
```bash
    sudo apt install ftp
```
**Conectar a un servidor FTP**
```bash
    ftp <IP_DEL_SERVIDOR>
    ftp ftp://<user>:<password>@<IP_DEL_SERVIDOR>
```

## Windows

Transfers files to and from a computer running an FTP server service
(sometimes called a daemon). Ftp can be used interactively.

To start ftp, type the following command at a command prompt:

```bash
FTP [-v] [-d] [-i] [-n] [-g] [-s:filename] [-a] [-A] [-x:sendbuffer] [-r:recvbuffer] [-b:asyncbuffers] [-w:windowsize] [host]

  -v              Suppresses display of remote server responses.
  -n              Suppresses auto-login upon initial connection.
  -i              Turns off interactive prompting during multiple file
                  transfers.
  -d              Enables debugging.
  -g              Disables filename globbing (see GLOB command).
  -s:filename     Specifies a text file containing FTP commands; the
                  commands will automatically run after FTP starts.
  -a              Use any local interface when binding data connection.
  -A              login as anonymous.
  -x:send sockbuf Overrides the default SO_SNDBUF size of 8192.
  -r:recv sockbuf Overrides the default SO_RCVBUF size of 8192.
  -b:async count  Overrides the default async count of 3
  -w:windowsize   Overrides the default transfer buffer size of 65535.
  host            Specifies the host name or IP address of the remote
                  host to connect to.

Notes:
  - mget and mput commands take y/n/q for yes/no/quit.
  - Use Control-C to abort commands.
``` 