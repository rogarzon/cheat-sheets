<!-- TOC -->
* [Mostrar * al escribir contraseña:](#mostrar--al-escribir-contraseña)
* [Personalización:](#personalización)
* [Ver qué tarjeta gráfica se está usando:](#ver-qué-tarjeta-gráfica-se-está-usando)
* [How to tell if your system is EFI-based or legacy boot?](#how-to-tell-if-your-system-is-efi-based-or-legacy-boot)
<!-- TOC -->


# Mostrar * al escribir contraseña:
1. `sudo nano /etc/sudoers`
2. Buscar la línea `Defaults        env_reset`
3. Añadir `,pwfeedback` al final de la línea
4. Guardar y salir

# Personalización:
1. Instalar de la tienda de PopOS! Gestor de extensiones
2. Habilitar Wayland
2.1. `sudo nano /etc/gdm3/custom.conf`
2.2 Cambiar a `WaylandEnable=true` en la sección `[daemon]`
2.3 Guardar y reiniciar


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