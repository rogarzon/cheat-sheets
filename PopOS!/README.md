<!-- TOC -->
* [Mostrar * al escribir contraseña:](#mostrar--al-escribir-contraseña)
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
