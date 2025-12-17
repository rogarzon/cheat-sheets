<!-- TOC -->
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

# Java

## [Installing Java](https://www.fosslinux.com/41519/how-to-install-java-on-pop_os.htm)

To install Java on your system, you can type in the following command:

```
sudo apt update
sudo apt install default-jre
sudo apt install default-jdk
```

With both JDK and JRE installed, you will be able to run all Java-based software on your system

To make sure that Java is correctly installed on your system, enter the same command as before:

`java -version`

To verify that JDK has been appropriately configured, you can check the version of the Java compiler on your system
using this command:

`javac -version`

### How to install Oracle JDK 11

OpenJDK should be enough to help you run most Java-based applications on Pop!_OS. However, some software requires you to
have the official Oracle Java
Development Kit (JDK) installed on your system.

### Download the Oracle JDK file

First, you will need to head on over to
the [official Oracle JDK website](https://www.oracle.com/java/technologies/downloads/) and download the latest JDK:
jdk-11.0.7_linux-x64_bin.tar.gz

### Extract The File To A New “JVM” Directory

```
sudo mkdir /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf ~/Downloads/jdk-11.0.7_linux-x64_bin.tar.gz
```

### Configure The Java Installation

Next, you will need to configure your system so that Oracle JDK 11 runs smoothly. To do this, first, you will need to
open the environment variables files by entering this command in the terminal:

`sudo nano /etc/environment`

After opening the file, you will need to alter the existing **PATH** folder by adding the following bin folder:

`/usr/lib/jvm/jdk-11.0.7/bin`

Make sure that colons separate the PATH variables. Once done, add this environment variable at the end of the file:

`JAVA_HOME="/usr/lib/jvm/jdk-11.0.7"`

### Inform the System About the Location of the Java Installation

Next, you will need to inform your system where Java is installed on your system. To do this, enter the following
command in your terminal:

```
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-11.0.7/bin/java" 0
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-11.0.7/bin/javac" 0
sudo update-alternatives --set java /usr/lib/jvm/jdk-11.0.7/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk-11.0.7/bin/javac
```

### Verify if Everything is Working Properly

To finalize the installation of your Oracle JDK 11, it is time to run some commands to see if everything is working
correctly.

First, let’s see if the system prints the location of Java and javac as we configured in the previous steps. To do this,
enter the following commands in the terminal:

```
update-alternatives --list java
update-alternatives --list javac
```

## Uninstalling Java

We just went over how you can install both OpenJDK and Oracle JDK on your Pop!_OS system. To complete the tutorial,
let’s also go over how you can uninstall these packages as well.

### Uninstall OpenJDK

Since you already have Oracle JDK installed, you might want to uninstall OpenJDK from your system. This can be quickly
done by entering the following command in the terminal:

`sudo apt-get purge --auto-remove openjdk*`

This will remove OpenJDK along with all its dependencies and configuration files.

### Uninstall OracleJDK

Instead of removing OpenJDK, you might want to remove Oracle JDK. To do this, you need to enter the following commands.

```
sudo update-alternatives --remove "java" "/usr/lib/jvm/jdk[version]/bin/java"
sudo update-alternatives --remove "javac" "/usr/lib/jvm/jdk[version]/bin/javac"
```
