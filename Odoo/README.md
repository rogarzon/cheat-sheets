<!-- TOC -->
* [Desisntalar un módulo mediante CLI](#desisntalar-un-módulo-mediante-cli)
* [Debuggear odoo en vscode](#debuggear-odoo-en-vscode)
<!-- TOC -->

# How to install Odoo 17
## Dependencies
```commandline
sudo apt-get update      
sudo apt-get install python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libpq-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev

# If you find errors, force to install the dependencies
sudo apt-get install -f
```

## Install PostgreSQL
```commandline 
sudo apt install postgresql -y
sudo -u postgres createuser --superuser $(whoami)
```

**Note:** If you need RTL support, please install node and rtlcss via the following command:

```commandline
sudo apt-get install nodejs npm -y
sudo npm install -g rtlcss
```

# Desisntalar un módulo mediante CLI

```commandline
cd odoo-server
./odoo-bin shell -d <database> -c <conf>
self.env["ir.module.module"].search([("name", "=", "<module_name>")]).button_immediate_uninstall()
exit()
```

# [Debuggear odoo en vscode](https://www.odoo.com/es_ES/forum/ayuda-1/visual-studio-code-debugging-problem-158333)

```json
{
  "name": "Python",
  "type": "python",
  "request": "launch",
  "stopOnEntry": false,
  "pythonPath": "${config.python.pythonPath}",
  //"program": "${file}", use this to debug opened file.
  "program": "${workspaceRoot}/Path/To/odoo.py",
  "args": [
    "-c ${workspaceRoot}/sampleconfigurationfile.cfg"
  ],
  "cwd": "${workspaceRoot}",
  "console": "externalTerminal",
  "debugOptions": [
    "WaitOnAbnormalExit",
    "WaitOnNormalExit",
    "RedirectOutput"
  ]
}
```