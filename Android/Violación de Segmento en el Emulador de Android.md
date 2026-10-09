# Guía de Solución: Violación de Segmento en el Emulador de Android (Pop!_OS / Ubuntu)

## El Problema
Al intentar iniciar un dispositivo virtual (AVD) con aceleración gráfica por hardware en distribuciones Linux modernas basadas en Ubuntu (como **Pop!_OS 24.04**), el emulador se cierra inesperadamente mostrando el error:
`Violación de segmento ('core' generado)` u `OOM / device offline`.

### ¿Por qué ocurre?
Este fallo es causado por tres conflictos simultáneos entre el SDK de Android y el sistema operativo:
1. **Conflicto de Ventanas (Wayland/X11):** El emulador no se comunica bien con el servidor gráfico moderno de Pop!_OS.
2. **Conflicto de Librerías (`libstdc++`):** El SDK de Android intenta usar sus propias librerías internas antiguas en lugar de las nativas actualizadas de Linux.
3. **Bug en Drivers Gráficos (Vulkan/Mesa):** La implementación de la API Vulkan en los drivers estables de Mesa genera un colapso de memoria al intentar reservar recursos de la GPU.

---

## La Solución Paso a Paso

Para solucionarlo de raíz sin desestabilizar los drivers gráficos del sistema operativo, se debe forzar al emulador a usar el entorno compatible (**X11 + OpenGL**).

### Paso 1: Configurar las Variables de Entorno del Sistema
Este paso obliga al emulador a usar el protocolo de ventanas compatible (`xcb`) y las librerías nativas de tu distribución Linux.

1. Abre tu terminal de Linux.
2. Abre tu archivo de configuración de usuario con un editor de texto:
   ```bash
   nano ~/.bashrc
   ```
3. Ve hasta el final del archivo y añade las siguientes dos líneas:
   ```bash
   export QT_QPA_PLATFORM=xcb
   export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
   ```
4. Guarda el archivo presionando `Ctrl + O`, luego `Enter`. Sal del editor con `Ctrl + X`.
5. Aplica los cambios en tu terminal actual ejecutando:
   ```bash
   source ~/.bashrc
   ```

### Paso 2: Desactivar Vulkan en el Dispositivo Virtual (AVD)
Este paso desactiva la API Vulkan que genera el error y obliga al emulador a usar **OpenGL (host)**, el cual es completamente estable en Pop!_OS.

1. Abre el gestor de archivos y activa la opción **"Mostrar archivos ocultos"** (puedes usar el atajo `Ctrl + H`).
2. Navega a la ruta de configuración de tus dispositivos móviles:
   ```text
   ~/.android/avd/Nombre_De_Tu_Dispositivo.avd/
   ```
   *(Por ejemplo: `Medium_Phone_API_37.2.avd`)*.
3. Busca y abre el archivo **`config.ini`** con cualquier editor de textos.
4. Añade o modifica las siguientes líneas al final del archivo para cambiar el comportamiento gráfico:
   ```ini
   Vulkan = off
   hw.gpu.mode = host
   ```
5. Guarda y cierra el archivo.

### Paso 3: Lanzar el Emulador
Una vez aplicados los pasos anteriores, ya no necesitas usar la consola. Puedes abrir **Android Studio** y presionar el botón de **Play** directamente en el *Device Manager*. El emulador cargará de forma fluida y con aceleración por hardware real utilizando la GPU de tu computadora.


