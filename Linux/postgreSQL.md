<!-- TOC -->
* [PostgreSQL](#postgresql)
  * [Install PostgreSQL Linux](#install-postgresql-linux)
    * [Add PostgreSQL Repository](#add-postgresql-repository)
    * [Install PostgreSQL 16](#install-postgresql-16)
    * [Configure PostgreSQL server](#configure-postgresql-server)
  * [Connect to the PostgreSQL database server](#connect-to-the-postgresql-database-server)
<!-- TOC -->

# PostgreSQL

## [Install PostgreSQL Linux](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql-linux/)

### Add PostgreSQL Repository

First, update the package index and install the necessary packages:

```
sudo apt update
sudo apt install gnupg2 wget
```

Second, add the PostgreSQL repository:

`sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'`

Third, import the repository signing key:

`curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg`

Finally, update the package list

`sudo apt update`

### Install PostgreSQL 16

First, install PostgreSQL and its contrib modules:

`sudo apt install postgresql-16 postgresql-contrib-16`

Second, start the PostgreSQL service:**

`sudo systemctl start postgresql`

Third, enable PostgreSQL service:

`sudo systemctl enable postgresql`

### Configure PostgreSQL server

PostgreSQL stores the configuration in the `postgresql.conf` file. You can edit the `postgresql.conf` using any text editor such as nano and vim.

`sudo nano /etc/postgresql/16/main/postgresql.conf`

Set the listen_addresses to `*` to allow remote connection:

`listen_addresses = '*'`

Configure PostgreSQL to use md5 password authentication in the `pg_hba.conf` file. This is necessary if you want to enable remote connections :

```
sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/16/main/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/16/main/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/16/main/pg_hba.conf
```

Restart PostgreSQL for the changes to take effect:

`sudo systemctl restart postgresql`

Allow PostgreSQL port through the firewall:

`sudo ufw allow 5432/tcp`

## Connect to the PostgreSQL database server

First, connect to the PostgreSQL server using the `postgres` user:

`sudo -u postgres psql`

Second, set a password for `postgres` user:

`ALTER USER postgres PASSWORD '<password>';`

Quit the **psql** by using the `\q` command:

`\q`

