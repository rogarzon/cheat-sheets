# FIX Windows corruption errors with DISM & SFC tools.

1. Open command prompt as administrator. To do that:

   `Dism.exe /Online /Cleanup-Image /Restorehealth`

2. Be patient until DISM repairs the component store. When the operation is completed, (you should be informed that the
   component store corruption was repaired), give this command and press Enter:

   `SFC /SCANNOW`

3. When SFC scan is completed, restart your computer.

# Cómo saber la versión de PowerShell

Abrir la consola de PowerShel y ejecuta el siguiente comando:

`$PSVersionTable.PSVersion`

# Activate .NET Feature

`Dism /online /enable-feature /featurename:NetFX3 /All /Source:D:\sources\sxs /LimitAccess`

# How to know Motherboard model

`wmic baseboard get product,Manufacturer,version,serialnumber`

# Activar Windows 10 con el método de CMD, sin programas.

1. slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
2. slmgr /skms kms.digiboy.ir      o      kms.msguides.com
3. slmgr /ato

* Windows 10 Home: TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
* Windows 10 Home N: 3KHY7-WNT83-DGQKR-F7HPR-844BM
* Windows 10 Home Single Language: 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
* Windows 10 Home Country Specific: PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
* Windows 10 Professional: W269N-WFGWX-YVC9B-4J6C9-T83GX
* Windows 10 Professional N: MH37W-N47XK-V7XM9-C7227-GCQG9
* Windows 10 Enterprise: NPPR9-FWDCX-D2C8J-H872K-2YT43
* Windows 10 Enterprise N: DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
* Windows 10 Education: NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
* Windows 10 Education N: 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
* Windows 10 Enterprise 2015 LTSB: WNMTR-4C88C-JK8YV-HQ7T2-76DF9
* Windows 10 Enterprise 2015 LTSB N: 2F77B-TNFGY-69QQF-B8YKP-D69TJ

