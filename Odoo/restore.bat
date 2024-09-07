@echo off
setlocal enabledelayedexpansion

set DB_USER=odoo
set DB_PWD=odoo
set DB=grp.2024-03-07-preprod
set DB_FILE=grp.2024-03-07-preprod.sql.gz
set DB_FILE_PATH=C:\Users\rgarzon\Downloads\BD\
set PGPASSWORD=%DB_PWD%
set HOST=localhost
set PORT=5432

cd %DB_FILE_PATH%
gzip -dc %DB_FILE% | psql --username=%DB_USER% --host=%HOST% --port=%PORT% --dbname=%DB%

endlocal