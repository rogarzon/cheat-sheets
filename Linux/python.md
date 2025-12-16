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
    * [Cómo crear un entorno virtual Python 3](#cómo-crear-un-entorno-virtual-python-3)
        * [Actualizar el sistema](#actualizar-el-sistema)
        * [Instalar pip para python3](#instalar-pip-para-python3)
        * [Crea un entorno virtual](#crea-un-entorno-virtual)
        * [Activando entorno virtual](#activando-entorno-virtual)
        * [Desactivar entorno virtual](#desactivar-entorno-virtual)
    * [How to create python2.7 virtualenv](#how-to-create-python27-virtualenv)
        * [Install python2:](#install-python2)
        * [Create virtual environment using python2.7 the next way:](#create-virtual-environment-using-python27-the-next-way)

<!-- TOC -->

# Python

## [Managing Multiple Versions of Python on Ubuntu 18.04](https://hackersandslackers.com/multiple-versions-python-ubuntu/)

1. We want to leave our system version of Python intact.
2. It's best to avoid messing around with your Python PATH whenever possible.
3. We can easily switch the active version of Python on our machine via a convenient CLI.

### Obligatory updates

`sudo apt update && sudo apt upgrade -y`

### Install Python dependencies

```
sudo apt-get install build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev
libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
```

The latest version of Python can always be found on the Python Source Releases page on Python.org: \
https://www.python.org/downloads/source/?ref=hackersandslackers.com

### Download Python

```
cd /opt
sudo wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz
sudo tar xzf Python-3.8.9.tgz
```

The latest version of Python is now downloaded. Now we just need to install it... correctly.

### Get an optimized build of Python

To get an optimized build of Python, ``configure --enable-optimizations``
before you run ``make``.

```
cd /<python folder>` 
sudo ./configure --enable-optimizations
```

### Build Instructions

```
On Unix, Linux, BSD, macOS, and Cygwin::

    ./configure
    make
    make test
    sudo make install

This will install Python as python3.
```

### Installing Alternative Python from Source

(In case you want to install another python version different thant SO default)

Ubuntu allows us to install additional (AKA: alternative) versions of Python by providing us with the `make altinstall`
command:

```
cd Python-3.8.9
sudo ./configure --enable-optimizations
sudo make altinstall
```

### Managing Alternative Python Installations

Linux has us covered in this scenario with the update-alternatives command. We can tell Ubuntu that we have a bunch of
alternative versions of the same software on our machine, thus giving us the ability to switch between them easily.
Here's how it works:

### Set alternative versions for Python

```bash
# --install <enlace> <nombre> <ruta> <prioridad>
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 0
update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2 1
```

### List installed versions of Python

`update-alternatives --list python`

/usr/bin/python3.6 \
/usr/local/bin/python3.8

### Swapping between versions

Now we can swap between versions of Python! Run the following:

`update-alternatives --config python`

### Install pip3

```
sudo apt install python3-pip
python3.8 -m pip install --upgrade pip
```

## Cómo crear un entorno virtual Python 3

### Actualizar el sistema

`sudo apt update && sudo apt upgrade -y`

### Instalar pip para python3

`sudo apt install python3-pip`

### Crea un entorno virtual

Vamos primero instalar venv paquete usando el siguiente comando:

`sudo apt install python3-venv`

Ahora, para crear un entorno virtual, escriba:

`python3 -m venv <directorio>`

El comando anterior crea un directorio llamado '**directorio**' en el directorio actual, que contiene pip, intérprete,
scripts y bibliotecas.

### Activando entorno virtual

Tú puedes ahora activar el entorno virtual, escribe:

`source <directorio>/bin/activate`

### Desactivar entorno virtual

`(<directorio>) oltjano@ubuntu:~ deactivate`

## Crear entorno virtual python2.7

### Instalar python2:

```bash
sudo apt install build-essential libssl-dev libbz2-dev libreadline-dev \
libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar -xvf Python-2.7.13.tgz
cd Python-2.7.13
./configure --prefix=/usr/local/python2.7.13
make
sudo make install
# Esto instalará Python 2.7.13 en /usr/local/python2.7.13/bin/python2.7
# O
sudo make altinstall
# Esto instalará Python 2.7.13 en /usr/local/bin/python2.7
```

### Instalar `virtualenv` (necesario para Python 2):

Python 2 no trae venv, así que debes usar `virtualenv`:

```bash
sudo apt install python2-dev
sudo pip2 install virtualenv
```

Si no tienes pip2, instálalo así:

```bash
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
```

### Crear el entorno virtual

Si usas la versión del sistema:

```bash
virtualenv -p python2 venv_py27
source venv_py27/bin/activate
```

Si usas la versión compilada manualmente:

```bash
virtualenv -p /usr/local/python2.7.13/bin/python2.7 venv_py27
source venv_py27/bin/activate
```

### Desactivar el entorno virtual

```bash
deactivate
```