<!-- TOC -->

* [`pass` (gestor de contraseñas de línea de comandos)](#pass-gestor-de-contraseñas-de-línea-de-comandos)
    * [Instalación](#instalación)
    * [Configurar con GPG:](#configurar-con-gpg)
    * [Ejemplos de uso](#ejemplos-de-uso)
    * [Autenticarse a Docker Hub usando `pass`](#autenticarse-a-docker-hub-usando-pass)

<!-- TOC -->

# `pass` (gestor de contraseñas de línea de comandos)

Este es un herramienta externa (no instalada por defecto) para gestionar contraseñas de forma segura usando GPG.

## Instalación

```bash
sudo apt update
sudo apt install pass
```

## Configurar con GPG:

1. Genera un par de claves GPG si no tienes uno ya:
   ```bash
   gpg --full-generate-key
   # verificar claves GPG
   gpg --list-secret-keys
   #  Si ya tienes una clave GPG pero no estás seguro de su correo, ejecuta:
   gpg --list-secret-keys --with-fingerprint
   ```
2. Inicializar `pass` con tu clave GPG
    ```bash
   pass init tu_email@example.com
    ```

## Ejemplos de uso

| Comando                            | Descripción                                              |
|------------------------------------|----------------------------------------------------------|
| `pass insert nombre_servicio`      | Insertar una nueva contraseña (te pedirá la contraseña). |
| `pass generate nombre_servicio 20` | Generar una contraseña aleatoria de 20 caracteres.       |
| `pass show nombre_servicio`        | Mostrar la contraseña en pantalla (encriptada).          |
| `pass ls`                          | Listar todos los servicios guardados.                    |
| `pass rm nombre_servicio`          | Eliminar una entrada.                                    |

## Comando para autenticar con Docker

```bash
  # Modo seguro usando stdin para evitar exponer la contraseña en el historial del shell{
  PASSWORD=$(pass show docker/hub)
  docker login --username tu_usuario --password-stdin << $PASSWORD
  unset PASSWORD  # Limpia la variable después de usarla
```

```bash
   docker login -u <TU_USUARIO>> -p "$(pass show <RUTA_DE_LA_CONTRASEÑA>)" <REGISTRO_DOCKER>
   # Para Docker Hub (usando PAT almacenado en docker/hub):
   docker login -u tu_usuario -p "$(pass show docker/hub)" docker.io
   # docker.io es el registro predeterminado de Docker Hub.
   # Para un registro privado (ej: myregistry.example.com):
   docker login -u tu_usuario -p "$(pass show docker/private-registry)" myregistry.example.com
```

### Advertencias importantes

1. No expongas la contraseña en la historia del shell:
    * Si usas `$(pass show ...)` en la línea de comandos, la contraseña quedará en tu historial de shell
      ej: `~/.bash_history`).
    * Solución segura: Usa una variable temporal (evita historial):
        ```bash
        PASSWORD=$(pass show docker/hub)
        docker login -u tu_usuario -p "$PASSWORD" docker.io
        unset PASSWORD  # Limpia la variable después de usarla
        ```
2. Docker Hub requiere un Token de Acceso (PAT):
    * No uses tu contraseña real. En Docker Hub, crea un Personal Access Token en Settings → Security.
    * Almacena solo el token en Pass (ej: `docker/hub`).

### Ejemplo práctico paso a paso
1. Almacena el PAT en Pass
    ```bash
   echo "tu_token_de_acceso" | pass insert -m docker/hub
    ```
2. Autentícate con Docker (usando el token):
    ```bash
    PASS=$(pass show docker/hub)
    docker login -u tu_usuario -p "$PASS" docker.io
    unwset PASS  # Elimina el token de memoria
    ```