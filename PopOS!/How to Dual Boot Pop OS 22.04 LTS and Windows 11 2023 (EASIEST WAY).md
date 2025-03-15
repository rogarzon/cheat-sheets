# [How to Dual Boot Pop OS 22.04 LTS and Windows 11 2023 (EASIEST WAY)](https://www.youtube.com/watch?v=qYqPBrTudUY)

`sudo apt update`

`sudo apt install os-prober`

`sudo os-prober`
> /dev/nvme1n1p1@/efi/Microsoft/Boot/bootmgfw.efi:Windows Boot Manager:Windows:efi

**Mustra las particiones**

`lsblk`

**Se nesecita copiar windows boot files de 'nvme1n1p1' para la carpeta POP OS EFI, para ello montar la partición de
windows boot**

`sudo mount /dev/nvme1n1p1 /mnt`

**Mostrar las particiones, la montada de windows dice al final /mnt**

`lsblk`

**Se debe ber la carpeta Microsoft al ejecutar el siguiente comando**

`sudo ls -la /mnt/EFI/`

**Copiar Windows Manager hacia el menu Systemd boot.**

`sudo cp -ax /mnt/EFI/Microsoft /boot/efi/EFI`

`sudo ls -lh /boot/efi/EFI`

**Reiniciar la PC.**

**IMPORTANTE:**

> Cuando ponga la pantalla negra mantener presionada la `barra espaciadora` para que muestre el menu boot de PopOS y
presionar la letra `(t)` para aumentar el tiempo.

> **Nota:** Creo que ya al PopOS al instalar monto dicho menu, pero el tiempo era demasiado rapido comopara poder elegir
