<!-- TOC -->
* [Mostrar * al escribir contraseña:](#mostrar--al-escribir-contraseña)
* [Personalización:](#personalización)
* [Ver qué tarjeta gráfica se está usando:](#ver-qué-tarjeta-gráfica-se-está-usando)
* [How to tell if your system is EFI-based or legacy boot?](#how-to-tell-if-your-system-is-efi-based-or-legacy-boot)
* [Hybrid](#hybrid)
* [From the command line](#from-the-command-line)
<!-- TOC -->


# Mostrar * al escribir contraseña:
1. `sudo nano /etc/sudoers`
2. Buscar la línea `Defaults        env_reset`
3. Añadir `,pwfeedback` al final de la línea
4. Guardar y salir

# Personalización:
1. Instalar de la tienda de PopOS! Gestor de extensiones
2. Habilitar Wayland
    1. `sudo nano /etc/gdm3/custom.conf`
    2. Cambiar a `WaylandEnable=true` en la sección `[daemon]`
    3. Guardar y reiniciar con `sudo reboot`
3. Instalar `gnome-tweaks` y `gnome-shell-extensions` de la tienda de PopOS!
4. Abrir extension-manager
5. Instalar las extensiones:
    1. Dash to Panel
    2. [Arc Menu](https://extensions.gnome.org/extension/3628/arcmenu/)
6. Personalizar la consola:
   1. Cambiarse al usuario con `sudo su - <user>`
   2. Abrir el archivo `~/.bashrc` y buscar la línea `PS1=` debajo de `if [ "$color_prompt" = yes ]; then`
   3. Modificar la línea `PS1` para cambiar los colores usando el sitio web [https://bash-prompt-generator.org/](https://bash-prompt-generator.org/), se pueden agregar o remover elementos.
   4. Copiar el contenido de la línea `PS1` y pegarlo en el sitio web.
   5. Modificar los colores y copiar el resultado.
   6. Pegarlo en el archivo `~/.bashrc` en la línea `PS1=`.
      * `PS1='\[\e[38;5;39m\]┌──\[\e[38;5;208;1;3m\]${debian_chroot:+($debian_chroot)}\[\e[23;38;5;51m\]\u\[\e[38;5;202m\]@\[\e[38;5;41m\]\h\[\e[38;5;202m\]:\[\e[93m\][\[\e[38;5;39m\]\w\[\e[93m\]]\n\[\e[38;5;39m\]└─\[\e[38;5;51m\]\$\[\e[0m\] '`
      * Configuración normal:
      * `PS1='┌──${debian_chroot:+($debian_chroot)}\u@\h:\w\n└─\$ '`
   7. Descomentar la línea `force_color_prompt=yes` si está comentada. _Paso necesario si el usuario es el **root**._
   8. Guardar el archivo.
   9. Ejecutar el comando `source ~/.bashrc` para aplicar los cambios.
 


# Ver qué tarjeta gráfica se está usando:
`lspci -k | grep -A 2 -E "(VGA|3D)"`

# How to tell if your system is EFI-based or legacy boot?
`[ -d /sys/firmware/efi ] && echo "Installed in UEFI mode" || echo "Installed in Legacy mode"`

# Hybrid
Hybrid graphics mode uses both the integrated GPU and the discrete NVIDIA GPU. Applications will use the integrated GPU unless explicitly requested to use the discrete GPU.

Vulkan applications must be launched with this command to be rendered on the dGPU (NVIDIA):

`__NV_PRIME_RENDER_OFFLOAD=1 <application>`

GLX applications must be launched with this command to be rendered on the dGPU (NVIDIA):

`__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia <application>`

# From the command line
If you are not using the GNOME Desktop Environment, you can use the system76-power command line tool. You can see the options with this command:
`system76-power help`

For seeing which graphics mode the system is using:
`sudo system76-power graphics`

For switching to NVIDIA graphics:
`sudo system76-power graphics nvidia`

For switching to integrated graphics:
`sudo system76-power graphics integrated`

For switching to hybrid graphics:
`sudo system76-power graphics hybrid`

For switching to compute mode:
`sudo system76-power graphics compute`