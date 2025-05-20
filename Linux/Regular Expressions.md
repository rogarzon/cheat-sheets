# Regular Expressions

<!-- TOC -->
* [Regular Expressions](#regular-expressions)
  * [Operadores de Agrupación](#operadores-de-agrupación)
  * [Operador OR](#operador-or)
  * [## Operador AND](#-operador-and)
<!-- TOC -->

## Operadores de Agrupación

| Operador | Descripción                                                                                                                                                                |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| (a)      | Los paréntesis redondos se usan para agrupar partes de una expresión regular. Dentro de los paréntesis, puedes definir patrones adicionales que se procesarán juntos.      |
| [a-z]    | Los corchetes se usan para definir clases de caracteres. Dentro de los corchetes, puedes especificar una lista de caracteres a buscar.                                     |
| {1,10}   | Las llaves se usan para definir cuantificadores. Dentro de las llaves, puedes especificar un número o un rango que indica cuántas veces debe repetirse un patrón anterior. |
| \|       | También llamado operador OR y muestra resultados cuando una de las dos expresiones coincide.                                                                               |
| .*       | Opera de manera similar a un operador AND mostrando resultados solo cuando ambas expresiones están presentes y coinciden en el orden especificado.                         |

Supongamos que usamos el operador `OR`. La expresión regular busca uno de los parámetros de búsqueda dados. En el siguiente ejemplo, buscamos líneas que contengan la palabra `my` o `false`. Para usar
estos operadores, necesitas aplicar la expresión regular extendida usando la opción `-E` en grep.

## Operador OR

```bash
 grep -E "(my|false)" /etc/passwd
```

## ## Operador AND

```bash
 grep -E "(my.*false)" /etc/passwd
```

Básicamente, lo que estamos diciendo con este comando es que estamos buscando una línea donde queremos ver tanto `my` como `false`. Un ejemplo simplificado sería usar grep dos veces, así:

```bash
 grep -E "my" /etc/passwd | grep -E "false"
```