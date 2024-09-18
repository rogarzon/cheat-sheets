# Linux

https://www.freecodecamp.org/news/learn-linux-for-beginners-book-basic-to-advanced/

## CPU architecture

The `lscpu` command in Linux is used to display information about the CPU architecture. When you run lscpu in the
terminal, it provides details such as:

* The architecture of the CPU (for example, x86_64)
* CPU op-mode(s) (for example, 32-bit, 64-bit)
* Byte Order (for example, Little Endian)
* CPU(s) (number of CPUs), and so on

## The Linux File-system Hierarchy

| Location | Purpose                                                                     |
|:---------|:----------------------------------------------------------------------------|
| /bin     | Essential command binaries                                                  |
| /boot    | Static files of the boot loader, needed in order to start the boot process. |
| /etc     | Host-specific system configuration                                          |
| /home    | User home directories                                                       |
| /root    | Home directory for the administrative root user                             |
| /lib     | Essential shared libraries and kernel modules                               |
| /mnt     | Mount point for mounting a filesystem temporarily                           |
| /opt     | Add-on application software packages                                        |
| /usr     | Installed software and shared libraries                                     |
| /var     | Variable data that is also persistent between boots                         |
| /tmp     | Temporary files that are accessible to all users                            |

> You can check your file system using the `tree -d -L 1` command. **You can modify the -L flag to change the depth of
the tree**.

## `cd` Command shortcuts

| Command      | 	Description              |
|:-------------|:--------------------------|
| `cd .. `     | 	Go back one directory    |
| `cd ../..`   | 	Go back two directories  |
| `cd or cd ~` | 	Go to the home directory |
| `cd -`       | 	Go to the previous path  |

## create directories recursively using the -p option

`mkdir -p tools/index/helper-scripts`

.
└── tools
└── index
└── helper-scripts

## Creating new files using the `touch` command

The touch command creates an empty file. You can use it like this:

`touch file.txt`

> The file names can be chained together if you want to create multiple files in a single command.
> `touch file1.txt file2.txt file3.txt`

## Removing files and directories using the `rm` and `rmdir` command

You can use the `rm` command to remove both files and non-empty directories

| Command           | 	Description                                                  |
|:------------------|:--------------------------------------------------------------|
| `rm file.txt`     | 	Removes the file file.txt                                    |
| `rm -r directory` | 	Removes the directory directory and its contents             |
| `rm -f file.txt`  | 	Removes the file file.txt without prompting for confirmation |
| `rmdir directory` | 	Removes an empty directory                                   |

> Note that you should use the `-f` flag with caution as you won't be asked before deleting a file. Also, be careful
> when running `rm` commands in the `root` folder as it might result in deleting important system files.

## Moving and renaming files and folders using the `mv` command

The `mv` command is used to move files and folders from one directory to the other.

`mv file1.txt backup/`

To move a directory and its contents:

`mv dir1/ backup/`

Renaming files and folders in Linux is also done with the `mv` command.

`mv file1.txt file2.txt`

Rename a directory from **dir1** to **dir2**:
`mv dir1 dir2`
