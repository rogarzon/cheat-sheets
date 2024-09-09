# tar cheatsheet
https://devhints.io/tar

Concatenate, Deflate, Inflate files

## Deflate / Inflate / Concatenate
### Deflate / Compress
`tar -czf archive.tar.gz /path/files`

### Inflate / Uncompress
`tar -xzf archive.tar.gz`

### Concatenate files into a single tar
`tar -cf archive.tar /path/files`

### Extract file to a defined directory
`tar -xzf archive.tar.gz -C /target/directory`

### Append a file to an existing archive
`tar -zu archive.tar.gz -C /target/file`

## Common options

* z	compress with gzip
* c	create an archive
* u	append files which are newer than the corresponding copy in the archive
* f	filename of the archive
* v	verbose, display what is inflated or deflated
* a	unlike of z, determine compression based on file extension