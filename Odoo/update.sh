#!/bin/bash

#IGNORE_DEPENDENCIES=true
IGNORE_DEPENDENCIES=false

DB_USER="odoo"
DB_PWD="odoo"
DB="grp_test.2024-05-09-test"
#MODULES="" # Continuar la actualizacion pendiente si IGNORE_DEPENDENCIES=true
MODULES="all"
CONF="/home/rogarzon/Develop/odoo/BPS/project/bps.conf"
OPENERP_SERVER="/home/rogarzon/Develop/odoo/9.0/odoo-server-bps/openerp-server"

cd /opt/venv/9.0/bin/

if [ "$IGNORE_DEPENDENCIES" = true ]; then
  # Convertir el string separado por coma a un array en formato para la sentencia SQL
  modulesArray=(${MODULES//,/ })
  aux=${modulesArray[*]}
  sqlModulesArray="('${aux// /\',\'}')"

  # Actualizar el estado en la BD
  PGPASSWORD=${DB_PWD} psql -U ${DB_USER} -d ${DB} -c "update ir_module_module set state='to upgrade' where name in ${sqlModulesArray}"

  # Ejecutar odoo sin update para que use el estado de la BD
  ./python2 ${OPENERP_SERVER} --config ${CONF} -d ${DB} --stop-after-init
else
  ./python2 ${OPENERP_SERVER} --config ${CONF} -d ${DB} -u ${MODULES} --stop-after-init
fi

