<!-- TOC -->
* [PostgreSQL](#postgresql)
  * [Install PostgreSQL Linux](#install-postgresql-linux)
    * [PostgreSQL Apt Repository](#postgresql-apt-repository)
    * [Install PostgreSQL 16](#install-postgresql-16)
    * [Configure PostgreSQL server](#configure-postgresql-server)
  * [Connect to the PostgreSQL database server](#connect-to-the-postgresql-database-server)
<!-- TOC -->

# PostgreSQL

## [Install PostgreSQL Linux](https://www.postgresql.org/download/linux/ubuntu/)

### PostgreSQL Apt Repository
**Automated repository configuration:**
```
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

**To manually configure the Apt repository, follow these steps:**
```
# Import the repository signing key:
sudo apt install curl ca-certificates
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Update the package lists:
sudo apt update

# Install the latest version of PostgreSQL:
# If you want a specific version, use 'postgresql-16' or similar instead of 'postgresql'
sudo apt -y install postgresql
```

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

```postgresql
CREATE ROLE username WITH LOGIN PASSWORD 'password';
ALTER ROLE username WITH LOGIN;
ALTER ROLE username WITH CREATEDB;
ALTER ROLE username WITH REPLICATION;
GRANT CONNECT ON DATABASE dbname TO username;
REVOKE privilege_type ON object FROM username;
REVOKE CONNECT ON DATABASE dbname FROM username;


```
