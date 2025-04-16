# Tutorial de Docker

<!-- TOC -->
* [Tutorial de Docker](#tutorial-de-docker)
  * [Introducción](#introducción)
  * [Instalación](#instalación)
    * [Post instalación](#post-instalación)
  * [Comandos básicos](#comandos-básicos)
    * [Información](#información)
    * [Limpieza](#limpieza)
  * [Dockerfile](#dockerfile)
    * [FROM](#from)
    * [WORKDIR](#workdir)
    * [COPY](#copy)
    * [ADD](#add)
    * [RUN](#run)
    * [EXPOSE](#expose)
    * [ENV](#env)
    * [VOLUME](#volume)
    * [LABEL](#label)
    * [CMD](#cmd)
    * [ENTRYPOINT](#entrypoint)
  * [Imágenes](#imágenes)
    * [Crear una imágen](#crear-una-imágen)
    * [Ejecutar una imágen y exponer puertos](#ejecutar-una-imágen-y-exponer-puertos)
    * [Listar imágenes](#listar-imágenes)
    * [Listar imágenes no utilizadas](#listar-imágenes-no-utilizadas)
    * [Listar imágenes no utilizadas (sin filtro)](#listar-imágenes-no-utilizadas-sin-filtro)
    * [Eliminar imágenes no utilizadas](#eliminar-imágenes-no-utilizadas)
    * [Inspeccionar una imágen](#inspeccionar-una-imágen)
  * [Contenedores](#contenedores)
    * [Listar contenedores](#listar-contenedores)
    * [Eliminar contenedores detenidos](#eliminar-contenedores-detenidos)
    * [Eliminar redes no utilizadas](#eliminar-redes-no-utilizadas)
    * [Detener contenedor](#detener-contenedor)
    * [Reiniciar contenedor](#reiniciar-contenedor)
    * [Iniciar contenedor](#iniciar-contenedor)
    * [Escuchar en consola las salidas del contenedor](#escuchar-en-consola-las-salidas-del-contenedor)
    * [Ver los logs de un contendor](#ver-los-logs-de-un-contendor)
    * [Copiar archivos desde y hacia un contenedor](#copiar-archivos-desde-y-hacia-un-contenedor)
    * [Acceder a un contenedor en ejecución](#acceder-a-un-contenedor-en-ejecución)
  * [Volúmenes](#volúmenes)
    * [Tipos de volúmenes](#tipos-de-volúmenes)
    * [Listar volúmenes](#listar-volúmenes)
    * [Eliminar volúmenes no utilizados](#eliminar-volúmenes-no-utilizados)
    * [Inspeccionar un volumen](#inspeccionar-un-volumen)
  * [Bind mounts](#bind-mounts)
  * [Redes](#redes)
    * [Listar redes](#listar-redes)
  * [Argumentos <ARG> y variables de entorno <ENV>](#argumentos-arg-y-variables-de-entorno-env)
<!-- TOC -->

## Introducción

Docker es una plataforma de software que permite crear, probar y desplegar aplicaciones en contenedores. Los contenedores son entornos ligeros y portátiles que incluyen todo lo necesario para ejecutar
una aplicación, lo que facilita su despliegue en diferentes entornos sin preocuparse por las dependencias del sistema operativo.

Para ver las imágenes disponibles por docker hub puedes visitar el siguiente enlace: [Docker Hub](https://hub.docker.com/)

## Instalación

* [Docker Engine](https://docs.docker.com/engine/install/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Post instalación

* [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)

  Para poder ejecutar los comandos de Docker sin necesidad de usar `sudo`, puedes agregar tu usuario al grupo `docker` con el siguiente comando:

    ```bash
     sudo usermod -aG docker $USER
     # Activar los cambios en el grupo
     newgrp docker
     # Verificar si puedes usar docker sin sudo
     docker run hello-world
    ```

## Comandos básicos

### Información

Para obtener información acerca del programa puedes ejecutar el siguiente comando:

```bash 
 docker info
```

### Limpieza

El comando `docker prune` se utiliza para limpiar recursos no utilizados en Docker. Existen varias variantes:

* `docker system prune`: Elimina contenedores detenidos, redes no utilizadas, imágenes no referenciadas y volúmenes no utilizados.
* `docker container prune`: Elimina contenedores detenidos.
* `docker image prune`: Elimina imágenes no referenciadas.
* `docker volume prune`: Elimina volúmenes no utilizados.
* `docker network prune`: Elimina redes no utilizadas.

Se recomienda usarlo con precaución, ya que elimina recursos de forma permanente.

## Dockerfile

Estos comandos permiten personalizar y optimizar la construcción de imágenes Docker.

### FROM

La instrucción FROM se utiliza para especificar la imagen base a partir de la cual se construirá la nueva imagen. La imagen base puede ser una imagen oficial de Docker Hub o una imagen personalizada.

`FROM ubuntu:20.04`

### WORKDIR

Establece el directorio de trabajo para las instrucciones RUN, CMD, ENTRYPOINT, COPY y ADD que siguen en el Dockerfile. Si el directorio no existe, se creará.

`WORKDIR /app`

### COPY

Copia archivos o directorios desde el host al sistema de archivos de la imagen.

`COPY . /app/`

> **Nota:** Se puede ignorar archivos a copiar usando un archivo `.dockerignore`, similar a `.gitignore`.

### ADD

Copia archivos o directorios desde el host al sistema de archivos de la imagen. También puede descomprimir archivos tar.

`ADD . /app/`
`ADD https://example.com/file.tar.gz /app/`

### RUN

Ejecuta comandos durante la construcción de la imagen. Se ejecutarán en la carpeta de trabajo especificada por WORKDIR. Se pueden usar para instalar paquetes, copiar archivos, etc.

`RUN apt-get update && apt-get install -y python3`
`RUN pip install -r requirements.txt`
`RUN npm install`

### EXPOSE

Expone un puerto específico para que los contenedores puedan comunicarse entre sí. No publica el puerto en el host.

`EXPOSE 80`

### ENV

Establece variables de entorno en la imagen. Estas variables estarán disponibles para los procesos que se ejecuten en el contenedor.

`ENV APP_ENV=production`

### VOLUME

Crea un punto de montaje (anónimo) en el contenedor. Permite que los datos persistan incluso si el contenedor se elimina.

`VOLUME ["/app/data"]`

### LABEL

Agrega metadatos a la imagen. Los metadatos son pares de clave-valor que pueden ser utilizados para organizar y categorizar imágenes.

`LABEL version="1.0" description="My Docker image"`

### CMD

Especifica el comando que se ejecutará cuando se inicie un contenedor a partir de la imagen. Solo puede haber una instrucción CMD en un Dockerfile. Si hay varias, solo se ejecutará la última.

`CMD ["python3", "app.py"]`

### ENTRYPOINT

Especifica el comando que se ejecutará cuando se inicie un contenedor a partir de la imagen. A diferencia de CMD, ENTRYPOINT no puede ser sobrescrito al ejecutar el contenedor.

`ENTRYPOINT ["python3", "app.py"]`

## Imágenes

### Crear una imágen

Para crear una imagen a partir de un Dockerfile, podemos usar el siguiente comando:

```bash
 docker build -t <image_name> .
```

Donde `<image_name>` es el nombre que le queremos dar a la imagen, `-t` es la forma corta de --tag y `.` indica la ubicación del fichero **Dockerfile**, el cual está el directorio actual.
El tag se utiliza para etiquetar la imagen con un nombre y una versión. Por ejemplo, `my_image:1.0` etiquetaría la imagen como `my_image` con la versión `1.0`.

### Ejecutar una imágen y exponer puertos

Para ejecutar una imagen y exponer puertos, podemos usar el siguiente comando:

```bash
 docker run -p <host_port>:<container_port> <image_name>
```

Donde `<host_port>` es el puerto del host que queremos exponer, `<container_port>` es el puerto del contenedor que queremos exponer y `<image_name>` es el nombre de la imagen que queremos ejecutar.

### Listar imágenes

Para listar las imágenes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```bash
 docker images
```

### Listar imágenes no utilizadas

Para listar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```bash
 docker images -f dangling=true
```

### Listar imágenes no utilizadas (sin filtro)

Para listar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```bash
 docker images -f dangling=false
```

### Eliminar imágenes no utilizadas

Para eliminar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```bash
 docker rmi $(docker images -f dangling=true -q)
```

### Inspeccionar una imágen

Para inspeccionar una imagen y ver su configuración, podemos usar el siguiente comando:

```bash
 docker inspect <image_id>
```

## Contenedores

El comando `docker run` se utiliza para crear y ejecutar un contenedor a partir de una imagen. La sintaxis básica es:

```bash
 docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

La opción -d se utiliza para ejecutar el contenedor en segundo plano (modo "detached"). Esto significa que el contenedor se ejecutará en segundo plano y no bloqueará la terminal.

```bash
 docker run -d <image_name>
```

La opción -p se utiliza para mapear un puerto del contenedor a un puerto del host. Esto permite acceder a servicios que se ejecutan dentro del contenedor desde el host.

```bash
 docker run -p <host_port>:<container_port> <image_name>
```

La opción `-it` se utiliza para ejecutar un contenedor en modo interactivo. Esto significa que podrás interactuar con el contenedor a través de la terminal.

```bash
 docker run -it <image_name>
```

La opción `--name` se utiliza para asignar un nombre al contenedor. Esto es útil para identificar el contenedor más fácilmente.

```bash
 docker run --name <container_name> <image_name>
```

La opción `--rm` se utiliza para eliminar automáticamente el contenedor cuando se detiene. Esto es útil para evitar que queden contenedores detenidos en el sistema.

```bash
 docker run --rm <image_name>
```

La opción `-v` se utiliza para montar un [volumen](#volúmenes) en el contenedor. Esto permite compartir archivos entre el host y el contenedor.

```bash
 docker run -v <host_path>:<container_path> <image_name>
```

Si en `<host_path>` se especifica un nombre, Docker montará el volumen nombrado, pero si se especifica una ruta del host, Docker montará un [bind mount](#bind-mounts).
En el caso de no especificarse `<host_path>` y solo `<container_name>`, Docker creará un volumen anónimo.

```bash
 docker run -v <volume_name>:<container_path> <image_name>
```

### Listar contenedores

Para listar los contenedores que tenemos en nuestro sistema, podemos usar el siguiente comando:

```bash
 docker ps
```

La opción `-a` podemos listar todos los contenedores, incluyendo los que están detenidos:

```bash
 docker ps -a
```

### Eliminar contenedores detenidos

Para eliminar los contenedores detenidos que tenemos en nuestro sistema, podemos usar el siguiente comando:

```bash
 docker rm $(docker ps -a -q)
```

### Eliminar redes no utilizadas

Para eliminar las redes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```bash
 docker network rm $(docker network ls -q)
```

### Detener contenedor

Para detener un contenedor en ejecución, podemos usar el siguiente comando:

```bash
 docker stop <container_id> or <container_name>
```

### Reiniciar contenedor

Para reiniciar un contenedor en ejecución, podemos usar el siguiente comando:

```bash
 docker restart <container_id> or <container_name>
```

### Iniciar contenedor

Para iniciar un contenedor detenido, podemos usar el siguiente comando:

```bash
 docker start <container_id> or <container_name>
```

La opción` -a` se utiliza para adjuntar la salida del contenedor a la terminal actual. Esto significa que verás la salida del contenedor en tiempo real.

```bash
 docker start -a <container_id> or <container_name>
```

### Escuchar en consola las salidas del contenedor

Para adjuntarse a un contenedor en ejecución (escuchar las salidas en consola del contenedor), podemos usar el siguiente comando:

```bash
 docker attach <container_id> or <container_name>
```

### Ver los logs de un contendor

Para ver los logs de un contenedor en ejecución, podemos usar el siguiente comando:

```bash
 docker logs <container_id> or <container_name>
```

La opción `-f` se utiliza para seguir los logs en tiempo real. Esto significa que el comando mostrará los logs a medida que se generen, permitiendo ver la salida en tiempo real.

```bash
 docker logs -f <container_id> or <container_name>
```

### Copiar archivos desde y hacia un contenedor

Para copiar archivos desde un contenedor al host, podemos usar el siguiente comando:

```bash
 docker cp <container_id> or <container_name>:<path_in_container> <path_on_host>
```

### Acceder a un contenedor en ejecución

Para acceder a un contenedor en ejecución, podemos usar el siguiente comando:

```bash
 docker exec -it <container_id> or <container_name> /bin/bash
```

## Volúmenes

Los volúmenes son una forma de persistir datos generados y utilizados por contenedores. Los volúmenes específicos tienen mayor prioridad que los genéricos, por lo que si un contenedor tiene un volumen
específico y otro contenedor tiene un volumen genérico, por ejemplo, `-v /app/node_module`, tendrá prioridad sobre el volumen `-v $(pwd):/app` ya que indica una sub carpeta. Esto se puede usar para
evitar que ciertas partes se sobreescriban dentro del contenedor en el momento de su creación.

### Tipos de volúmenes

* **Volúmen Anónimo**
    * Se borra cuando el contenedor es eliminado (atado al contenedor)
    * Evita que se sobreescriban ciertas partes del contenedor
    * No se debe usar para compartir datos entre contenedores

```bash
  docker run``` -v <container_path> <image_name>
  ```

```dockerfile
  VOLUME ["<container_path>", ..]
  # Or 
  VOLUME <container_path> ...
```

* **Volumen nombrado**
    * No están atados a un contenedor (no se eliminan cuando se elimina el contenedor, solo mediante el comando `docker volume rm <volume_name>`)
    * Se pueden compartir entre contenedores

```bash
  docker run``` -v <volume_name>:<container_path> <image_name>
  ```

* **Bind Mount**
    * Se montan directorios del host en el contenedor
    * Los cambios en los archivos del host se reflejan en el contenedor y viceversa
    * Se pueden usar para compartir archivos entre el host y el contenedor
    * En ocasiones conviene hacerlos de **solo lectura** para el contenedor, de tal forma que no se puedan modificar los archivos del host desde el contenedor, esto se indica adicionando `:ro` al
      final
    * No son manejados por Docker

```bash
  docker run -v <host_path>:<container_path> <image_name>
  # Bind mount de sólo lectura para el contenedor
  docker run -v <host_path>:<container_path>:ro <image_name>
  ```

### Listar volúmenes

Para listar los volúmenes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```bash
 docker volume ls
```

### Eliminar volúmenes no utilizados

Para eliminar los volúmenes que no están siendo utilizados por ningún contenedor, podemos usar el siguiente comando:

```bash
 docker volume rm $(docker volume ls -qf dangling=true)
```

### Inspeccionar un volumen

Para inspeccionar un volumen y ver su configuración, podemos usar el siguiente comando:

```bash
 docker volume inspect <volume_name>
```

## Bind mounts

Los bind mounts son una forma de montar un directorio del host en un contenedor. Esto permite compartir archivos entre el host y el contenedor, los cambios en los archivos del host se reflejan en el
contendor, lo que es útil para el desarrollo y la depuración.
Para crear un bind mount, podemos usar el siguiente comando:

```bash
 docker run -v <host_path>:<container_path> <image_name>
```

> **Nota:** Cuidado cuando se asocie el directorio de trabajo del contenedor con un directorio del host, ya que los archivos del host pueden sobrescribir los archivos del contenedor (los copiados
> mediante la instrucción `COPY` en el **Dockerfile** y otros comandos como `RUN npm install`) y así eliminar las dependencias instaladas.
>
> Para solucionar esto le indicamos a Docker que hay archivos en el contenedor que no queremos que se sobrescriban, para ello podemos usar un volumen anónimo, la instrucción `VOLUME` en el *
*Dockerfile**, o ambos. Por ejemplo:
>  ```bash
>  docker run -v <host_path>:<container_path> -v <container_path> <image_name>
> # Ejemplo con NodeJS, la carpeta node_modules estaría a salvo de ser sobreescrita
>  docker run -v $(pwd):app -v app/node_modules <image_name>
>  ```

## Redes

### Listar redes

Para listar las redes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```bash
 docker network ls
```

## Argumentos <ARG> y variables de entorno <ENV>

* **Argumentos `<ARG>`**
    * Se definen en el Dockerfile con la instrucción `ARG`
    * Se pueden usar para pasar variables al momento de construir la imagen
    * No están disponibles en tiempo de ejecución
    * Se pueden usar para personalizar la construcción de la imagen

```dockerfile
  ARG <arg_name>=<default_value>
```

```bash
    docker build --build-arg <arg_name>=<value> -t <image_name> .
```

* **Variables de entorno `<ENV>`**
    * Se definen en el Dockerfile con la instrucción `ENV`
    * Se pueden usar para pasar variables al contenedor en tiempo de ejecución
    * Están disponibles en tiempo de ejecución
    * Se pueden usar para personalizar la configuración del contenedor

```dockerfile
  # Se define la variable
  ENV <env_name>=<value>
  # Se hace uso de la variable
  ${env_name}
```

```bash
    docker run -e <env_name>=<value> <image_name>
    # Usando un archivo de variables de entorno ejemplo .env
    docker run --env-file <file_name> <image_name>
```