# Find

<!-- TOC -->
* [Find](#find)
  * [Usage](#usage)
  * [Conditions](#conditions)
  * [Condition flow](#condition-flow)
  * [Actions](#actions)
  * [Access time conditions](#access-time-conditions)
  * [File sizes](#file-sizes)
  * [Examples](#examples)
<!-- TOC -->

https://devhints.io/find

https://www.ionos.es/digitalguide/servidores/configuracion/comando-linux-find/#:~:text=Para%20encontrar%20un%20archivo%20en,todas%20las%20distribuciones%20de%20Linux.

## Usage

`find <path> <conditions> <actions>`

## Conditions

```
-name "*.c"
-iname


-user jonathan     # Filtrar por propietario
-nouser
-group             # Filtrar por grupo 


-type f            # File
-type d            # Directory
-type l            # Symlink


-maxdepth 3        # At most 3 levels deep
-mindepth 1        # At least 1 level deep
-regex PATTERN


-size 8            # Exactly 8 512-bit blocks
-size -128c        # Smaller than 128 bytes
-size 1440k        # Exactly 1440KiB
-size +10M         # Larger than 10MiB
-size +2G          # Larger than 2GiB
-empty


-newer   file.txt
-newerm  file.txt # modified newer than file.txt
-newerX  file.txt # [c]hange, [m]odified, [B]create
-newerXt "1 hour ago"    # [t]imestamp


-perm              # Filtrar por derechos de archivo 
```

## Condition flow

```
\! -name "*.c" # NOT named "*.c"
\( x -or y \)


-and               # Los resultados de la búsqueda deben cumplir ambas condiciones
-or                # Los resultados de la búsqueda deben cumplir al menos una de las dos condiciones
-not               # Negar la condición posterior
```

## Actions

```
-exec rm {} \;
-print
-delete
```

## Access time conditions

```
-atime 0           # Last accessed between now and 24 hours ago
-atime +0          # Accessed more than 24 hours ago
-atime 1           # Accessed between 24 and 48 hours ago
-atime +1          # Accessed more than 48 hours ago
-atime -1          # Accessed less than 24 hours ago (same a 0)
-ctime -6h30m      # File status changed within the last 6 hours and 30 minutes
-mtime +1w         # Last modified more than 1 week ago
```

## File sizes

```
c                  # Bytes
k                  # Kilobytes
M                  # Megabytes
G                  # Gigabytes
b                  # 512-byte bloques

+                  # El archivo es mayor que el tamaño indicado
-                  # El archivo es más pequeño que el tamaño indicado
```

## Examples

```bash
  find . -name '*.jpg'
  find . -name '*.jpg' -exec rm {} \;
  find . -type f -iname “*.jpeg” -or -iname “*.jpg”
```

```bash
  find . -newerBt "24 hours ago"
  find . -type f -ctime +100                  # encontrar archivos creados hace más de 100 días
  find . -type f -atime +2 -and -atime -6     # archivos a los que se accedió hace entre tres y cinco días
  find . -type f -mmin -5                     # archivos cuyos cambios tienen menos de cinco minutos de antigüedad
```

```bash
  find . -type f -mtime +29 # find files modified more than 30 days ago
  find . -type f -newermt 2016-08-07 \! -newermt 2016-08-08 # find in date range
```

```bash
  find . -size -500M
  find . -size +400M -and -size -500M
  find . -type f -empty
  find . -type d -empty
```

```bash
  find . -user $(whoami)                      #  archivos propiedad del propio usuario
  find . -group admin
  find . -perm 777                            # archivos totalmente accesibles para cualquier usuario
  find . -perm 700                            # archivos a los que solo puede acceder el propietario
```

```bash
  find . -type f -maxdepth 2 -size +50M
  find . -type f -mindepth 3 -and -maxdepth 5 -size +50M
```

```bash 
  find . -maxdepth 1 -exec chown www-data:www-data {} \;
  find . -type f -maxdepth 1 -perm 777 -exec chmod 664 {} \;
  find . -type d -maxdepth 1 -exec chmod 755 {} \;
  find . -type d -maxdepth 1 -empty -ok rmdir {} \;
  find . -type f -maxdepth 1 -empty -ok rm {} \;
```

```bash
  find / -type f -name *.conf -user root -size +20k -newermt 2020-03-03 -exec ls -al {} \; 2>/dev/null
```

```bash
  #Obtiene los archivos .html en el directorio actual que no contienen "brou" en su nombre
  find . -maxdepth 1 -type f -name "*.html" -and -not -name "*brou*"
```

| Option              | Description                                                                                                                                |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| -type f             | Hereby, we define the type of the searched object. In this case, 'f' stands for 'file'.                                                    |
| -name \*.conf       | With '-name', we indicate the name of the file we are looking for. The asterisk (\*) stands for 'all' files with the '.conf' extension.    |
| -user root          | This option filters all files whose owner is the root user.                                                                                |
| -size +20k          | We can then filter all the located files and specify that we only want to see the files that are larger than 20 KiB.                       |
| -newermt 2020-03-03 | With this option, we set the date. Only files newer than the specified date will be presented.                                             |
| -exec ls -al {} \;  | This option executes the specified command, using the curly brackets as placeholders for each result. The backslash escapes the semicolon. |
| 2>/dev/null         | This is a STDERR redirection to the 'null device'. This redirection ensures that no errors are displayed in the terminal.                  |


