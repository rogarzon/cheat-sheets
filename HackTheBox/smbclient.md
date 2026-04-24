# smbclient

Herramienta de línea de comandos para interactuar con servidores SMB/CIFS.

## Sintaxis básica

```bash
smbclient //server/share [opciones]
```

## Opciones más comunes

| Opción | Descripción |
|--------|-------------|
| `-U usuario` | Especificar usuario para autenticación |
| `-W dominio` | Especificar el dominio (opcional) |
| `-L servidor` | Listar shares disponibles |
| `-I IP` | Especificar IP del servidor |
| `-p puerto` | Especificar puerto SMB (por defecto: 445) |
| `-c 'comando'` | Ejecutar comando SMB |
| `-t` | Usar modo transparente (para transferencias no interactivas) |
| `-m PROTOCOLO` | Especificar protocolo (NT1, SMB2, SMB3) |
| `-A archivo` | Leer credenciales desde archivo |
| `-N` | No pedir contraseña (anonymous) |

## Comandos interactivos (dentro de smbclient)

| Comando | Descripción |
|---------|-------------|
| `ls` | Listar archivos |
| `get archivo` | Descargar archivo |
| `mget *` | Descargar múltiples archivos |
| `put archivo` | Subir archivo |
| `mput *` | Subir múltiples archivos |
| `rm archivo` | Eliminar archivo |
| `mkdir dir` | Crear directorio |
| `rmdir dir` | Eliminar directorio |
| `cd dir` | Cambiar directorio |
| `pwd` | Mostrar directorio actual |
| `quit` | Salir |

## Ejemplos de uso

```bash
# Listar shares disponibles
smbclient -L //10.10.10.10 -U ''

# Conectar a share con autenticación
smbclient //10.10.10.10/IPC$ -U 'admin%password'

# Ejecutar comando no interactivamente
smbclient //10.10.10.10/IPC$ -U 'admin%password' -c 'ls'

# Descargar todos los archivos
smbclient //10.10.10.10/share -U 'user%pass' -c 'mget *'

# Subir archivo
smbclient //10.10.10.10/share -U 'user%pass' -c 'put archivo.txt'
```

## Autenticación sin contraseña (anonymous)

```bash
smbclient //server/share -U '' -N
smbclient //server/share -U guest
```
