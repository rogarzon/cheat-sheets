# Run Emulator

D:\WORK\Android\Sdk_win\tools> ./emulator -avd Pixel_6_API_33

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