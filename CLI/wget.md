# wget

Herramienta de línea de comandos para descargar archivos desde la web (HTTP, HTTPS, FTP).

## Tabla de contenidos

- [Sintaxis básica](#sintaxis-básica)
- [Opciones principales](#opciones-principales)
- [Ejemplos prácticos](#ejemplos-prácticos)
- [Opciones de tiempo](#opciones-de-tiempo)
- [Tablas de flags](#tablas-de-flags)

## Flags utilizadas

| Flag | Descripción |
|------|-------------|
| `-O` | Especificar nombre de archivo de salida |
| `-i` | Descargar URLs desde un archivo |
| `-r` | Descarga recursiva |
| `-l` | Especificar profundidad de recursión |
| `-m` | Modo mirror (descarga recursiva + timestamps) |
| `--limit-rate` | Limitar velocidad de descarga |
| `-c` | Reanudar descarga interrumpida |
| `-b` | Descargar en segundo plano |
| `--no-check-certificate` | Ignorar certificados SSL inválidos |
| `--proxy` | Habilitar proxy |
| `--proxy-user` | Usuario para proxy |
| `--proxy-password` | Contraseña para proxy |
| `--user` | Usuario para autenticación HTTP |
| `--password` | Contraseña para autenticación HTTP |
| `-np` | No ascender al directorio padre |
| `-v` | Modo verbose |
| `-d` | Modo debug |
| `--tries` | Número máximo de intentos |
| `--wait` | Espera entre intentos |
| `--connect-timeout` | Timeout de conexión |
| `--page-requisites` | Descargar elementos necesarios para mostrar la página |
| `--convert-links` | Convertir enlaces para funcionar localmente |
| `--no-parent` | No subir al directorio padre |
| `-E` | Ajustar extensiones de archivos |
| `-k` | Convertir enlaces absolutos en relativos |
| `-K` | Guardar archivos originales antes de modificarlos |
| `-D` | Limitar dominios a los especificados |

## Sintaxis básica
```bash
wget [opciones] URL
```

## Opciones principales

### Descarga básica
```bash
wget https://example.com/file.zip
```

### Descargar con nombre de archivo específico
```bash
wget -O nombre_archivo.zip https://example.com/file.zip
```

### Descargar múltiples archivos
```bash
wget url1 url2 url3
# o desde archivo:
wget -i lista_urls.txt
```

### Descarga recursiva (espejo de sitio)
```bash
wget -r https://example.com
wget -r -l 2 https://example.com    # profundidad 2 niveles
wget -m https://example.com          # mirror (descarga recursiva + timestamps)
```

### Limitar velocidad
```bash
wget --limit-rate=1m https://example.com/large-file.zip  # 1 MB/s
```

### Reanudar descarga interrumpida
```bash
wget -c https://example.com/large-file.zip
```

### Descargar en segundo plano
```bash
wget -b https://example.com/large-file.zip
# Ver log:
tail -f wget-log
```

### Ignorar certificados SSL inválidos
```bash
wget --no-check-certificate https://example.com
```

### Usar proxy
```bash
wget --proxy=on --proxy-user=user --proxy-password=pass https://example.com
```

### Descargar con autenticación HTTP
```bash
wget --user=usuario --password=contraseña https://example.com/protected
```

### Seguir enlaces (ascenso de directorios)
```bash
wget -r -np https://example.com/dir/    # -np: no subir al padre
```

### Verbose / Debug
```bash
wget -v https://example.com      # verbose
wget -d https://example.com      # debug
```

## Ejemplos prácticos

```bash
# Descargar una imagen
wget -O logo.png https://example.com/images/logo.png

# Descargar página web completa
wget --page-requisites --convert-links --no-parent https://example.com/page.html

# Espejar un repositorio de documentación
wget -m -p -E -k -K -D example.com https://example.com/docs/
```

## Opciones de tiempo
```bash
wget --tries=10           # Intentos máximos (default: 20)
wget --wait=5             # Espera entre intentos
wget --connect-timeout=10 # Timeout de conexión
```
