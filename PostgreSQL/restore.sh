#!/bin/bash
DB_USER="odoo"
DB_PWD="odoo"
DB="grp_test.2024-05-09-test"
HOST="127.0.0.1"
PORT=5432
FILE_PATH="/home/rogarzon/Descargas/"
FILE_NAME="grp_test.2024-05-09-test.sql.gz"

cd ${FILE_PATH}

zcat ${FILE_NAME} | PGPASSWORD=${DB_PWD} psql --username=${DB_USER} --host=${HOST} --port=${PORT} ${DB}

#PGPASSWORD=${DB_PWD} pg_restore --verbose --username=${DB_USER} --dbname=${DB} --host=${HOST} --jobs=6  --no-owner --no-privileges --format=directory  ${FILE_PATH}