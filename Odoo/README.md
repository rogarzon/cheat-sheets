<!-- TOC -->
* [Desisntalar un módulo mediante CLI](#desisntalar-un-módulo-mediante-cli)
* [Debuggear odoo en vscode](#debuggear-odoo-en-vscode)
<!-- TOC -->

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