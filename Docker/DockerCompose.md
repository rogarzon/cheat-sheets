<!-- TOC -->
* [Docker Compose](#docker-compose)
  * [Version](#version)
  * [Services](#services)
    * [Image](#image)
    * [Build](#build)
    * [Container_name](#container_name)
    * [Volumes](#volumes)
    * [Environment o Env_file](#environment-o-env_file)
    * [Ports](#ports)
    * [Networks](#networks)
    * [Depends_on](#depends_on)
    * [stdin_open y tty](#stdin_open-y-tty)
    * [command](#command)
<!-- TOC -->

# [Docker Compose](https://docs.docker.com/reference/compose-file/)

Docker Compose es una herramienta que permite definir y ejecutar aplicaciones Docker de múltiples contenedores. Con Compose, puedes usar un archivo YAML para configurar los servicios de tu aplicación.

* Los contenedores son removidos una vez que se detienen.
* Por defecto se crea una red para los servicios.
* `docker-compose up` Inicializa el proceso de construcción y ejecución de los contenedores. Debe ejecutarse en el mismo directorio donde se encuentra el archivo `docker-compose.yml`.
    * `-d` modo "detached".
    * `--build` Fuerza la reconstrucción de las imágenes antes de iniciar los contenedores.
* `docker-compose down` Detiene y elimina los contenedores, redes creados por `docker-compose up`.
    * `--volumes` o `-v` Elimina los volúmenes creados por `docker-compose up`.
* `docker-compose build` Construye o reconstruye los servicios.
* `docker-compose run <service_name>` Ejecuta un solo servicio. (También usado en los contenedores de utilidad) 
  * `--rm` Elimina el contenedor después de que se detiene.

## Version

La versión de Docker Compose se especifica al inicio del archivo YAML y define las características del fichero. La versión más reciente es la 3.8, pero puedes usar versiones anteriores si es
necesario.

```yaml
version: '3.8'
```

## Services

Los servicios son los contenedores que componen tu aplicación. Cada servicio se define con un nombre y una configuración específica.

```yaml
services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: example
```

### Image

La imagen que se utilizará para crear el contenedor. Puedes usar imágenes de Docker Hub o imágenes personalizadas.

```yaml
image: nginx
```

### Build

Ruta al Dockerfile para construir la imagen _**(Forma simple)**_. Puedes especificar un contexto de construcción y un Dockerfile específico, así como argumentos, etc.

* `context`: Ruta al directorio donde se encuentra el Dockerfile o al directorio en el cual Dockerfile realiza las operaciones, como `COPY . .` etc.
* `dockerfile`: Nombre del Dockerfile a usar (si no es el predeterminado `Dockerfile`).
* `args`: Argumentos que se pasarán al Dockerfile durante la construcción de la imagen.

```yaml
build:
  context: .
  dockerfile: Dockerfile
  args:
    MY_ARG: value
```

### Container_name

Nombre del contenedor. Si no se especifica, Docker generará un nombre aleatorio.

```yaml
container_name: my_container
```

### Volumes

Volúmenes que se montarán en el contenedor. Puedes usar volúmenes nombrados o bind mounts.

```yaml
volumes:
  - ./data:/data
  - data:/data/db:ro
```

> **Nota:** Los volúmenes nombrados también deben especificarse al mismo nivel que la sección `services` al final del archivo docker compose, si se usa en varios contenedores, docker lo compartirá.
> Ej.
> ```yaml
> version: '3.8'
> services:
>  ....
>   volumes:
>     - data:/data/db
>   ....
> 
> volumes: 
>  data:

### Environment o Env_file

Variables de entorno que se establecerán en el contenedor. Puedes definirlas directamente en el archivo YAML o leerlas de un archivo .env .

```yaml
environment:
  MYSQL_ROOT_PASSWORD: example
```

Ó

```yaml
env_file:
  - ./env/.env
```

### Ports

Puertos que se expondrán en el contenedor. Puedes mapear puertos del host a puertos del contenedor.

```yaml
ports:
  - "80:80"
```

### Networks

Redes a las que se conectará el contenedor. Puedes definir redes personalizadas en el archivo YAML.

```yaml
networks:
  my_network:
    driver: bridge
```

### Depends_on

Define la dependencia entre servicios. Esto asegura que un servicio se inicie solo después de que otro servicio esté disponible.

```yaml
depends_on:
  - db
```

### stdin_open y tty

Habilita la entrada estándar (stdin) y un terminal virtual para el contenedor. Esto es útil si deseas interactuar con el contenedor a través de la terminal.

```yaml
stdin_open: true
tty: true
```

### command
Sobrescribe el comando predeterminado de la imagen. Esto es útil si deseas ejecutar un comando diferente al iniciar el contenedor.

```yaml
command: ["python", "app.py"]
```