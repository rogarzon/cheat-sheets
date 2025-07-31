# GNU grep

https://devhints.io/grep

## Usage

`grep <options> pattern <file...>`

## Matching options

```
-e, --regexp=PATTERN
-f, --file=FILE
-i, --ignore-case
-v, --invert-match
-w, --word-regexp
-x, --line-regexp
```

## Pattern options

```
-F, --fixed-strings   # list of fixed strings
-G, --basic-regexp    # basic regular expression (default)
-E, --extended-regexp # extended regular expression
-P, --perl-regexp     # perl compatible regular expression
```

## Expressions

_Basic Regular Expressions (BRE)_

**In BRE, these characters have a special meaning unless they are escaped with a backslash:**

`^ $ . * [ ] \`

- `^` matches the start of a line
- `$` matches the end of a line
- `.` matches any single character except a newline
- `*` matches zero or more occurrences of the preceding character
- `[ ]` defines a character class, matching any single character within the brackets
- `\` is used to escape special characters

**Example:**

```bash
grep '^foo.*bar$' file.txt
grep '^[a-zA-Z0-9_]*$' file.txt
grep '^[0-9]\{3\}-[0-9]\{2\
```

**However, these characters do not have any special meaning unless they are escaped with a backslash:**

`? + { } | ( )`

- `?` matches zero or one occurrence of the preceding character
- `+` matches one or more occurrences of the preceding character
- `{}` specifies a specific number of occurrences of the preceding character
- `|` is used for alternation (logical OR)
- `()` groups patterns together

**Example:**

```bash
  grep 'foo\?bar' file.txt # matches "bar" or "foobar"
  grep 'foo\+bar' file.txt # matches "foobar" but not "bar"
  grep 'foo\{2\}bar' file.txt # matches "foofoobar" but not "bar" or "foobar"
  grep 'foo\|bar' file.txt # matches "foo" or "bar"
  grep 'foo\(bar\|baz\)' file.txt # matches "foobar" or foobaz
```

_Extended Regular Expressions (ERE)_

**ERE gives all of these characters a special meaning unless they are escaped with a backslash:**

`^ $ . * + ? [ ] ( ) | { }`

- `^` matches the start of a line
- `$` matches the end of a line
- `.` matches any single character except a newline
- `*` matches zero or more occurrences of the preceding character
- `+` matches one or more occurrences of the preceding character
- `?` matches zero or one occurrence of the preceding character
- `[ ]` defines a character class, matching any single character within the brackets
- `()` groups patterns together
- `|` is used for alternation (logical OR)
- `{}` specifies a specific number of occurrences of the preceding character

**Example:**

```bash
grep -E '^foo.*bar$' file.txt # matches lines starting with "foo" and ending with "bar"
grep -E '^[a-zA-Z0-9_]*$' file.txt # matches lines containing only alphanumeric characters and underscores
grep -E '^[0-9]{3}-[0-9]{2}' # file.txt # matches lines starting with a three-digit number followed by a hyphen and a two-digit number
grep -E 'foo|bar' file.txt # matches lines containing either "foo" or "bar"
grep -E 'foo(bar|baz)' file.txt # matches lines containing "foobar
```

_Perl Compatible Regular Expressions (PCRE)_

**PCRE has even more options such as additional anchors and character classes, lookahead/lookbehind, conditional expressions, comments, and more. See
the regexp cheatsheet.**

## Output Options

```
-c, --count           # print the count of matching lines. suppresses normal output

    --color[=WHEN]    # applies color to the matches. WHEN is never, always, or auto
-m, --max-count=NUM   # stop reading after max count is reached
-o, --only-matching   # only print the matched part of a line
-q, --quiet, --silent
-s, --no-messages     # suppress error messages about nonexistent or unreadable files
```

## Context Options

```
-B NUM, --before-context=NUM  # print NUM lines before a match
-A NUM, --after-context=NUM   # print NUM lines after a match
-C NUM, -NUM, --context=NUM   # print NUM lines before and after a match
```

## Examples

```
Case insensitive: match any line in foo.txt that contains "bar"

grep -i bar foo.txt
```

```
Match any line in bar.txt that contains either "foo" or "oof"

grep -E "foo|oof" bar.txt
```

```
Match anything that resembles a URL in foo.txt and only print out the match

grep -oE "https?://((\w+[_-]?)+\.?)+" foo.txt
```

```
Can also be used with pipes:
match any line that contains "export" in
.bash_profile, pipe to another grep that
matches any of the first set of matches
containing "PATH"

grep "export" .bash_profile | grep "PATH"
```

```
follow the tail of server.log, pipe to grep
and print out any line that contains "error"
and include 5 lines of context

tail -f server.log | grep -iC 5 error
```