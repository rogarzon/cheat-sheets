<!-- TOC -->
* [Linux](#linux)
  * [Init System  systemd (systemctl) or System V Init (service)](#init-system--systemd-systemctl-or-system-v-init-service)
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
<!-- TOC -->

# Linux

## Init System  systemd (systemctl) or System V Init (service)

If you are unsure which init system your platform uses, run the following command:

`ps --no-headers -o comm 1`

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