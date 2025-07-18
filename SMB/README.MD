# SMB (Server Message Block) Protocol

<!-- TOC -->
* [SMB (Server Message Block) Protocol](#smb-server-message-block-protocol)
  * [Opciones](#opciones)
  * [Commandos](#commandos)
  * [Acceso a recursos compartidos](#acceso-a-recursos-compartidos)
<!-- TOC -->

- Sirve para transferir archivos, impresoras y otros recursos en una red local.
- Usa el puerto **TCP 445**.
- Funciona en la capa de aplicación y presentación del modelo OSI.
- Habilita un almacenamiento compartido y acceso a recursos en red llamado share.

## Opciones

- `-c`: Ejecuta un comando específico en el recurso compartido.
- `-L | --list=<host>`: Lista los recursos compartidos disponibles en el servidor.
- `-U`: Especifica el usuario para autenticación.

## Commandos

- `cd`: Cambia el directorio actual en el recurso compartido.
- `ls`: Lista los archivos y directorios en el recurso compartido.
- `get`: Descarga un archivo del recurso compartido al sistema local.
- `put`: Sube un archivo del sistema local al recurso compartido.
- `mget`: Descarga múltiples archivos del recurso compartido al sistema local.
- `mput`: Sube múltiples archivos del sistema local al recurso compartido.
- `del`: Elimina un archivo del recurso compartido.
- `mkdir`: Crea un nuevo directorio en el recurso compartido.
- `rmdir`: Elimina un directorio del recurso compartido.
- `exit`: Sale del recurso compartido y cierra la conexión.

## Acceso a recursos compartidos

- Para acceder a un recurso compartido, se usa el script `smbclient`. Si el script no está instalado, se puede instalar mediante el comando `sudo apt install smbclient`.
- `smbclient` tratará de conectarse al servidor SMB remoto y verificará si es requerida una autenticación.
- Si no se especifica usuario usará el usuario actual del sistema.

**Instalación de smbclient**

```bash
    sudo apt install smbclient
```

**Listar los recursos compartidos**

```bash
    smbclient -L <IP_DEL_SERVIDOR>
```

Normalmente, aparecen los siguientes recursos compartidos:

- **IPC$** (Inter-Process Communication): Usado para la comunicación entre procesos.
- **C$** (C Drive): Acceso al disco C del servidor.
- **ADMIN$** (Admin Share): Acceso a la carpeta de administración del sistema.
- **RECYCLER** (Papelera de reciclaje): Acceso a la papelera de reciclaje del servidor.
- **<RECURSO_COMPARTIDO>**: Cualquier otro recurso compartido configurado en el servidor.

**Acceder a un recurso compartido**

```bash
    smbclient \\\\<IP_DEL_SERVIDOR>\\<RECURSO_COMPARTIDO>
    #
    # smb: \>
```
