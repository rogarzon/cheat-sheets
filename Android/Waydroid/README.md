# [Waydroid](https://waydro.id/)

## Error en PopOS! 22.04
Al instalar Waydroid en PopOS! 22.04, puede que te encuentres con el siguiente error a la hora de descargar la imagen de Android:

> _Failed to load binder driver modprobe: FATAL: Module binder_linux not found in directory /lib/modules/6.12.10-76061203-generic Binder node "binder" for waydroid not found_

## **[Solución](anbox-modules)**: 
Fuente: https://www.youtube.com/watch?v=oPT7cAvXgbM

Clonar el repositorio https://github.com/choff/anbox-modules y ejecutar el siguiente comando:

```bash
sudo ./INSTALL.sh
```
Para desinstalarlo, ejecutar el siguiente comando:

```bash
sudo ./UNINSTALL.sh
```
    
## Instalar, ejecutar aplicaciones ARM y otras cosas
Hay que instalar la librería `libhoudini`, para eso se usa el repositorio: ([waydroid_script](waydroid_script)) https://github.com/casualsnek/waydroid_script