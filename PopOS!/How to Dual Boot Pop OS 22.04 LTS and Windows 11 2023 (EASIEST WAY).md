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
> presionar la letra `(t)` para aumentar el tiempo.

> **Nota:** Creo que ya al PopOS al instalar monto dicho menu, pero el tiempo era demasiado rapido comopara poder elegir

# "Menú GRUB no se muestra directamente: consola intermedia con 'set pager=1'"

El problema era que el directorio `/etc/grub.d/` estaba vacío (solo tenía una copia de seguridad en `/etc/grub.d.bak/`).
Al copiar los scripts de respaldo, `update-grub` ya pudo generar el archivo de configuración correctamente.

## Resumen de lo que pasó:

1. El menú de GRUB mostraba una consola con `set pager=1` porque el archivo `grub.cfg` estaba corrupto o vacío
2. El directorio `/etc/grub.d/` no existía - solo había una copia de seguridad en `/etc/grub.d.bak/`
3. Copiaste los scripts de respaldo y ejecutaste `update-grub`
4. Ahora el archivo `grub.cfg` tiene el contenido correcto con el menú de arranque

Ejecuta cat `/boot/grub/grub.cfg | head -50` para verificar y luego reinicia para confirmar que el menú se muestra
correctamente.

### Verificación adicional:

Para asegurarte de que las entradas de Windows y Linux están presentes en el menú, puedes ejecutar:

```bash
grep -E "menuentry|submenu" /boot/grub/grub.cfg
```

Esto debería mostrarte las entradas de menú para Linux y Windows.

Para solucionar el problema original de la consola intermedia con `set pager=1`: Si después de esto sigues viendo la
consola antes del menú, el problema podría estar en que GRUB está usando modo texto en lugar de gráfico. Verifica
que en `/etc/default/grub` tengas:

`GRUB_TERMINAL_OUTPUT=gfxterm`

Y que no esté comentado. Luego ejecuta:

```bash
sudo update-grub
```

Si aún sigues viendo la consola con `set pager=1`, puede que GRUB esté cayendo en modo texto por un error de detección
de vídeo. En ese caso, ejecuta:

### Descomentar y forzar modo gráfico

```bash
sudo sed -i 's/#GRUB_TERMINAL=console/GRUB_TERMINAL_OUTPUT=gfxterm/' /etc/default/grub
sudo update-grub
```
