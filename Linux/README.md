<!-- TOC -->
* [Linux](#linux)
  * [Operators](#operators)
    * [Operator "&"](#operator-)
      * [Ctrl + Z](#ctrl--z)
  * [Init System  systemd (systemctl) or System V Init (service)](#init-system--systemd-systemctl-or-system-v-init-service)
    * [Services (systemctl)](#services-systemctl)
  * [Running Distribution](#running-distribution)
  * [Symbolic Link](#symbolic-link)
    * [What is the difference between soft and hard links in Linux?](#what-is-the-difference-between-soft-and-hard-links-in-linux)
    * [How to create a symlink to a file](#how-to-create-a-symlink-to-a-file)
    * [How to create a symbolic link to a directory](#how-to-create-a-symbolic-link-to-a-directory)
    * [How to remove a symbolic link](#how-to-remove-a-symbolic-link)
    * [How to overwrite symlinks](#how-to-overwrite-symlinks)
  * [Check if a package is installed](#check-if-a-package-is-installed)
  * [Syncing files and directories](#syncing-files-and-directories)
  * [Cambiar los colores a la consola](#cambiar-los-colores-a-la-consola)
  * [Gestión de Usuarios](#gestión-de-usuarios)
    * [Crear un nuevo usuario](#crear-un-nuevo-usuario)
    * [Ver información del usuario](#ver-información-del-usuario)
    * [Cambiar la contraseña de un usuario](#cambiar-la-contraseña-de-un-usuario)
    * [Agregar un usuario al grupo sudo](#agregar-un-usuario-al-grupo-sudo)
    * [Cambiar el shell de un usuario](#cambiar-el-shell-de-un-usuario)
    * [Eliminar un usuario](#eliminar-un-usuario)
  * [Archivos](#archivos)
    * [Gestión de permisos de archivos](#gestión-de-permisos-de-archivos)
    * [Compresión y descompresión de archivos](#compresión-y-descompresión-de-archivos)
  * [Proteger el grub](#proteger-el-grub)
  * [Unidades APFS de macOS en Linux](#unidades-apfs-de-macos-en-linux)
    * [Uso del Controlador APFS-FUSE para Linux**](#uso-del-controlador-apfs-fuse-para-linux)
    * [Auto-Mount Apple APFS partition on Linux after Restart](#auto-mount-apple-apfs-partition-on-linux-after-restart)
    * [Usar APFS para Linux por el Programa Paragon](#usar-apfs-para-linux-por-el-programa-paragon)
<!-- TOC -->

# Linux

## Operators

### Operator "&"

This operator allows us to execute commands in the background. For example, let's say we want to copy a large file. This will obviously take quite a long time and will leave us unable to do anything
else until the file successfully copies.

The "&" shell operator allows us to execute a command and have it run in the background (such as this file copy) allowing us to do other things!

#### Ctrl + Z

This command will suspend the process and put it in the background. This is useful if you want to stop a process but not kill it. You can then use the `fg` command to bring it back to the foreground.

## Init System  systemd (systemctl) or System V Init (service)

If you are unsure which init system your platform uses, run the following command:

`ps --no-headers -o comm 1`

### Services (systemctl)

To list all running services, use the following command:
`systemctl list-units --type=service`

To start a service, use the following command:
`systemctl start <service_name>`

To stop a service, use the following command:
`systemctl stop <service_name>`

To restart a service, use the following command:
`systemctl restart <service_name>`

To check the status of a service, use the following command:
`systemctl status <service_name>`

To enable a service to start on boot, use the following command:
`systemctl enable <service_name>`

To disable a service from starting on boot, use the following command:
`systemctl disable <service_name>`

To check if a service is enabled to start on boot, use the following command:
`systemctl is-enabled <service_name>`

To check if a service is running, use the following command:
`systemctl is-active <service_name>`

To check if a service is failed, use the following command:
`systemctl is-failed <service_name>`

To check the logs of a service, use the following command:
`journalctl -u <service_name>`

## Running Distribution

`lsb_release -sc`

`cat /etc/lsb-release`

`cat /etc/os-release`

## Symbolic Link

### What is the difference between soft and hard links in Linux?

A soft link or symbolic link will point to the original file on your system. A hard link will create a copy of the file.

Soft links can point to other files or directories on a different file system, whereas hard links cannot.

### How to create a symlink to a file

You use the ln command to create the links for the files and the `-s` option to specify that this will be a symbolic link. If you omit the `-s`
option, then a hard link will be created instead.

`ln -s existing_source_file optional_symbolic_link`

### How to create a symbolic link to a directory

`ln -s /Users/jessicawilkins/Music ~/my_music`

### How to remove a symbolic link

`rm fcc_link.txt`

`unlink fcc_link.txt`

### How to overwrite symlinks

`ln -sf example_fcc_file.txt fcc_link.txt`

## Check if a package is installed

`sudo apt list --installed | grep openssh-server`

## Syncing files and directories

`rsync -av /source /destination`

`rsync -azP o17_bps_mig_x_2025-02-27-07-53-12.sql.gz omen@192.168.1.112:/home/omen/Descargas`

## Cambiar los colores a la consola

1. Cambiarse al usuario con `sudo su - <user>`
2. Abrir el archivo `~/.bashrc` y buscar la línea `PS1=` debajo de `if [ "$color_prompt" = yes ]; then`
3. Modificar la línea `PS1` para cambiar los colores usando el sitio web [https://bash-prompt-generator.org/](https://bash-prompt-generator.org/), se pueden agregar o remover elementos.
4. Copiar el contenido de la línea `PS1` y pegarlo en el sitio web.
5. Modificar los colores y copiar el resultado.
6. Pegarlo en el archivo `~/.bashrc` en la línea `PS1=`.
7. Descomentar la línea `force_color_prompt=yes` si está comentada. _Paso necesario si el usuario es el **root**._
8. Guardar el archivo.
9. Ejecutar el comando `source ~/.bashrc` para aplicar los cambios.

## Gestión de Usuarios

### Crear un nuevo usuario

```bash
# Crear un nuevo usuario, -m para crear el directorio home
sudo useradd <username> -m
```

### Ver información del usuario

```bash
# Ver información del usuario como la shell, etc.
cat /etc/passwd | grep <username>
# muestra algo como esto:
# <username>:x:1000:1000:<Username>:/home/<username>:/bin/bash
````

### Cambiar la contraseña de un usuario

```bash
# Cambiar la contraseña de un usuario
sudo passwd <username>
```

### Agregar un usuario al grupo sudo

```bash 
# Agregar un usuario al grupo sudo, ejecutar como root
 sudo usermod -aG sudo <username>
```

### Cambiar el shell de un usuario

```bash
# Cambiar el shell de un usuario
sudo usermod -s /bin/bash <username>
```

### Eliminar un usuario

```bash
# Eliminar un usuario
sudo userdel -rf <username>
```

## Archivos

### Gestión de permisos de archivos

```bash
# Cambiar permisos de un archivo
chmod u=rwx,g=rx,o=rx <archivo>
# Cambiar permisos de un directorio
chmod u=rwx,g=rx,o=rx /opt/odoo
# Cambiar permisos de un archivo y sus subdirectorios
chmod -R u=rwx,g=rx,o=rx /opt/odoo
```

### Compresión y descompresión de archivos

```bash
# Comprimir un archivo con tar 
tar -cvf <archivo>.tar.gz <directorio>
# Descomprimir un archivo con tar
tar -xvf <archivo>.tar.gz
# Comprimir un archivo con tar y gzip
tar -czvf <archivo>.tar.gz <directorio>
# Descomprimir un archivo con tar y gzip
tar -xzvf <archivo>.tar.gz
# Mostrar contentido de archivo comprimido con tar
tar -tvf <archivo>.tar.gz

# Comprimir un archivo con gzip
gzip <archivo>
# Descomprimir un archivo con gzip
gunzip <archivo>.gz
# Mostrar contenido de archivo comprimido con gzip
zcat <archivo>.gz

# Comprimir un archivo con zip
zip <archivo>.zip <directorio>
# Descomprimir un archivo con zip
unzip <archivo>.zip
# Mostrar contenido de archivo comprimido con zip
unzip -l <archivo>.zip
```

## Proteger el grub

```bash
# Proteger el grub
# Editar el archivo /etc/grub.d/00_header y agregar la siguiente línea al final
cat << EOF
set superusers="<username>"
password_pbkdf2 <usernam> <hash>
EOF
# Generar el hash de la contraseña
sudo grub-mkpasswd-pbkdf2
# Escribir la contraseña y copiar el hash generado
# Guardar el archivo
# Actualizar el grub
update-grub
```

## [Unidades APFS de macOS en Linux](https://recoverit.wondershare.es/harddrive-tips/mount-apfs-linux.html)

### Uso del Controlador APFS-FUSE para Linux**

- Youtube: [Mount APFS on Linux](https://www.youtube.com/watch?v=47puTVS1Scg)
- Git: https://github.com/sgan81/apfs-fuse

**Características:**

* Soporta el cifrado FileVault.
* Soporta el montaje de instantáneas y volúmenes sellados.
* Soporta tablas de partición.
* Soporta el montaje de DMGs

**Pros:**

* Cubre múltiples opciones de montaje
* Soporta unidades de fusión

**Cons:**

* Es un dispositivo de sólo lectura
* No se admiten enlaces firmes
* Algunos métodos de compresión aún no son compatibles

```bash
# Instalar dependencias
sudo apt update
sudo apt install fuse libfuse-dev libicu-dev bzip2 libbz2-dev cmake clang git libattr1-dev
# Clonar el repositorio
git clone https://github.com/sgan81/apfs-fuse.git
cd apfs-fuse
git submodule init
git submodule update
# Compilar el controlador
mkdir build
cd build
cmake ..
make
# Copiar el controlador
sudo cp apfs-fuse /usr/local/bin
# Comprobar si se copiò correctamente
ls /usr/local/bin/

# Crear el directorio de montaje
sudo mkdir -p /media/$USERNAME/macos

# Listar los discos disponibles
sudo fdisk -l

# Montar la unidad APFS
sudo apfs-fuse -o allow_other <device> /media/$USERNAME/macos

# Desmontar la unidad APFS
sudo fusermount -u /media/$USERNAME/macos
```

### Auto-Mount Apple APFS partition on Linux after Restart

Youtube: [Auto-Mount Apple APFS partition on Linux after Restart](https://www.youtube.com/watch?v=kO1ykesGgLc)

### Usar APFS para Linux por el Programa Paragon

El[ programa APFS para Linux de Paragon](https://www.paragon-software.com/business/apfs-linux/) permite leer y escribir datos en el almacenamiento formateado en APFS. Este producto es un programa de
pago, y la principal diferencia entre Paragon APFS y APFS-Fuse es que, este programa también permite escribir en la unidad.

Pros:

* Funcionamiento a prueba de fallos
* Protección contra la pérdida y la corrupción de datos
* Rendimiento equilibrado y constante
* Uso eficiente del hardware

Cons:

* El tipo de acceso a los volúmenes cifrados y a las instantáneas de APFS es de sólo lectura
* No es compatible con las unidades de fusión ni con los cifrados del chip de seguridad T2