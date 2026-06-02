# Jq cheatsheet

https://jq-playbook.com/

## Tipos de datos
```
string   # Cadena de texto
number   # Número (entero o decimal)
boolean  # true o false
null     # valor nulo
array    # Lista ordenada de valores
object   # Mapa de pares clave-valor
```

## Filtros básicos

```
.          # Identity: devuelve la entrada tal cual
.[]        # Array: desempaqueta un array
.key       # Object: accede a una propiedad
."key"     # Object: accede a propiedad con caracteres especiales
.[][]      # Array anidado: desempaqueta arrays dentro de arrays
```

## Filtros avanzados

```
.[] | select(condition)   # Filtra elementos que cumplen condición
.[] | select(.prop > 10)  # Filtra por propiedad numérica
.[] | select(.prop == "value")  # Filtra por propiedad de string
.[] | select(.prop != null)     # Filtra por propiedad no nula
```

## Operadores

```
+    # Suma o concatenación
-    # Resta
*    # Multiplicación
/    # División
==   # Igualdad
!=   # Desigualdad
>    # Mayor que
<    # Menor que
>=   # Mayor o igual
<=   # Menor o igual
and  # Y lógico
or   # O lógico
not  # Negación
```

## Funciones útiles

```
length          # Longitud de string, array o object
has(key)        # Verifica si object tiene una key
keys            # Devuelve array de keys de un object
to_entries      # Convierte object a array de {key, value}
from_entries    # Convierte array de {key, value} a object
map(function)   # Aplica función a cada elemento de array
sort, sort_by   # Ordena array
unique          # Elimina duplicados de array
. // value      # Valor por defecto si es null o false
```

## Formatos de salida

```
-j           # JSON sin formato (compacto)
-c           # Compact JSON (una línea por objeto)
-a           # Array output para select
-r           # Raw output (sin comillas para strings)
--xml2json   # Convierte XML a JSON (jq --xml2json)
--slurp      # Lee múltiples líneas como array
--raw-input  # Lee input como strings
```

## Ejemplos

### Arrays
```bash
# Obtener primer elemento
echo '[1,2,3]' | jq '.[0]'
# Output: 1

# Obtener últimos 2 elementos
echo '[1,2,3,4]' | jq '.[-2:]'
# Output: [3,4]

# Mapear array
echo '[1,2,3]' | jq '.[] * 2'
# Output: 2\n3\n6

# Filtrar elementos > 2
echo '[1,2,3,4]' | jq '.[] | select(. > 2)'
# Output: 3\n4
```

### Objetos
```bash
# Acceder a propiedad anidada
echo '{"a":{"b":"c"}}' | jq '.a.b'
# Output: "c"

# Cambiar valor de propiedad
echo '{"a":1}' | jq '.a = 2'
# Output: {"a":2}

# Añadir nueva propiedad
echo '{"a":1}' | jq '. + {"b":2}'
# Output: {"a":1,"b":2}

# Eliminar propiedad
echo '{"a":1,"b":2}' | jq 'del(.b)'
# Output: {"a":1}
```

### Filtrado y transformación
```bash
# Filtrar array de objetos
echo '[{"a":1,"b":2},{"a":2,"b":1}]' | jq '.[] | select(.a == 1)'
# Output: {"a":1,"b":2}

# Extraer solo propiedades específicas
echo '[{"a":1,"b":2},{"a":3,"b":4}]' | jq '.[] | {a}'
# Output: {"a":1}\n{"a":3}

# Renombrar propiedades
echo '{"a":1}' | jq '. as $x | {x: $x.a}'
# Output: {"x":1}
```

### Con entrada de JSON
```bash
# Usar --slurp para leer múltiples JSON
echo '{"a":1}\n{"b":2}' | jq -s '.'
# Output: [{"a":1},{"b":2}]

# Usar --raw-input para leer como strings
echo 'hello\nworld' | jq -R . 
# Output: "hello"\n"world"

# Leer desde archivo
jq '.name' data.json

# Leer desde URL
curl -s https://api.example.com/data | jq '.result'
```

### Filtros combinados
```bash
# Pipeline de filtros
echo '{"a":[1,2,3]}' | jq '.a | .[] | select(. > 1) | . * 2'
# Output: 4\n6

# Función con condicional
echo '1' | jq 'if . > 0 then "positive" else "negative" end'
# Output: "positive"

# Operador de coalescencia
echo 'null' | jq '. // "default"'
# Output: "default"
```

### Formato de salida
```bash
# Output raw (sin comillas)
echo '{"name":"John"}' | jq -r '.name'
# Output: John

# Output compacto
echo '{"a":[1,2,3]}' | jq -c '.[]'
# Output: 1\n2\n3

# Array en una línea
echo '[1,2,3]' | jq -a '.'
# Output: [1,2,3]
```

### Trabajo con JSON anidado
```bash
# Acceder a deep nested
echo '{"a":{"b":{"c":[1,2,3]}}}' | jq '.a.b.c[0]'
# Output: 1

# Mapear sobre array anidado
echo '{"a":[[1,2],[3,4]]}' | jq '.a | .[] | .[]'
# Output: 1\n2\n3\n4

# Filtrar y aplanar
echo '{"a":[{"b":[1,2]},{"b":[3,4]}]}' | jq '.a[].b[] | select(. > 1)'
# Output: 2\n3\n4
```

### Trabajo con llaves dinámicas
```bash
# Obtener valor de key en variable
echo '{"key1":1,"key2":2}' | jq 'keys[0] as $k | .[$k]'
# Output: 1

# Convertir object a array
echo '{"a":1,"b":2}' | jq 'to_entries'
# Output: [{"key":"a","value":1},{"key":"b","value":2}]

# Filtrar por key
echo '{"a":1,"b":2}' | jq 'to_entries | .[] | select(.key == "a") | .value'
# Output: 1
```
