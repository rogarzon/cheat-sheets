# Commands

* Show roles: `\du`
* Show tables: `\dt`
* Show databases: `\l`
* Connect to a database: `\c <database>`
* Show columns of a table: `\d <table> or \d+ <table>`
* Quit: `\q`

# Cambiar a la cuenta de postgres

> `sudo -i -u postgres`

# Acceder a una línea de comandos de Postgres sin cambiar de cuenta

> `sudo -u postgres psql`

# Hacer un backup comprimido

`pg_dump --verbose --dbname=bps --username=postgres | gzip > bps-dump.sql.gz`

> Nota: Debe de estar instalado el gzip, ya sea instalando git el cual lo hace automáticamente u otra via.


> **Usar sin contraseña:**
>
>> First, create a password file (e.g., **~/.pgpass**) with the following content:
>>
>> `127.0.0.1:5432:grp_test_2023_09_01:odoo:odoo`
>>
>> chmod 600 ~/.pgpass

# Restaurar de un backup comprimido

`zcat grp_test.2023-09-01-test.sql.gz | psql --username=odoo --host="127.0.0.1" --port=5432 
--dbname=grp_test_2023_09_01 --no-password`

