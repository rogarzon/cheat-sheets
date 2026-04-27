# Curl cheatsheet

https://devhints.io/curl

## Options
```
-o <file>    # --output: write to file
-u user:pass # --user: Authentication
-v           # --verbose
-vv          # Even more verbose
-s           # --silent: don't show progress meter or errors
-S           # --show-error: when used with --silent (-sS), show errors but no progress meter
-i           # --include: Include the HTTP-header in the output
-I           # --head: headers only
```


## Request
```
-X POST          # --request
-L               # follow link if page redirects
-F               # --form: HTTP POST data for multipart/form-data
```

## Data
```
-d 'data'    # --data: HTTP post data, URL encoded (eg, status="Hello")
-d @file     # --data via file
-G           # --get: send -d data via get
```

## Headers
```
-A <str>         # --user-agent
-b name=val      # --cookie
-b FILE          # --cookie-file: read cookies from file
-c name=val      # --cookie-jar: send cookie
-c FILE          # --cookie-jar: save cookies to file
-H "X-Foo: y"    # --header
--compressed     # use deflate/gzip
```
 - You can capture cookies with `-c cookies.txt` and send them back with `-b cookies.txt`

## SSL
```
    --cacert <file>
    --capath <dir>

-E, --cert <cert>     # --cert: Client cert file
    --cert-type       # der/pem/eng
-k, --insecure        # for self-signed certs
```

## Examples
```bash
  #Post data:
  curl -d password=x http://x.com/y
```

```bash
  #Auth/data:
  curl -u user:pass -d status="Hello" http://twitter.com/statuses/update.xml
```

```bash
  #multipart file upload
  curl -v --include --form key1=value1 --form upload=@localfilename URL
```

```bash
  #multipart form: send data from text field and upload file
  curl -F person=anonymous -F secret=@file.txt http://example.com/submit.cgi
```

```bash
  #Use Curl to Check if a remote resource is available
  #details https://matthewsetter.com/check-if-file-is-available-with-curl/
  curl -o /dev/null --silent -Iw "%{http_code}" https://example.com/my.remote.tarball.gz
```

```bash
  #Send a request as Google Chrome
  curl -L \
  -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.118 Safari/537.36" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" \
  -H "Accept-Language: en-US,en;q=0.5" \
  -H "Accept-Encoding: gzip, deflate, br" \
  -H "Connection: keep-alive" \
  -H "Upgrade-Insecure-Requests: 1" \
  -H "Cache-Control: max-age=0" \
  -H "Sec-Fetch-Dest: document" \
  -H "Sec-Fetch-Mode: navigate" \
  -H "Sec-Fetch-Site: none" \
  -H "Sec-Fetch-User: ?1" \
  --compressed \
  "https://www.brou.com.uy/web/guest/cotizaciones"
```

## Transferencias de archivos (carpeta ↔ servidor)

### Descargar archivos desde servidor

```bash
# Descargar un archivo
curl -o archivo.zip https://ejemplo.com/ruta/archivo.zip

# Descargar guardando con el mismo nombre
curl -O https://ejemplo.com/ruta/archivo.zip

# Descargar múltiples archivos
curl -O https://ejemplo.com/file1.zip -O https://ejemplo.com/file2.zip

# Descargar archivo con autenticación
curl -u usuario:contraseña -O https://ejemplo.com/archivo.zip

# Descargar archivo privado con token
curl -H "Authorization: Bearer TOKEN" -O https://ejemplo.com/archivo.zip

# Descargar un directorio completo (recursivo)
curl -r -R https://ejemplo.com/directorio/

# Descargar con velocidad limitada (500KB/s)
curl --limit-rate 500k -O https://ejemplo.com/archivo-grande.iso
```

### Subir archivos a servidor

```bash
# Subir archivo mediante POST (multipart/form-data)
curl -X POST -F "file=@/ruta/local/archivo.txt" https://ejemplo.com/subir

# Subir archivo con campo personalizado
curl -X POST -F "archivo=@/home/usuario/documento.pdf" https://ejemplo.com/upload

# Subir archivo con autenticación
curl -u usuario:contraseña -X POST -F "file=@archivo.jpg" https://ejemplo.com/upload

# Subir archivo con token de autorización
curl -H "Authorization: Bearer TOKEN" -X POST -F "file=@archivo.png" https://ejemplo.com/api/upload

# Subir múltiples archivos
curl -X POST -F "files[]=@archivo1.jpg" -F "files[]=@archivo2.jpg" https://ejemplo.com/upload

# Subir archivo con metadata adicional
curl -X POST -F "file=@archivo.zip" -F "descripcion=Backup diario" -F "usuario=admin" https://ejemplo.com/upload
```

### Descargar carpetas completas (espejar)

```bash
# Descargar estructura de directorios completa
curl -R -r -O https://ejemplo.com/directorio/

# Descargar con seguimiento de enlaces
curl -L -R -O https://ejemplo.com/recursos/

# Descargar con timeout y reintentos
curl --connect-timeout 30 --max-time 300 -O https://ejemplo.com/archivo.zip
```

