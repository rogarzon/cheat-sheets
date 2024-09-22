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

## Locating Files and Folders Using the `find` Command

The `find` command lets you efficiently search for files, folders, and character and block devices.

`find /path/ -type f -name file-to-search`

* `/path` is the path where the file is expected to be found. This is the starting point for searching files. The path
  can also be/or . which represents the root and current directory, respectively.
* `-type` represents the file descriptors. They can be any of the below:
* `f` – Regular file such as text files, images, and hidden files.
* `d` – Directory. These are the folders under consideration.
* `l` – Symbolic link. Symbolic links point to files and are similar to shortcuts.
* `c` – Character devices. Files that are used to access character devices are called character device files. Drivers
  communicate with character devices by sending and receiving single characters (bytes, octets). Examples include
  keyboards, sound cards, and the mouse.
* `b` – Block devices. Files that are used to access block devices are called block device files. Drivers communicate
  with block devices by sending and receiving entire blocks of data. Examples include USB and CD-ROM
* `-name` is the name of the file type that you want to search.

### How to search files by name or extension

Suppose we need to find files that contain **"style"** in their name. We'll use this command:

`find . -type f -name "style*"`

Now let's say we want to find files with a particular extension like **.html**. We'll modify the command like this:

`find . -type f -name "*.html"`

### How to search hidden files

A dot at the beginning of the filename represents hidden files. They are normally hidden but can be viewed with `ls -a`
in the current directory.

We can modify the find command as shown below to search for hidden files:

`find . -type f -name ".*"`

### How to search log files and configuration files

Log files usually have the extension **.log**, and we can find them like this:

`find . -type f -name "*.log"`

Similarly, we can search for configuration files like this:

`find . -type f -name "*.conf"`

### How to search other files by type

We can search for character block files by providing `c` to `-type`:

`find / -type c`

Similarly, we can find device block files by using `b`:

`find / -type b`

### How to search directories

In the example below, we are finding the folders using the `-type d` flag.

`find . -type d `

### How to search files by size

An incredibly helpful use of the `find` command is to list files based on a particular size.

`find / -size +250M`

Here, we are listing files whose size exceeds 250MB.

Other units include:

* G: GigaBytes.
* M: MegaBytes.
* K: KiloBytes
* c : bytes.

Just replace with the relevant unit.

`find <directory> -type f -size +N<Unit Type>`

### How to search files by modification time

By using the `-mtime` flag, you can filter files and folders based on the modification time.

`find /path -name "*.txt" -mtime -10`

For example,

* -mtime +10 means you are looking for a file modified 10 days ago.
* -mtime -10 means less than 10 days.
* -mtime 10 If you skip + or – it means exactly 10 days.

## Concatenate and display files using the `cat` command

The `cat` command in Linux is used to display the contents of a file. It can also be used to concatenate files and
create new files.

Here is the basic syntax of the cat command:

`cat [options] [file]`

For example, if you want to view the contents of a file named **file.txt**, you can use the following command:

`cat file.txt`

This will display all the contents of the file on the terminal at once.

## Viewing text files interactively using `less` and `more`

While `cat` displays the entire file at once, `less` and `more` allow you to view the contents of a file interactively.
This is useful when you want to scroll through a large file or search for specific content.

The syntax of the less command is:

`less [options] [file]`

The `more` command is similar to `less` but has fewer features. It is used to display the contents of a file one screen
at a time.

The syntax of the `more` command is:

`more [options] [file]`

For both commands, you can use the `spacebar` to scroll one page down, the `Enter` key to scroll one line down, and the
`q` key to exit the viewer.

To move backward you can use the `b` key, and to move forward you can use the `f` key.

## Displaying the last part of files using `tail`

Sometimes you might need to view just the last few lines of a file instead of the entire file. The `tail` command in
Linux is used to display the last part of a file.

For example, `tail file.txt` will **display the last 10 lines of the file file.txt** by default.

If you want to display a different number of lines, you can use the `-n` option followed by the number of lines you want
to display.

`tail -n 50 file.txt`

> **Tip:** Another usage of the tail is its follow-along (`-f`) option. This option enables you to view the contents of
> a file as they are being written. This is a useful utility for viewing and monitoring log files in real-time.

## Displaying the beginning of files using `head`

Just like `tail` displays the last part of a file, you can use the `head` command in Linux to display the beginning of a
file.

For example, `head file.txt` will display the **first 10 lines of the file file.txt** by default.

To change the number of lines displayed, you can use the `-n` option followed by the number of lines you want to
display.

## Counting words, lines, and characters using `wc`

You can count words, lines and characters in a file using the wc command.

For example, running `wc syslog.log` gave me the following output:

**1669 9623 64367 syslog.log**

In the output above,

* 1669 represents the number of lines in the file **syslog.log**.
* 9623 represents the number of words in the file **syslog.log**.
* 64367 represents the number of characters in the file **syslog.log**.

## Comparing files line by line using `diff`

The basic syntax of the diff command is:

`diff [options] file1 file2`

\# contents of hello.py\
def greet(name):\
return f"Hello, {name}!"

user = input("Enter your name: ")\
print(greet(user))

\# contents of also-hello.py\
def greet(name):\
return fHello, {name}!

user = input(Enter your name: )\
print(greet(user))\
print("Nice to meet you")

### Check whether the files are the same or not

`diff -q hello.py also-hello.py`
> Output
>
>Files hello.py and also-hello.py differ

### See how the files differ. For that, you can use the `-u` flag to see a unified output:

`diff -u hello.py also-hello.py`

1. --- hello.py 2024-05-24 18:31:29.891690478 +0500
2. +++ also-hello.py 2024-05-24 18:32:17.207921795 +0500
3. @@ -3,4 +3,5 @@
4.
5. user = input(Enter your name: )
6. print(greet(user))
7. +print("Nice to meet you")

In the above output:

* `--- hello.py 2024-05-24 18:31:29.891690478 +0500` indicates the file being compared and its timestamp.
* `+++ also-hello.py 2024-05-24 18:32:17.207921795 +0500` indicates the other file being compared and its timestamp.
* `@@ -3,4 +3,5 @@` shows the line numbers where the changes occur. In this case, it indicates that lines 3 to 4 in the
  original file have changed to lines 3 to 5 in the modified file.
* `user = input(Enter your name: )` is a line from the original file.
* `print(greet(user))` is another line from the original file.
* `+print("Nice to meet you")` is the additional line in the modified file.

### To see the diff in a side-by-side format, you can use the `-y` flag:

`diff -y hello.py also-hello.py`

In the output:

* The lines that are the same in both files are displayed side by side.
* Lines that are different are shown with a `>` symbol indicating the line is only present in one of the files.

## How to Create and Execute Bash scripts

Bash scripts start with a **shebang**. **Shebang** is a combination of bash `#` and bang `!` followed by the **bash
shell path**.

`#!/bin/bash`

You can find your bash shell path (which may vary from the above) using the command:

`which bash`

### Creating your first bash script

1. #!/bin/bash
2. echo "Today is " `date`
3.
4. echo -e "\nenter the path to directory"
5. read the_path
6.
7. echo -e "\n you path has the following files and folders: "
8. ls $the_path


* Line #1: The shebang (`#!/bin/bash`) points toward the bash shell path.
* Line #2: The `echo` command displays the current date and time on the terminal. Note that the `date` is in backticks.
* Line #4: We want the user to enter a valid path.
* Line #5: The `read` command reads the input and stores it in the variable `the_path`.
* line #8: The `ls` command takes the variable with the stored path and displays the current files and folders.

### Executing the bash script
To make the script executable, assign execution rights to your user using this command:

`chmod u+x run_all.sh`

Here,

* `chmod` modifies the ownership of a file for the current user :`u`.
* `+x` adds the execution rights to the current user. This means that the user who is the owner can now run the script.
* `run_all.sh` is the file we wish to run.

You can run the script using any of the mentioned methods:

* `sh run_all.sh`
* `bash run_all.sh`
* `./run_all.sh`
