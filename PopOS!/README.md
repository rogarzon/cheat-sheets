<!-- TOC -->
* [Ubuntu / PopOS 21.04 - Screen blinking](#ubuntu--popos-2104---screen-blinking)
* [Ver qué tarjeta gráfica se está usando:](#ver-qué-tarjeta-gráfica-se-está-usando)
* [How to tell if your system is EFI-based or legacy boot?](#how-to-tell-if-your-system-is-efi-based-or-legacy-boot)
<!-- TOC -->


# Ubuntu / PopOS 21.04 - Screen blinking
https://askubuntu.com/questions/1362829/ubuntu-popos-21-04-screen-blinking

**Solución 1:**
```
nano /etc/defaults/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_psr=0"
sudo update-grub
```
    
**Solución 2:**
**Nota:** Para personas que no usan grub

```
sudo echo "options i915 enable_psr=0" >> /etc/modprobe.d/i915.conf
sudo update-initramfs -c -k $(uname -r)
reboot
```

# Ver qué tarjeta gráfica se está usando:
`lspci -k | grep -A 2 -E "(VGA|3D)"`

# How to tell if your system is EFI-based or legacy boot?
`[ -d /sys/firmware/efi ] && echo "Installed in UEFI mode" || echo "Installed in Legacy mode"`
