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
* [Java](#java)
  * [Installing Java](#installing-java)
    * [How to install Oracle JDK 11](#how-to-install-oracle-jdk-11)
    * [Download the Oracle JDK file](#download-the-oracle-jdk-file)
    * [Extract The File To A New “JVM” Directory](#extract-the-file-to-a-new-jvm-directory)
    * [Configure The Java Installation](#configure-the-java-installation)
    * [Inform the System About the Location of the Java Installation](#inform-the-system-about-the-location-of-the-java-installation)
    * [Verify if Everything is Working Properly](#verify-if-everything-is-working-properly)
  * [Uninstalling Java](#uninstalling-java)
    * [Uninstall OpenJDK](#uninstall-openjdk)
    * [Uninstall OracleJDK](#uninstall-oraclejdk)
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

El comando anterior crea un directorio llamado '**directorio**' en el directorio actual, que contiene pip, intérprete, scripts y bibliotecas.

### Activando entorno virtual

Tú puedes ahora activar el entorno virtual, escribe:

`source <directorio>/bin/activate`

### Desactivar entorno virtual

`(<directorio>) oltjano@ubuntu:~ deactivate`

## How to create python2.7 virtualenv

#### Install python2:

Universe repository is being used for this. You could add it if not added the next way: `sudo add-apt-repository universe`.

`sudo apt install python2 virtualenv`

### Create virtual environment using python2.7 the next way:

`virtualenv --python=$(which python2) /path/to/newenv/folder/`

`$(which python2)` will return path to python2 which would be correct argument.

# Java

## Installing Java

https://www.fosslinux.com/41519/how-to-install-java-on-pop_os.htm

To install Java on your system, you can type in the following command:

`sudo apt update` \
`sudo apt install default-jre` \
`sudo apt install default-jdk`

With both JDK and JRE installed, you will be able to run all Java-based software on your system

To make sure that Java is correctly installed on your system, enter the same command as before:

`java -version`

To verify that JDK has been appropriately configured, you can check the version of the Java compiler on your system using this command:

`javac -version`

### How to install Oracle JDK 11

OpenJDK should be enough to help you run most Java-based applications on Pop!_OS. However, some software requires you to have the official Oracle Java
Development Kit (JDK) installed on your system.

### Download the Oracle JDK file

First, you will need to head on over to
the [official Oracle JDK website](https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html) and download the latest JDK:
jdk-11.0.7_linux-x64_bin.tar.gz

### Extract The File To A New “JVM” Directory

`sudo mkdir /usr/lib/jvm` \
`cd /usr/lib/jvm` \
`sudo tar -xvzf ~/Downloads/jdk-11.0.7_linux-x64_bin.tar.gz`

### Configure The Java Installation

Next, you will need to configure your system so that Oracle JDK 11 runs smoothly. To do this, first, you will need to open the environment variables
files by entering this command in the terminal:

`sudo nano /etc/environment`

After opening the file, you will need to alter the existing **PATH** folder by adding the following bin folder:

`/usr/lib/jvm/jdk-11.0.7/bin`

Make sure that colons separate the PATH variables. Once done, add this environment variable at the end of the file:

`JAVA_HOME="/usr/lib/jvm/jdk-11.0.7"`

### Inform the System About the Location of the Java Installation

Next, you will need to inform your system where Java is installed on your system. To do this, enter the following command in your terminal:

`sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-11.0.7/bin/java" 0` \
`sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-11.0.7/bin/javac" 0` \
`sudo update-alternatives --set java /usr/lib/jvm/jdk-11.0.7/bin/java` \
`sudo update-alternatives --set javac /usr/lib/jvm/jdk-11.0.7/bin/javac`

### Verify if Everything is Working Properly

To finalize the installation of your Oracle JDK 11, it is time to run some commands to see if everything is working correctly.

First, let’s see if the system prints the location of Java and javac as we configured in the previous steps. To do this, enter the following commands
in the terminal:

`update-alternatives --list java` \
`update-alternatives --list javac`

## Uninstalling Java

We just went over how you can install both OpenJDK and Oracle JDK on your Pop!_OS system. To complete the tutorial, let’s also go over how you can
uninstall these packages as well.

### Uninstall OpenJDK

Since you already have Oracle JDK installed, you might want to uninstall OpenJDK from your system. This can be quickly done by entering the following
command in the terminal:

`sudo apt-get purge --auto-remove openjdk*`

This will remove OpenJDK along with all its dependencies and configuration files.

### Uninstall OracleJDK

Instead of removing OpenJDK, you might want to remove Oracle JDK. To do this, you need to enter the following commands.

`sudo update-alternatives --remove "java" "/usr/lib/jvm/jdk[version]/bin/java"`
`sudo update-alternatives --remove "javac" "/usr/lib/jvm/jdk[version]/bin/javac"`




