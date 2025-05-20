# Python Tips & Tricks

<!-- TOC -->
* [Python Tips & Tricks](#python-tips--tricks)
  * [Crear un servidor web](#crear-un-servidor-web)
<!-- TOC -->

## Crear un servidor web

Crear un servidor web para servir archivos estáticos en el directorio actual es muy fácil con Python. Solo necesitas ejecutar el siguiente comando en la terminal:

* `<port>` Si no se especifica, el puerto por defecto es 8000.
* `--directory <directory>` Si no se especifica, el directorio por defecto es el directorio actual.

```bash
    python -m http.server <port>
```
