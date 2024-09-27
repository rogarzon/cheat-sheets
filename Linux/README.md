
<!-- TOC -->
* [Python](#python)
  * [Managing Multiple Versions of Python on Ubuntu 18.04](#managing-multiple-versions-of-python-on-ubuntu-1804)
    * [Obligatory updates](#obligatory-updates)
    * [Install Python dependencies](#install-python-dependencies)
    * [Download Python](#download-python)
    * [Get an optimized build of Python](#get-an-optimized-build-of-python)
    * [Build Instructions](#build-instructions)
    * [Installing Alternative Python from Source](#installing-alternative-python-from-source)
    * [Managing Alternative Python Installations](#managing-alternative-python-installations)
    * [Set alternative versions for Python](#set-alternative-versions-for-python)
    * [List installed versions of Python](#list-installed-versions-of-python)
    * [Swapping between versions](#swapping-between-versions)
    * [Install pip3](#install-pip3)
<!-- TOC -->

# Python

## Managing Multiple Versions of Python on Ubuntu 18.04

https://hackersandslackers.com/multiple-versions-python-ubuntu/

1. We want to leave our system version of Python intact.
2. It's best to avoid messing around with your Python PATH whenever possible.
3. We can easily switch the active version of Python on our machine via a convenient CLI.

### Obligatory updates

`sudo apt update && sudo apt upgrade -y`

### Install Python dependencies

`sudo apt-get install build-essential checkinstall`\
`sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev \
 libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev`

The latest version of Python can always be found on the Python Source Releases page on Python.org: \
https://www.python.org/downloads/source/?ref=hackersandslackers.com

### Download Python

`cd /opt`\
`sudo wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz` \
`sudo tar xzf Python-3.8.9.tgz`

The latest version of Python is now downloaded. Now we just need to install it... correctly.

### Get an optimized build of Python

To get an optimized build of Python, ``configure --enable-optimizations``
before you run ``make``.

`cd /<python folder>` \
`sudo ./configure --enable-optimizations`

### Build Instructions

On Unix, Linux, BSD, macOS, and Cygwin::

    ./configure
    make
    make test
    sudo make install

This will install Python as ``python3``.

### Installing Alternative Python from Source

(In case you want to install another python version different thant SO default)

Ubuntu allows us to install additional (AKA: alternative) versions of Python by providing us with the `make altinstall`
command:

`cd Python-3.8.9` \
`sudo ./configure --enable-optimizations` \
`sudo make altinstall`

### Managing Alternative Python Installations

Linux has us covered in this scenario with the update-alternatives command. We can tell Ubuntu that we have a bunch of
alternative versions of the same software on our machine, thus giving us the ability to switch between them easily.
Here's how it works:

### Set alternative versions for Python

`update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1` \
`update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2`

### List installed versions of Python

`update-alternatives --list python` 

/usr/bin/python3.6 \
/usr/local/bin/python3.8

### Swapping between versions

Now we can swap between versions of Python! Run the following:

`update-alternatives --config python`


### Install pip3

`sudo apt install python3-pip` \
`python3.8 -m pip install --upgrade pip`
