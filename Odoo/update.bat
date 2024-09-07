@echo off
setlocal enabledelayedexpansion
set IGNORE_DEPENDENCIES=true

set DB_USER=odoo
set DB_PWD=odoo
set DB=grp_test_2023_11_28
REM set MODULES=  (Leave this line blank for no modules)
REM set MODULES=hr_attendance_pro,grp_compras_estatales,bps_int_proveedores,bps_viaticos,version_number,grp_contrato_proveedores,bps_int_proveedores,bps_plan_anual_compras
set MODULES=bps_carrera_horizontal,hr_attendance_pro
set CONF=C:\Users\rgarzon\Documents\Odoo\BPS\bps.conf
set OPENERP_SERVER=C:\Users\rgarzon\Documents\Odoo\Server\odoo-bps
set PYTHON=C:\Python27\python.exe

cd %OPENERP_SERVER%

if "%IGNORE_DEPENDENCIES%"=="true" (
  REM Convert comma-separated string to array for SQL statement
  set "sqlModulesArray="
  for %%I in (%MODULES%) do (
    set "sqlModulesArray=!sqlModulesArray! '%%I',"
  )
  set "sqlModulesArray=!sqlModulesArray:~0,-1!"

  REM Update state in the database
  set PGPASSWORD=%DB_PWD%
  psql -U %DB_USER% -d %DB% -c "update ir_module_module set state='to upgrade' where name in (!sqlModulesArray!)"

  REM Run Odoo without update to use database state
  %PYTHON% openerp-server --config %CONF% -d %DB% --stop-after-init
) else (
  %PYTHON% openerp-server --config %CONF% -d %DB% -u %MODULES% --stop-after-init
)
endlocal