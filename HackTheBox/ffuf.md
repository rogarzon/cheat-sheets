# ffuf - Fuzzing Web Directory

ffuf (Fuzz Faster U Fool) es una herramienta de fuzzing web escrita en Go, diseñada para descubrir directorios, archivos, subdominios y endpoints ocultos en aplicaciones web.

<!-- TOC -->
* [ffuf - Fuzzing Web Directory](#ffuf---fuzzing-web-directory)
  * [Comandos Principales](#comandos-principales)
    * [Modo Directorio](#modo-directorio)
    * [Modo DNS](#modo-dns)
    * [Modo Host (VHost)](#modo-host-vhost)
  * [Opciones Más Importantes](#opciones-más-importantes)
    * [Flags de Input](#flags-de-input)
    * [Flags de Match/Filter](#flags-de-matchfilter)
    * [Flags de Configuración](#flags-de-configuración)
    * [Flags de Output](#flags-de-output)
  * [Variables de Fuzzing](#variables-de-fuzzing)
  * [Ejemplos de Uso](#ejemplos-de-uso)
  * [Wordlists Comunes](#wordlists-comunes)
<!-- TOC -->

## Comandos Principales

### Modo Directorio

```bash
ffuf -u https://target.com/FUZZ -w /path/to/wordlist.txt
```

### Modo DNS

```bash
ffuf -u https://target.com -w subdomains.txt -d "FUZZ.target.com"
```

### Modo Host (VHost)

```bash
ffuf -u https://target.com -w vhosts.txt -H "Host: FUZZ.target.com"
```

## Opciones Más Importantes

### Flags de Input

| Opción | Descripción |
|--------|-------------|
| `-u, --url` | URL objetivo con marcador FUZZ |
| `-w, --wordlist` | Ruta a la wordlist |
| `-d, --data` | Body para requests POST/PUT |
| `-f, --fc` | File extensiones (ej: `.php,.html`) |

### Flags de Match/Filter

| Opción | Descripción |
|--------|-------------|
| `-fc, --filter-code` | Filtrar por código HTTP (ej: `-fc 404`) |
| `-mc, --match-code` | Mostrar solo códigos HTTP (ej: `-mc 200`) |
| `-fl, --filter-length` | Filtrar por longitud de respuesta |
| `-ml, --match-length` | Mostrar solo longitudes específicas |
| `-fc, --filter-size` | Filtrar por tamaño (ej: `-fs 0`) |
| `-ff, --filter-regex` | Filtrar por regex en body |
| `-mf, --match-regex` | Mostrar matches de regex |

### Flags de Configuración

| Opción | Descripción |
|--------|-------------|
| `-t, --threads` | Número de threads (default: 40) |
| `-c, --cert` | Archivo de certificado client |
| `-k, --insecure` | Ignorar certificados SSL inválidos |
| `-H, --header` | Headers personalizados |
| `-b, --cookie` | Cookies para la sesión |
| `-x, --proxy` | Proxy HTTP (ej: `http://127.0.0.1:8080`) |
| `-m, --method` | Método HTTP (default: GET) |
| `-r, --follow-redirects` | Seguir redirects |
| `-s, --delay` | Delay entre requests |

### Flags de Output

| Opción | Descripción |
|--------|-------------|
| `-o, --output` | Archivo de salida |
| `-of, --output-format` | Formato: json, csv, psu, tree |
| `-v, --verbose` | Modo verbose |
| `-q, --quiet` | Modo silencioso |

## Variables de Fuzzing

| Variable | Descripción |
|----------|-------------|
| `FUZZ` | Fuzzing normal (URL/path) |
| `FUZZU` | Fuzzing uppercase |
| `FUZZlower` | Fuzzing lowercase |
| `FUZZL` | Fuzzing lowercase (slower) |
| `FUZZR` | Reverse wordlist |
| `FUZZe` | URL encode |
| `FUZZUe` | URL encode uppercase |
| `FUZZd` | Directory fuzzing (agrega /) |

## Ejemplos de Uso

```bash
# Básico - Directory enumeration
ffuf -u https://target.com/FUZZ -w /usr/share/seclist/Discovery/Web-Content/raft-small-directories.txt

# Con extensiones específicas
ffuf -u https://target.com/FUZZ.php -w wordlist.txt

# Con headers personalizados
ffuf -u https://target.com/admin/FUZZ -w wordlist.txt -H "Authorization: Bearer token123" -H "Accept: application/json"

# Fuzzing POST con JSON
ffuf -u https://target.com/api/login -w users.txt -H "Content-Type: application/json" -d '{"username":"FUZZ","password":"test"}'

# Filtrando por código HTTP
ffuf -u https://target.com/FUZZ -w wordlist.txt -mc 200,301,302

# Fuzzy match - ignorando respuestas similares a 404
ffuf -u https://target.com/FUZZ -w wordlist.txt -fc 404 -fs 0

# Búsqueda de subdominios
ffuf -u https://target.com -w /usr/share/seclist/Discovery/DNS/subdomains-top1million-5000.txt -H "Host: FUZZ.target.com"

# Con proxy para ver en Burp
ffuf -u https://target.com/FUZZ -w wordlist.txt -x http://127.0.0.1:8080

# Recursivo (búsqueda en directorios encontrados)
ffuf -u https://target.com/FUZZ -w wordlist.txt -recursion -recursion-depth 2

# Output en JSON
ffuf -u https://target.com/FUZZ -w wordlist.txt -o results.json -of json
```

## Wordlists Comunes

```bash
# Seclists
/usr/share/seclist/Discovery/Web-Content/
  - raft-small-directories.txt
  - raft-medium-directories.txt
  - common.txt
  - directory-list-2.3-medium.txt
  - php.txt, html.txt, js.txt

/usr/share/seclist/Discovery/DNS/
  - subdomains-top1million-5000.txt
  - subdomains-top1million-110000.txt

# Dirbuster
/usr/share/dirb/wordlists/
  - common.txt
  - big.txt
  - directories.txt

# Custom
/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```
