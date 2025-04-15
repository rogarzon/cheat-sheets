# Tutorial de Docker

<!-- TOC -->
* [Tutorial de Docker](#tutorial-de-docker)
  * [Comandos básicos](#comandos-básicos)
    * [Información](#información)
    * [Listar imágenes](#listar-imágenes)
    * [Listar contenedores](#listar-contenedores)
    * [Listar contenedores detenidos](#listar-contenedores-detenidos)
    * [Listar volúmenes](#listar-volúmenes)
    * [Listar redes](#listar-redes)
    * [Listar imágenes no utilizadas](#listar-imágenes-no-utilizadas)
    * [Listar imágenes no utilizadas (sin filtro)](#listar-imágenes-no-utilizadas-sin-filtro)
    * [Eliminar imágenes no utilizadas](#eliminar-imágenes-no-utilizadas)
    * [Eliminar contenedores detenidos](#eliminar-contenedores-detenidos)
    * [Eliminar volúmenes no utilizados](#eliminar-volúmenes-no-utilizados)
    * [Eliminar redes no utilizadas](#eliminar-redes-no-utilizadas)
    * [Detener contenedor](#detener-contenedor)
    * [Reiniciar contenedor](#reiniciar-contenedor)
    * [Iniciar contenedor](#iniciar-contenedor)
<!-- TOC -->

## Comandos básicos

### Información

Para obtener información acerca del programa puedes ejecutar el siguiente comando:

```
docker info
```

### Listar imágenes

Para listar las imágenes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker images
```

### Listar contenedores

Para listar los contenedores que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker ps
```

### Listar contenedores detenidos

Para listar los contenedores detenidos que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker ps -a
```

### Listar volúmenes

Para listar los volúmenes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker volume ls
```

### Listar redes

Para listar las redes que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker network ls
```

### Listar imágenes no utilizadas

Para listar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```
docker images -f dangling=true
```

### Listar imágenes no utilizadas (sin filtro)

Para listar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```
docker images -f dangling=false
```

### Eliminar imágenes no utilizadas

Para eliminar las imágenes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```
docker rmi $(docker images -f dangling=true -q)
```

### Eliminar contenedores detenidos

Para eliminar los contenedores detenidos que tenemos en nuestro sistema, podemos usar el siguiente comando:

```
docker rm $(docker ps -a -q)
```

### Eliminar volúmenes no utilizados

Para eliminar los volúmenes que no están siendo utilizados por ningún contenedor, podemos usar el siguiente comando:

```
docker volume rm $(docker volume ls -qf dangling=true)
```

### Eliminar redes no utilizadas

Para eliminar las redes que no están siendo utilizadas por ningún contenedor, podemos usar el siguiente comando:

```
docker network rm $(docker network ls -q)
```

### Detener contenedor

Para detener un contenedor en ejecución, podemos usar el siguiente comando:

```
docker stop <container_id>
```

### Reiniciar contenedor

Para reiniciar un contenedor en ejecución, podemos usar el siguiente comando:

```
docker restart <container_id>
```

### Iniciar contenedor

Para iniciar un contenedor detenido, podemos usar el siguiente comando:

```
docker start <container_id>
```
