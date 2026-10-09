# Run Emulator

Ejecutar el emulador desde la terminal:

```bash
    D:\WORK\Android\Sdk_win\tools> ./emulator -avd Pixel_6_API_33
```

# Configurar Variables de Entorno

Adicionar al final del fichero `~/.bashrc` o `~/.zshrc` las siguientes líneas:

```bash
export ANDROID_HOME="$HOME/Android/Sdk" # O la ruta correcta
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
```

Guarda el archivo y ejecuta

```bash
source ~/.bashrc
```


# Violación de Segmento en el Emulador de Android (Pop!_OS / Ubuntu)

```bash
QT_QPA_PLATFORM=xcb ANDROID_EMULATOR_USE_SYSTEM_LIBS=1 emulator -avd Medium_Phone_API_37.2 -feature -Vulkan
```

#  Desactivar Vulkan y forzar Renderizado por Software
```bash
export QT_QPA_PLATFORM=xcb 
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
emulator -avd Medium_Phone_API_37 -feature -Vulkan -gpu software
```