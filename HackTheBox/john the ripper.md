# John the Ripper

## Descripción

John the Ripper (JTR) es una herramienta de cracking de contraseñas de código abierto que permite descubrir contraseñas débiles a través de ataques de fuerza bruta, diccionario y variaciones de palabras. Es ampliamente utilizada en auditorías de seguridad y pentesting para evaluar la robustez de contraseñas almacenadas.

## Principales Usos y Ejemplos

### 0. Herramientas del kit John the Ripper

El kit de herramientas de JTR incluye varios utilidades para extraer hashes de diferentes formatos:

| Herramienta | Propósito |
|-------------|-----------|
| `john` | Principal - crackea hashes |
| `zip2john` | Extrae hashes de archivos ZIP |
| `pdf2john` | Extrae hashes de archivos PDF |
| `ssh2john` | Extrae hashes de claves SSH |
| `unshadow` | Combina /etc/passwd y /etc/shadow |
| `pkzip2john` | Extrae hashes de archivos PKZip |
| `hmail2john` | Extrae hashes de archivos hMail |
| `lastpass2john` | Extrae hashes de LastPass |

### 1. Crackear hashes con modo automático

```bash
john hashes.txt
```

### 2. Crackear usando un diccionario

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
```

### 3. Crackear hashes específicos (por tipo)

```bash
# Hashes de Windows (NTLM)
john --format=NT hashes.txt

# Hashes SHA-512 (Linux)
john --format=sha512crypt hashes.txt

# Hashes MD5 (Linux)
john --format=md5crypt hashes.txt
```

### 4. Modo de fuerza bruta

```bash
# Generador interno de john (solo una palabra)
john --format=NT --single hashes.txt

# Con reglas aplicadas
john --format=md5crypt --rules hashes.txt
```

### 5. Usar reglas para variar palabras del diccionario

```bash
john --wordlist=rockyou.txt --rules hashes.txt
```

### 6. Listar formatos de hash soportados

```bash
john --list=formats
```

### 7. Ver tipos de hash descubiertos

```bash
john --list=crypt-formats
```

### 8. Crackear contraseñas de archivos ZIP

```bash
# Extraer hash usando zip2john
zip2john archivo.zip > hash_zip.txt
john hash_zip.txt

# O directamente con john (versiones recientes)
john --format=zip archivo.zip
```

### 9. Crackear contraseñas de archivos PDF

```bash
# Extraer hash usando pdf2john
pdf2john archivo.pdf > hash_pdf.txt
john hash_pdf.txt

# Ver contraseñas descubiertas
john --show hash_pdf.txt
```

### 10. Ver contraseñas descubiertas

```bash
john --show hashes.txt
```

### 11. Guardar progreso y reanudar

```bash
# John guarda automáticamente el progreso en ~/.john/john.ini
# Para reanudar, simplemente ejecuta john de nuevo
john hashes.txt
```

### 12. Crackear hashes de shadow

```bash
# Extraer hashes del sistema
unshadow /etc/passwd /etc/shadow > shadow_hashes.txt
john shadow_hashes.txt

# Especificar formato si es necesario
john --format=sha512crypt shadow_hashes.txt
```

### 13. Crackear hashes de MySQL

```bash
# Extraer hashes de MySQL (formato 4.1+)
john --format=mysql-sha1 hash_mysql.txt
```

### 14. Crackear hashes de Oracle

```bash
# Oracle 10g
john --format=oracle11 hash_oracle.txt
```

### 15. Crackear hashes con reglas personalizadas

```bash
# Usar reglas personalizadas desde un archivo
john --wordlist=rockyou.txt --rules --rules=CustomHash.cfg hashes.txt

# Ejemplo de reglas en archivo .cfg
[List.Rules:Custom]
# Añadir números comunes al final
z0 z1 z2 z3 z4 z5 z6 z7 z8 z9
# Capitalizar primera letra
c
```

### 16. Crackear claves SSH con ssh2john

```bash
# Extraer hash de una clave privada SSH
ssh2john clave_privada > hash_ssh.txt
john hash_ssh.txt
```

### 17. crackear múltiples hashes en paralelo

```bash
# Usar múltiples hilos
john --fork=4 hash_multi.txt

# Verificar progreso
john --status
```

### 18. Modo wordlist con reglas avanzadas

```bash
# Aplicar múltiples reglas
john --wordlist=rockyou.txt --rules=all hashes.txt

# Usar reglas específicas
john --wordlist=rockyou.txt --rules=WordListManager hashes.txt

## Formatos comunes de hash

| Tipo | Formato en John | Descripción |
|------|-----------------|-------------|
| MD5 (Linux) | `md5crypt` | Hashes de /etc/shadow con MD5 |
| SHA-256 (Linux) | `sha256crypt` | Hashes de /etc/shadow con SHA-256 |
| SHA-512 (Linux) | `sha512crypt` | Hashes de /etc/shadow con SHA-512 |
| NTLM (Windows) | `NT` | Hashes LM/NTLM de Windows |
| bcrypt | `bcrypt` | Hashes con algoritmo bcrypt |
| DES (Unix clásico) | `descrypt` | Hashes DES tradicionales |
| MySQL | `mysql-sha1` | Hashes MySQL 4.1+ |
| Oracle 10g | `oracle11` | Hashes Oracle 11g |
| PostgreSQL | `pgpwd` | Hashes PostgreSQL |
| Cisco PVLAN | `cisco-type7` | Hashes Cisco type 7 |

## Notas

- Para extraer hashes de `/etc/shadow`: `unshadow /etc/passwd /etc/shadow > hashes.txt`
- El cracking efectivo depende de la complejidad de la contraseña y el poder de cómputo disponible

## Comandos útiles

```bash
# Ver status del cracking actual
john --status

# Limpiar estado anterior (borrar progreso)
rm ~/.john/john.ini

# Formato automático (john detecta el tipo de hash)
john hashes.txt

# Reiniciar cracking (ignorar progreso guardado)
john --format=sha512crypt --restore=0 hashes.txt
```
