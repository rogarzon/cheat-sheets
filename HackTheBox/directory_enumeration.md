# Gobuster - Directory Enumeration

<!-- TOC -->
* [Gobuster - Directory Enumeration](#gobuster---directory-enumeration)
  * [Comandos Principales](#comandos-principales)
    * [Modo Directorio](#modo-directorio)
    * [Modo DNS](#modo-dns)
    * [Modo Subdominios](#modo-subdominios)
  * [Opciones Más Importantes](#opciones-más-importantes)
  * [Ejemplos de Uso](#ejemplos-de-uso)
  * [Wordlists Comunes](#wordlists-comunes)
  * [Búsqueda de Archivos por Extensión](#búsqueda-de-archivos-por-extensión)
    * [Wordlists Especializadas para Archivos](#wordlists-especializadas-para-archivos)
<!-- TOC -->

## Comandos Principales

### Modo Directorio

```bash
gobuster dir -u <URL> -w <wordlist>
```

### Modo DNS

```bash
gobuster dns -d <dominio> -w <wordlist>
```

### Modo Subdominios

```bash
gobuster subdomain -d <dominio> -w <wordlist>
```

## Opciones Más Importantes

| Opción               | Descripción                                                 |
|----------------------|-------------------------------------------------------------|
| `-u, --url`          | URL objetivo (obligatorio para dir)                         |
| `-w, --wordlist`     | Ruta a la wordlist (obligatorio)                            |
| `-t, --threads`      | Número de threads (default: 10)                             |
| `-o, --output`       | Archivo de salida                                           |
| `-p, --path`         | Ruta inicial (ej: `/api`, `/admin`)                         |
| `-f, --fuzz`         | Modo fuzzing (agrega / al final)                            |
| `-a, --useragent`    | User-agent personalizado                                    |
| `--headers`          | Headers HTTP personalizados                                 |
| `-k, --tls-insecure` | Ignorar certificados TLS inválidos                          |
| `-n, --no-content`   | No mostrar tamaño de respuesta                              |
| `-c, --cookies`      | Cookies para la sesión                                      |
| `-m, --mode`         | Modo: dir, dns, subdomain                                   |
| `-r, --recursion`    | Búsqueda recursiva                                          |
| `-s, --status-codes` | Códigos HTTP válidos (default: 200,204,301,302,307,401,403) |
| `-z, --no-zip`       | No comprimir respuesta                                      |
| `-x, --extensions`   | Extensiones a buscar (ej: .php,.html)                       |
| `-v, --verbose`      | Salida detallada                                            |
| `-q, --quiet`        | Modo silencioso                                             |

## Ejemplos de Uso

```bash
# Básico
gobuster dir -u http://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

# Con opciones avanzadas
gobuster dir -u https://target.com -w wordlist.txt -t 20 -f -k -a "Mozilla/5.0"

# Con authentication
gobuster dir -u http://target.com -w wordlist.txt -H "Authorization: Bearer TOKEN"

# Recursivo
gobuster dir -u http://target.com -w wordlist.txt -r -s 200,301,302
```

## Wordlists Comunes

- `/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt`
- `/usr/share/wordlists/dirbuster/directory-list-2.3-big.txt`
- `/usr/share/seclist/Discovery/Web-Content/directory-list-2.3-medium.txt`
- `/usr/share/seclist/Discovery/Web-Content/common.txt`

## Búsqueda de Archivos por Extensión

Para buscar archivos específicos como PHP, HTML o JS, se puede usar el flag `-x` seguido de las extensiones:

```bash
# Buscar archivos PHP
gobuster dir -u http://target.com -w wordlist.txt -x .php

# Buscar archivos HTML y HTM
gobuster dir -u http://target.com -w wordlist.txt -x .html,.htm

# Buscar archivos JS
gobuster dir -u http://target.com -w wordlist.txt -x .js

# Múltiples extensiones
gobuster dir -u http://target.com -w wordlist.txt -x .php,.html,.js,.txt,.bak,.old

# Combinado con recursión
gobuster dir -u http://target.com -w wordlist.txt -x .php -r
```

### Wordlists Especializadas para Archivos

| Extensiones | Wordlist                          |
|-------------|-----------------------------------|
| `.php`      | `php.txt`, `dirdroper.txt`        |
| `.html`     | `html.txt`                        |
| `.js`       | `javascript.txt`                  |
| All         | `raft-small-files.txt`, `all.txt` |

**Ubicaciones comunes:**

- `/usr/share/seclist/Discovery/Web-Content/`
- `/usr/share/dirb/wordlists/`