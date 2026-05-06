# VIM - Editor de texto avanzado

## Modos de VIM

| Modo | Descripción | Comando |
|------|-------------|---------|
| **Normal** | Modo principal para navegación y comandos | `Esc` |
| **Insertar** | Para escribir texto | `i`, `a`, `o` |
| **Visual** | Seleccionar texto | `v` (carácter), `V` (línea), `Ctrl-v` (bloque) |
| **Ex/Command-line** | Para comandos | `:` |

## Comandos básicos

### Navegación
| Comando | Acción |
|---------|--------|
| `h`, `j`, `k`, `l` | Izquierda, abajo, arriba, derecha |
| `w`, `b` | Siguiente/anterior palabra |
| `0`, `$` | Inicio/fin de línea |
| `gg`, `G` | Inicio/fin del archivo |
| `Ctrl-f`, `Ctrl-b` | Página siguiente/anterior |
| `:N` + `Enter` | Ir a línea N |

### Edición
| Comando | Acción |
|---------|--------|
| `i` | Insertar antes del cursor |
| `a` | Insertar después del cursor |
| `o` | Nueva línea abajo |
| `x` | Borrar carácter |
| `dd` | Borrar línea |
| `yy` | Copiar línea (yank) |
| `p` | Pegar después del cursor |
| `u` | Deshacer |
| `Ctrl-r` | Rehacer |

### Guardar y salir
| Comando | Acción |
|---------|--------|
| `:w` | Guardar |
| `:q` | Salir |
| `:wq` o `:x` | Guardar y salir |
| `:q!` | Salir sin guardar |

### Búsqueda y reemplazo
| Comando | Acción |
|---------|--------|
| `/texto` | Buscar hacia adelante |
| `?texto` | Buscar hacia atrás |
| `n`, `N` | Siguiente/previo resultado |
| `:s/old/new/` | Reemplazar en línea actual |
| `:%s/old/new/g` | Reemplazar todo el archivo |
| `:%s/old/new/gc` | Reemplazar con confirmación |

## Ejemplos prácticos

### 1. Editar un archivo
```bash
vim archivo.txt
```
- Presiona `i` para entrar en modo insertar
- Escribe tu contenido
- Presiona `Esc` para volver al modo normal
- Escribe `:wq` para guardar y salir

### 2. Buscar y reemplazar
```vim
:%s/error/aviso/g
```
Reemplaza todas las ocurrencias de "error" por "aviso" en todo el archivo.

### 3. Copiar y pegar varias líneas
```vim
5yy    # Copia 5 líneas desde la posición actual
p      # Pega después del cursor
```

### 4. Buscar una palabra
```vim
/funcion  # Busca "funcion" en el archivo
n         # Siguiente ocurrencia
N         # Ocurrencia anterior
```

### 5. Eliminar todo el contenido
```vim
:dG      # Borra desde línea actual hasta el final
ggdG     # Borra todo el archivo
```

### 6. Ver número de líneas
```vim
:set number      # Mostrar números de línea
:set nonumber    # Ocultar números de línea
```

### 7. Comandos útiles
| Comando | Acción |
|---------|--------|
| `Ctrl-v` + `I` + texto | Insertar texto al inicio de múltiples líneas |
| `Ctrl-v` + `A` + texto | Insertar texto al final de múltiples líneas |
| `:set paste` | Modo paste (útil para pegar código) |
| `:w !sudo tee %` | Guardar archivo como superusuario |
