<!-- TOC -->
* [MongoDB](#mongodb)
  * [Install MongoDB Community Edition on Ubuntu](#install-mongodb-community-edition-on-ubuntu)
    * [Import the Public Key](#import-the-public-key)
    * [Create the List File](#create-the-list-file)
    * [Reload the Package Database](#reload-the-package-database)
    * [Install MongoDB Community Server](#install-mongodb-community-server)
      * [Last Release](#last-release)
      * [Specific Release](#specific-release)
    * [Run MongoDB Community Edition](#run-mongodb-community-edition)
      * [Directories](#directories)
    * [Configuration File](#configuration-file)
    * [Init System](#init-system)
      * [systemd (systemctl)](#systemd-systemctl)
      * [System V Init (service)](#system-v-init-service)
  * [Uninstall MongoDB Community Edition](#uninstall-mongodb-community-edition)
<!-- TOC -->

# MongoDB

## [Install MongoDB Community Edition on Ubuntu](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

Use this tutorial to install MongoDB 8.0 Community Edition on LTS (long-term support) releases of Ubuntu Linux using the `apt` package manager.

### Import the Public Key

From a terminal, install `gnupg` and `curl` if they are not already available:

`sudo apt install gnupg curl`

To import the MongoDB public GPG key, run the following command:

```
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
   ```

### Create the List File

Create the list file `/etc/apt/sources.list.d/mongodb-org-8.0.list` for your version of Ubuntu.

```
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] \ 
https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | \ 
sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

### Reload the Package Database

Issue the following command to reload the local package database:

`sudo apt-get update`

### Install MongoDB Community Server

You can install either the latest stable version of MongoDB or a specific version of MongoDB.

#### Last Release

To install the latest stable version, issue the following

`sudo apt-get install -y mongodb-org`

#### Specific Release

To install a specific release, you must specify each component package individually along with the version number, as in the following example:

```
sudo apt-get install -y mongodb-org=8.0.0 mongodb-org-database=8.0.0 mongodb-org-server=8.0.0 \ 
mongodb-mongosh=8.0.0 mongodb-org-mongos=8.0.0 mongodb-org-tools=8.0.0
```

### Run MongoDB Community Edition

#### Directories

If you installed through the package manager, the data directory `/var/lib/mongodb` and the log directory `/var/log/mongodb` are created during the
installation.

By default, MongoDB runs using the mongodb user account

### Configuration File

The official MongoDB package includes
a [configuration file](https://www.mongodb.com/docs/manual/reference/configuration-options/#std-label-conf-file) (`/etc/mongod.conf`)

### Init System

If you are unsure which init system your platform uses, run the following command:

`ps --no-headers -o comm 1`

Then select the appropriate tab below based on the result:

* `systemd` - select the **systemd (systemctl)** tab below.
* `init` - select the **System V Init (service)** tab below.

#### systemd (systemctl)

1. Start MongoDB.

   You can start the mongod process by issuing the following command:

   `sudo systemctl start mongod`

   If you receive an error similar to the following when starting mongod:

   Run the following command first:

   `sudo systemctl daemon-reload`

   Then run the start command above again.

2. Verify that MongoDB has started successfully.

   `sudo systemctl status mongod`

   You can optionally ensure that MongoDB will start following a system reboot by issuing the following command:

   `sudo systemctl enable mongod`

3. Stop MongoDB.

   As needed, you can stop the mongod process by issuing the following command:

   `sudo systemctl stop mongod`

4. Restart MongoDB.

   You can restart the mongod process by issuing the following command:

   `sudo systemctl restart mongod`

#### System V Init (service)

1. Start MongoDB.

   `sudo service mongod start`

2. Verify that MongoDB has started successfully

   `sudo service mongod status`

3. Stop MongoDB

   `sudo service mongod stop`

4. Restart MongoDB.

   `sudo service mongod restart`

## Uninstall MongoDB Community Edition

1. Stop MongoDB.

   `sudo service mongod stop`

2. Remove Packages.

   `sudo apt-get purge mongodb-org*`

3. Remove Data Directories.
   ```
    sudo rm -r /var/log/mongodb
    sudo rm -r /var/lib/mongodb
   ```
