# wfuzz - Fuzzing Web Tool

wfuzz es una herramienta de fuzzing web escrita en Python, diseñada para descubrir recursos ocultos en aplicaciones web como directorios, archivos, parámetros y endpoints.

<!-- TOC -->
* [wfuzz - Fuzzing Web Tool](#wfuzz---fuzzing-web-tool)
  * [Comandos Principales](#comandos-principales)
    * [Modo Directorio](#modo-directorio)
    * [Modo DNS/Subdominios](#modo-dnssubdominios)
    * [Modo POST/Params](#modo-postparams)
  * [Opciones Más Importantes](#opciones-más-importantes)
  * [Filtros y Expresiones](#filtros-y-expresiones)
  * [Variables de Fuzzing](#variables-de-fuzzing)
  * [Ejemplos de Uso](#ejemplos-de-uso)
  * [Wordlists Comunes](#wordlists-comunes)
<!-- TOC -->

## Comandos Principales

### Modo Directorio

```bash
wfuzz -c -w /path/to/wordlist.txt -u https://target.com/FUZZ
```

### Modo DNS/Subdominios

```bash
wfuzz -c -w subdomains.txt -u https://target.com -H "Host: FUZZ.target.com"
```

### Modo POST/Params

```bash
wfuzz -c -w params.txt -d "user=FUZZ&pass=test" -u https://target.com/login
```

## Opciones Más Importantes

| Opción | Descripción |
|--------|-------------|
| `-w, --wordlist` | Wordlist a usar |
| `-u, --url` | URL objetivo (FUZZ es el marcador) |
| `-c` | Colorear salida |
| `-z, --payload` | Payload específico (ver abajo) |
| `-f, --filter` | Filtro por expresión |
| `-s, --sleep` | Delay entre requests |
| `-t, --threads` | Threads (default: 20) |
| `-o, --output` | Archivo de salida |
| `-O, --output-format` | Formato: all, json, simple, md, html |
| `-R, --recursion` | Búsqueda recursiva |
| `-r, --follow` | Seguir redirects |
| `-v, --verbose` | Modo verbose |
| `-H, --header` | Headers personalizados |
| `-b, --cookie` | Cookies |
| `-d, --data` | POST data |
| `-X, --method` | Método HTTP |

## Filtros y Expresiones

wfuzz permite filtrar resultados usando expresiones como:

| Filtro | Descripción |
|--------|-------------|
| `--filter=code` | Filtrar por código HTTP |
| `--filter=size` | Filtrar por tamaño |
| `--filter=line` | Filtrar por líneas |
| `--filter=word` | Filtrar por palabras |
| `--filter=duration` | Filtrar por duración |

**Ejemplos de filtros:**
- `--filter=code!404` - Excluir 404
- `--filter=code=200` - Solo 200
- `--filter=size>1000` - Tamaño mayor a 1000
- `--filter=code=200&size>500` - Múltiples condiciones

## Variables de Fuzzing

| Variable | Descripción |
|----------|-------------|
| `FUZZ` | Marcador por defecto |
| `FUZ2Z, FUZ3Z...` | Múltiples payloads simultáneos |
| `URL` | URL completa |
| `URLPORT` | Puerto de la URL |
| `URLPROTO` | Protocolo (http/https) |
| `URLHOST` | Host de la URL |
| `URLPATH` | Path de la URL |

## Ejemplos de Uso

```bash
# Básico - Directory enumeration
wfuzz -c -w /usr/share/seclist/Discovery/Web-Content/raft-small-directories.txt -u https://target.com/FUZZ

# Con extensiones
wfuf -c -w wordlist.txt -u https://target.com/FUZZ.php

# Con cookies y headers
wfuzz -c -w wordlist.txt -u https://target.com/admin/FUZZ -b "session=abc123" -H "X-API-Key: secret"

# POST fuzzing
wfuzz -c -w users.txt -d "username=FUZZ&password=secret" -u https://target.com/login

# Filtrando resultados
wfuzz -c -w wordlist.txt -u https://target.com/FUZZ --filter=code!404

# Múltiples payloads (combinatorio)
wfuzz -c -w wordlist1.txt -w wordlist2.txt -u https://target.com/FUZZ/FUZ2Z

# Búsqueda recursiva
wfuzz -c -w wordlist.txt -u https://target.com/FUZZ -R -v

# Output en JSON
wfuzz -c -w wordlist.txt -u https://target.com/FUZZ -o results.json -O json

# Con proxy
wfuzz -c -w wordlist.txt -u https://target.com/FUZZ --proxy=http://127.0.0.1:8080

# Subdominio fuzzing
wfuzz -c -w subdomains.txt -u https://target.com -H "Host: FUZZ.target.com"

# Fuzzing con sleep para evitar bloqueos
wfuzz -c -w wordlist.txt -u https://target.com/FUZZ -s 0.5 -t 10
```

## Wordlists Comunes

```bash
# Seclists
/usr/share/seclist/Discovery/Web-Content/
  - raft-small-directories.txt
  - raft-medium-directories.txt
  - common.txt
  - dirdroper.txt
  - php.txt, html.txt, js.txt

/usr/share/seclist/Discovery/DNS/
  - subdomains-top1million-5000.txt

# Dirbuster
/usr/share/dirb/wordlists/
  - common.txt, big.txt

# Otras
/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```
