# [Bash scripting cheatsheet](https://devhints.io/bash)

<!-- TOC -->
* [Bash scripting cheatsheet](#bash-scripting-cheatsheet)
  * [Introducción](#introducción)
  * [String quotes](#string-quotes)
  * [Brace expansion](#brace-expansion)
  * [Conditional execution](#conditional-execution)
  * [Functions](#functions)
    * [Defining functions](#defining-functions)
    * [Returning values](#returning-values)
    * [Raising errors](#raising-errors)
    * [Arguments](#arguments)
  * [Arrays](#arrays)
    * [Defining arrays](#defining-arrays)
    * [Working with arrays](#working-with-arrays)
    * [Operations](#operations)
    * [Iteration](#iteration)
  * [Dictionaries](#dictionaries)
    * [Defining](#defining)
    * [Working with dictionaries](#working-with-dictionaries)
    * [Iteration](#iteration-1)
  * [Conditionals](#conditionals)
    * [File conditions](#file-conditions)
    * [Examples](#examples)
    * [Case](#case)
  * [Loops](#loops)
    * [Range](#range)
    * [Step](#step)
    * [C-like for loop](#c-like-for-loop)
    * [While](#while)
    * [Reading lines](#reading-lines)
    * [Until](#until)
<!-- TOC -->

## Introducción

Se comienza los archivos con la línea `#!/bin/bash` para indicar que se usará el intérprete de bash.

* [Learn bash in y minutes](https://learnxinyminutes.com/docs/bash/)
* [Bash Guide](http://mywiki.wooledge.org/BashGuide)
* [Bash Hackers Wiki](https://web.archive.org/web/20230406205817/https://wiki.bash-hackers.org/)

## String quotes

```bash
name="John"
echo "Hi $name"  #=> Hi John
echo 'Hi $name'  #=> Hi $name
```

## [Brace expansion](https://web.archive.org/web/20230207192110/https://wiki.bash-hackers.org/syntax/expansion/brace)

```bash

echo {A,B}.js
{A,B}           # Same as A B
{A,B}.js        # Same as A.js B.js
{1..5}          # Same as 1 2 3 4 5
{{1..3},{7..9}} # Same as 1 2 3 7 8 9
```

## Conditional execution

```bash 

git commit && git push
git commit || echo "Commit failed"
```

## [Functions](https://devhints.io/bash#functions)

### Defining functions

```bash 

get_name() {
  echo "John"
}

echo "You are $(get_name)"
```

### Returning values

```bash
myfunc() {
    local myresult='some value'
    echo "$myresult"
}

result=$(myfunc)
```

### Raising errors

```bash
myfunc() {
  return 1
}

if myfunc; then
  echo "success"
else
  echo "failure"
fi
```

### Arguments

```bash

$#    Number of arguments
$*    All positional arguments (as a single word)
$@    All positional arguments (as separate strings)
$1    First argument
$_    Last argument of the previous command
```

> Note: `$@` and `$*` must be quoted in order to perform as described. Otherwise, they do exactly the same thing (arguments as separate strings).
>
> [See Special parameters.](https://web.archive.org/web/20230318164746/https://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables)

## Arrays

### Defining arrays

```bash

Fruits=('Apple' 'Banana' 'Orange')

Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"
```

### Working with arrays

```bash

echo "${Fruits[0]}"           # Element #0
echo "${Fruits[-1]}"          # Last element
echo "${Fruits[@]}"           # All elements, space-separated
echo "${#Fruits[@]}"          # Number of elements
echo "${#Fruits}"             # String length of the 1st element
echo "${#Fruits[3]}"          # String length of the Nth element
echo "${Fruits[@]:3:2}"       # Range (from position 3, length 2)
echo "${!Fruits[@]}"          # Keys of all elements, space-separated
````

### Operations

```bash

Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits+=('Watermelon')                  # Also Push
Fruits=( "${Fruits[@]/Ap*/}" )          # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
words=($(< datafile))                   # From file (split by IFS)
```

### Iteration

```bash

for i in "${arrayName[@]}"; do
  echo "$i"
done
```

## Dictionaries

### Defining

```bash

declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
```

### Working with dictionaries

```bash

echo "${sounds[dog]}" # Dog's sound
echo "${sounds[@]}"   # All values
echo "${!sounds[@]}"  # All keys
echo "${#sounds[@]}"  # Number of elements
unset sounds[dog]     # Delete dog
```

### Iteration

```bash

#Iterate over values
for val in "${sounds[@]}"; do
  echo "$val"
done

#Iterate over keys
for key in "${!sounds[@]}"; do
  echo "$key"
done
```

## Conditionals

Note that [[ is actually a command/program that returns either 0 (true) or 1 (false). Any program that obeys the same logic (like all base utils, such as grep(1) or ping(1)) can be used as condition,
see examples.

```bash

[[ -z STRING ]]         Empty string
[[ -n STRING ]]         Not empty string
[[ STRING == STRING ]]  Equal
[[ STRING != STRING ]]  Not Equal
[[ NUM -eq NUM ]]       Equal
[[ NUM -ne NUM ]]       Not equal
[[ NUM -lt NUM ]]       Less than
[[ NUM -le NUM ]]       Less than or equal
[[ NUM -gt NUM ]]       Greater than
[[ NUM -ge NUM ]]       Greater than or equal
[[ STRING =~ STRING ]]  Regexp
(( NUM < NUM ))         Numeric conditions
[[ -o noclobber ]]      If OPTIONNAME is enabled
[[ ! EXPR ]]            Not
[[ X && Y ]]            And
[[ X || Y ]]            Or
```

### File conditions

```bash 

[[ -e FILE ]]             Exists
[[ -r FILE ]]             Readable
[[ -h FILE ]]             Symlink
[[ -d FILE ]]             Directory
[[ -w FILE ]]             Writable
[[ -s FILE ]]             Size is > 0 bytes
[[ -f FILE ]]             File
[[ -x FILE ]]             Executable
[[ FILE1 -nt FILE2 ]]     1 is more recent than 2
[[ FILE1 -ot FILE2 ]]     2 is more recent than 1
[[ FILE1 -ef FILE2 ]]     Same files
```

### Examples

```bash

# String
if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
else
  echo "This never happens"
fi

# Combinations
if [[ X && Y ]]; then
  ...
fi

# Equal
if [[ "$A" == "$B" ]]

# Regex
if [[ "A" =~ . ]]

if (( $a < $b )); then
   echo "$a is smaller than $b"
fi

if [[ -e "file.txt" ]]; then
  echo "file exists"
fi
```

### Case

```bash

case "$variable" in
  pattern1)
    # commands
    ;;
  pattern2|pattern3)
    # commands
    ;;
  *)
    # default commands
    ;;
esac
```

## Loops

### Range

```bash

for i in {1..5}; do
   echo "Número $i"
done
```

### Step

```bash

for i in {5..50..5}; do
    echo "Welcome $i"
done
```

### C-like for loop

```bash

for ((i = 0 ; i < 100 ; i++)); do
  echo "$i"
done
```

### While

```bash

count=1
while [[ $count -le 5 ]]; do
  echo "Número $count"
  ((count++))
done
```

### Reading lines

```bash 

while read -r line; do
  echo "$line"
done < file.txt
```

### Until

```bash 
count=1
until [[ $count -gt 5 ]]; do
  echo "Número $count"
  ((count++))
done
```