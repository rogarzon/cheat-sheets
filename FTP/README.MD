# FTP (File Transfer Protocol)

<!-- TOC -->
* [FTP (File Transfer Protocol)](#ftp-file-transfer-protocol)
  * [Características](#características)
  * [Opciones](#opciones)
  * [Comandos](#comandos)
  * [Acceso a recursos compartidos](#acceso-a-recursos-compartidos)
<!-- TOC -->

## Características
- Transfiere archivos entre un cliente y un servidor.
- Usa el puerto **TCP 21**.
- Funciona en la capa de aplicación del modelo OSI.
- Permite conexiónes anónimas o autenticadas.
- Para conexiones seguras se usa FTPS (FTP Secure) o SFTP (SSH File Transfer Protocol).

## Opciones
- `-i`: Modo interactivo, solicita confirmación antes de cada acción.
- `-v`: Modo verbose, muestra información detallada de las acciones.
- `-n`: No solicita autenticación, usa conexión anónima.
- `-u <usuario>`: Especifica el usuario para autenticación.
- `-p <contraseña>`: Especifica la contraseña para autenticación.
- `-P <puerto>`: Especifica el puerto del servidor FTP.
- `-l`: Lista los archivos y directorios en el servidor.
- `-g`: Modo de descarga, permite descargar archivos sin confirmación.

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
```
