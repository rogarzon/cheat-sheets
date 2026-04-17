# Envsubst

Herramienta de línea de comandos para sustituir variables de entorno en cadenas de texto y archivos. Parte del paquete `gettext`.

## Sintaxis básica

```bash
envsubst [opciones] [archivo]
```

Si no se especifica un archivo, lee de stdin.

## Principales usos

### 1. Sustituir variables en un archivo

```bash
# Lee un archivo con variables y lo escribe en stdout
envsubst < config.template > config.out

# O usando redirección de entrada
envsubst < archivo.txt
```

### 2. Sustituir variables en múltiples archivos

```bash
# Sustituye variables en varios archivos
envsubst '$VAR1 $VAR2' < input.txt

# Sustituye todas las variables de entorno encontradas
envsubst < template.txt > output.txt
```

### 3. Usar stdin y stdout

```bash
echo "Hola $USER, bienvenido a $HOSTNAME" | envsubst
```

### 4. Escribir directamente a archivos de salida

```bash
# Con output explícito
envsubst -o salida.txt < entrada.txt

# Sin options, usando redirección
envsubst < entrada.txt > salida.txt
```

## Ejemplos prácticos

### Ejemplo 1: Sustitución en un archivo de plantilla

**plantilla.txt:**
```
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_USER=$DB_USER
DB_PASS=$DB_PASS
```

```bash
export DB_HOST=localhost
export DB_PORT=5432
export DB_USER=postgres
export DB_PASS=secreto123

envsubst < plantilla.txt
```

**Salida:**
```
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASS=secreto123
```

### Ejemplo 2: Usar con Docker Compose

```bash
# .env file
DB_PASSWORD=mi_contraseña_secreta
APP_ENV=production

# docker-compose.template.yml
# services:
#   db:
#     environment:
#       - POSTGRES_PASSWORD=$DB_PASSWORD
#       - APP_ENV=$APP_ENV

envsubst < docker-compose.template.yml > docker-compose.yml
```

### Ejemplo 3: Sustitución condicional (variables no definidas)

```bash
export NOMBRE="Juan"

echo "Hola $NOMBRE, bienvenido a $CIUDAD" | envsubst
# Salida: "Hola Juan, bienvenido a " (vacío si no definida)
```

## Ignorar (no sustituir) ciertas variables

### Método 1: Usar comillas simples

Las variables entre comillas simples **no se sustituyen**:

```bash
echo 'Este es un texto con $VARIABLE que no se sustituye' | envsubst
# Salida: Este es un texto con $VARIABLE que no se sustituye
```

### Método 2: Escapar el signo `$`

```bash
echo "Texto con \$VARIABLE_ignorada" | envsubst
# Salida: Texto con $VARIABLE_ignorada
```

### Método 3: Especificar qué variables sustituir

Solo sustituir variables específicas, dejando otras intactas:

```bash
# Solo sustituye $VAR1 y $VAR2, deja $VAR3 intacto
echo '$VAR1 $VAR2 $VAR3' | envsubst '$VAR1 $VAR2'
```

### Método 4: Usar variables no definidas

Si una variable no está definida en el entorno, se deja tal cual (como una cadena vacía):

```bash
export VAR1="valor1"

echo "$VAR1 $VAR2" | envsubst
# Salida: "valor1 " (VAR2 se deja vacío)
```

### Método 5: Combinar comillas simples y variables

```bash
# En este ejemplo, solo $VAR1 se sustituye
echo "Valor: $VAR1 y '$VAR2' y \\$VAR3" | envsubst
```

## Opciones útiles

| Opción | Descripción |
|--------|-------------|
| `-v`, `--version` | Mostrar versión |
| `-h`, `--help` | Mostrar ayuda |
| `-o archivo` | Especificar archivo de salida |
| `-i` | Leer de stdin (por defecto) |
| `--keep-unset` | Mantener variables no definidas (novacías) |

## Notas importantes

- `envsubst` no modifica archivos originales, solo escribe a stdout o archivo de salida
- Las variables no definidas se sustituyen por cadenas vacías
- Para evitar sustitución, usa comillas simples o escapa con `\`
- `envsubst` no procesa comandos dentro de `$()` - solo variables simples `$NOMBRE`
